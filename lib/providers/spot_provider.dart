import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../models/spot_model.dart';
import '../repositories/spot_repository.dart';
import '../services/gemini_service.dart';

final spotRepositoryProvider = Provider<SpotRepository>((ref) {
  return SpotRepository();
});

class SpotListNotifier extends StateNotifier<AsyncValue<List<SpotModel>>> {
  final SpotRepository _repository;

  SpotListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSpots();
  }

  Future<void> loadSpots() async {
    state = const AsyncValue.loading();
    try {
      final spots = await _repository.getLocalSpots();
      state = AsyncValue.data(spots);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSpot(SpotModel spot) async {
    try {
      await _repository.saveSpot(spot);
      await loadSpots();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<int> syncWithCloud() async {
    final syncedCount = await _repository.syncPendingSpots();
    if (syncedCount > 0) {
      await loadSpots();
    }
    return syncedCount;
  }

  Future<int> analyzePendingSpots() async {
    final currentSpots = state.value ?? [];
    // Récupère les spécimens non encore identifiés (confiance à 0)
    final pending = currentSpots.where((s) => s.confidence == 0.0).toList();

    if (pending.isEmpty) return 0;

    final gemini = GeminiService();
    final appDir = await getApplicationDocumentsDirectory();
    int processed = 0;

    for (final spot in pending) {
      try {
        // Reconstitution du chemin d'accès absolu au fichier sur disque
        final fileName = spot.imagePath.split('/').last;
        final absolutePath = '${appDir.path}/$fileName';

        final file = File(absolutePath);
        if (!await file.exists()) continue;

        // Appel à Gemini Vision
        final aiData = await gemini.identifyPlant(absolutePath);

        spot.commonName = aiData['commonName'] ?? spot.commonName;
        spot.scientificName = aiData['scientificName'] ?? spot.scientificName;
        spot.family = aiData['family'] ?? spot.family;
        spot.confidence = (aiData['confidence'] as num?)?.toDouble() ?? 0.85;
        spot.ecologicalNiche =
            aiData['ecologicalNiche'] ?? spot.ecologicalNiche;
        spot.isSynced = false;

        // Mise à jour de l'enregistrement dans Isar
        await _repository.saveSpot(spot);
        processed++;
      } catch (e) {
        // Affiche l'erreur dans la console si Gemini bloque
        // ignore: avoid_print
        print('Erreur analyse IA spot ${spot.id} : $e');
      }
    }

    // Rafraîchit l'affichage de l'herbier avec les nouveaux noms
    if (processed > 0) {
      await loadSpots();
    }
    return processed;
  }
}

final spotListProvider =
    StateNotifierProvider<SpotListNotifier, AsyncValue<List<SpotModel>>>((ref) {
      final repository = ref.watch(spotRepositoryProvider);
      return SpotListNotifier(repository);
    });
