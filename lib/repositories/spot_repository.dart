import 'package:flutter/foundation.dart';
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

  // Lecture offline-first : on lit toujours depuis la base locale Isar
  Future<List<SpotModel>> getLocalSpots() async {
    return await _isarService.getAllSpots();
  }

  // Sauvegarde locale + synchro Firestore conditionnelle
  Future<void> saveSpot(SpotModel spot) async {
    // 1. Sauvegarde locale immédiate (fonctionne hors-ligne)
    final localId = await _isarService.saveSpot(spot);
    spot.id = localId;

    // 2. Tentative de synchronisation Cloud si un compte est connecté
    try {
      User? user = _auth.currentUser;
      user ??= (await _auth.signInAnonymously()).user;

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
              'latitude': spot.latitude,
              'longitude': spot.longitude,
              'districtName': spot.districtName,
              'temperature': spot.temperature,
              'humidity': spot.humidity,
              'rainRisk': spot.rainRisk,
              'createdAt': spot.createdAt.toIso8601String(),
            });

        // 3. Si l'envoi cloud a réussi, on met à jour le flag local
        await _isarService.markAsSynced(localId);
      }
    } catch (e) {
      debugPrint('Échec synchro Firestore immédiate : $e');
    }
  }

  // Synchronisation manuelle déclenchée depuis le profil ("Sync Now")
  Future<int> syncPendingSpots() async {
    User? user = _auth.currentUser;
    user ??= (await _auth.signInAnonymously()).user;
    if (user == null) return 0;

    final unsyncedSpots = await _isarService.getUnsyncedSpots();
    int syncedCount = 0;

    for (final spot in unsyncedSpots) {
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
      } catch (e) {
        debugPrint('Échec synchro spot ${spot.cloudId} : $e');
        break;
      }
    }
    return syncedCount;
  }
}
