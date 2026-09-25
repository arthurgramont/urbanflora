import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/spot_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _openDB();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [SpotModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<int> saveSpot(SpotModel newSpot) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.spotModels.put(newSpot);
    });
  }

  Future<List<SpotModel>> getAllSpots() async {
    final isar = await db;
    return await isar.spotModels.where().sortByCreatedAtDesc().findAll();
  }

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

  Future<void> deleteSpot(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.spotModels.delete(id);
    });
  }

  Future<void> clearAllLocalSpots() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.spotModels.clear();
    });
  }
}
