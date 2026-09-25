import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../models/spot_model.dart';
import '../repositories/spot_repository.dart';
import '../services/gemini_service.dart';

final spotRepositoryProvider = Provider<SpotRepository>((ref) {
  return SpotRepository();
});

final spotListProvider =
    StateNotifierProvider<SpotListNotifier, AsyncValue<List<SpotModel>>>((ref) {
      final repository = ref.watch(spotRepositoryProvider);
      return SpotListNotifier(repository);
    });

class SpotListNotifier extends StateNotifier<AsyncValue<List<SpotModel>>> {
  final SpotRepository _repository;

  SpotListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSpots();
  }

  Future<void> loadSpots() async {
    try {
      final spots = await _repository.getSpots();
      state = AsyncValue.data(spots);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSpot(SpotModel spot) async {
    await _repository.saveSpot(spot);
    await loadSpots();
  }

  Future<void> deleteSpot(SpotModel spot) async {
    await _repository.deleteSpot(spot.id, spot.cloudId);
    await loadSpots();
  }

  Future<void> clearAllSpots() async {
    await _repository.clearAllData();
    await loadSpots();
  }

  Future<int> syncWithCloud() async {
    final count = await _repository.syncAllWithCloud();
    await loadSpots();
    return count;
  }

  Future<int> analyzePendingSpots() async {
    final currentSpots = state.value ?? [];
    final pending = currentSpots.where((s) => s.confidence == 0.0).toList();

    if (pending.isEmpty) return 0;

    final gemini = GeminiService();
    final appDir = await getApplicationDocumentsDirectory();
    int processed = 0;

    for (final spot in pending) {
      try {
        final fileName = spot.imagePath.split('/').last;
        final absolutePath = '${appDir.path}/$fileName';

        final file = File(absolutePath);
        if (!await file.exists()) continue;

        final aiData = await gemini.identifyPlant(absolutePath);

        spot.commonName = aiData['commonName'] ?? spot.commonName;
        spot.scientificName = aiData['scientificName'] ?? spot.scientificName;
        spot.family = aiData['family'] ?? spot.family;
        spot.confidence = (aiData['confidence'] as num?)?.toDouble() ?? 0.85;
        spot.ecologicalNiche =
            aiData['ecologicalNiche'] ?? spot.ecologicalNiche;
        spot.isSynced = false;

        await _repository.saveSpot(spot);
        processed++;
        await loadSpots();
      } catch (e) {
        // ignore: avoid_print
        print('Erreur analyse IA : $e');
      }
    }

    return processed;
  }

  Future<void> reloadForNewUser() async {
    state = const AsyncValue.loading();
    try {
      await _repository.fetchSpotsFromCloud();
      await loadSpots();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
