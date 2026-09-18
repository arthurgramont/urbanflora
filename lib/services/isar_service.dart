import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/spot_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _openDatabase();
  }

  Future<Isar> _openDatabase() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [SpotModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  // Récupérer toutes les observations locales (triées par date décroissante)
  Future<List<SpotModel>> getAllSpots() async {
    final isar = await db;
    return await isar.spotModels.where().sortByCreatedAtDesc().findAll();
  }

  // Sauvegarder ou mettre à jour un spot en cache local
  Future<int> saveSpot(SpotModel spot) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.spotModels.put(spot);
    });
  }

  // Récupérer les spots en attente de synchronisation Firebase
  Future<List<SpotModel>> getUnsyncedSpots() async {
    final isar = await db;
    return await isar.spotModels.filter().isSyncedEqualTo(false).findAll();
  }

  // Marquer un spot comme synchronisé
  Future<void> markAsSynced(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final spot = await isar.spotModels.get(id);
      if (spot != null) {
        spot.isSynced = true;
        await isar.spotModels.put(spot);
      }
    });
  }
}
