import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/spot_model.dart';
import '../repositories/spot_repository.dart';

// Provider du repository des spots
final spotRepositoryProvider = Provider<SpotRepository>((ref) {
  return SpotRepository();
});

// État de la liste de l'herbier
class SpotListNotifier extends StateNotifier<AsyncValue<List<SpotModel>>> {
  final SpotRepository _repository;

  SpotListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSpots();
  }

  // Charge l'ensemble des données locales (Isar DB)
  Future<void> loadSpots() async {
    state = const AsyncValue.loading();
    try {
      final spots = await _repository.getLocalSpots();
      state = AsyncValue.data(spots);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Enregistre un nouveau spécimen (Isar puis Firestore)
  Future<void> addSpot(SpotModel spot) async {
    try {
      await _repository.saveSpot(spot);
      await loadSpots(); // Recharge la liste pour rafraîchir l'UI
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Déclenche la synchronisation manuelle ("Sync Now")
  Future<int> syncWithCloud() async {
    final syncedCount = await _repository.syncPendingSpots();
    if (syncedCount > 0) {
      await loadSpots();
    }
    return syncedCount;
  }
}

// Provider global pour écouter la liste des spots dans les widgets
final spotListProvider =
    StateNotifierProvider<SpotListNotifier, AsyncValue<List<SpotModel>>>((ref) {
      final repository = ref.watch(spotRepositoryProvider);
      return SpotListNotifier(repository);
    });
