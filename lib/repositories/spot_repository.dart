import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/spot_model.dart';
import '../services/isar_service.dart';

class SpotRepository {
  final IsarService _isarService;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SpotRepository({
    IsarService? isarService,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _isarService = isarService ?? IsarService(),
       _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  Future<List<SpotModel>> getSpots() async {
    return await _isarService.getAllSpots();
  }

  Future<void> saveSpot(SpotModel spot) async {
    final localId = await _isarService.saveSpot(spot);
    spot.id = localId;
    _trySyncInSilence(spot, localId);
  }

  void _trySyncInSilence(SpotModel spot, int localId) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        final authResult = await _auth.signInAnonymously().timeout(
          const Duration(seconds: 2),
        );
        user = authResult.user;
      }

      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('spots')
            .doc(spot.cloudId)
            .set({
              'cloudId': spot.cloudId,
              'commonName': spot.commonName,
              'scientificName': spot.scientificName,
              'family': spot.family,
              'confidence': spot.confidence,
              'ecologicalNiche': spot.ecologicalNiche,
              'imagePath': spot.imagePath,
              'latitude': spot.latitude,
              'longitude': spot.longitude,
              'districtName': spot.districtName,
              'temperature': spot.temperature,
              'humidity': spot.humidity,
              'rainRisk': spot.rainRisk,
              'createdAt': spot.createdAt.toIso8601String(),
            })
            .timeout(const Duration(seconds: 2));

        await _isarService.markAsSynced(localId);
      }
    } catch (_) {}
  }

  Future<int> syncAllWithCloud() async {
    final spots = await _isarService.getAllSpots();
    final unsynced = spots.where((s) => !s.isSynced).toList();
    if (unsynced.isEmpty) return 0;

    User? user = _auth.currentUser;
    user ??= (await _auth.signInAnonymously()).user;
    if (user == null) return 0;

    int syncedCount = 0;
    for (final spot in unsynced) {
      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('spots')
            .doc(spot.cloudId)
            .set({
              'cloudId': spot.cloudId,
              'commonName': spot.commonName,
              'scientificName': spot.scientificName,
              'family': spot.family,
              'confidence': spot.confidence,
              'ecologicalNiche': spot.ecologicalNiche,
              'imagePath': spot.imagePath,
              'latitude': spot.latitude,
              'longitude': spot.longitude,
              'districtName': spot.districtName,
              'temperature': spot.temperature,
              'humidity': spot.humidity,
              'rainRisk': spot.rainRisk,
              'createdAt': spot.createdAt.toIso8601String(),
            });

        await _isarService.markAsSynced(spot.id);
        syncedCount++;
      } catch (_) {}
    }
    return syncedCount;
  }

  Future<void> deleteSpot(int localId, String cloudId) async {
    await _isarService.deleteSpot(localId);

    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('spots')
            .doc(cloudId)
            .delete();
      }
    } catch (_) {}
  }

  Future<void> clearAllData() async {
    await _isarService.clearAllLocalSpots();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        final docs = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('spots')
            .get();
        for (final doc in docs.docs) {
          await doc.reference.delete();
        }
      }
    } catch (_) {}
  }

  Future<void> fetchSpotsFromCloud() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _isarService.clearAllLocalSpots();

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('spots')
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final spot = SpotModel()
        ..cloudId = data['cloudId'] ?? doc.id
        ..commonName = data['commonName'] ?? ''
        ..scientificName = data['scientificName'] ?? ''
        ..family = data['family'] ?? ''
        ..confidence = (data['confidence'] as num?)?.toDouble() ?? 0.0
        ..ecologicalNiche = data['ecologicalNiche'] ?? ''
        ..imagePath = data['imagePath'] ?? ''
        ..latitude = (data['latitude'] as num?)?.toDouble() ?? 0.0
        ..longitude = (data['longitude'] as num?)?.toDouble() ?? 0.0
        ..districtName = data['districtName'] ?? ''
        ..temperature = (data['temperature'] as num?)?.toDouble() ?? 0.0
        ..humidity = (data['humidity'] as num?)?.toInt() ?? 0
        ..rainRisk = (data['rainRisk'] as num?)?.toDouble() ?? 0.0
        ..createdAt =
            DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now()
        ..isSynced = true;

      await _isarService.saveSpot(spot);
    }
  }
}
