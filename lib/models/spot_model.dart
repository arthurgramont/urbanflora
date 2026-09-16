import 'package:isar/isar.dart';

part 'spot_model.g.dart';

@collection
class SpotModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String cloudId; // Identifiant unique pour Firestore

  late String commonName; // Nom usuel (ex: Pellitory-of-the-wall)
  late String scientificName; // Nom latin (ex: Parietaria judaica)
  late String family; // Famille botanique (ex: Urticaceae)
  late double confidence; // Taux de confiance Gemini (ex: 0.96)
  late String ecologicalNiche; // Analyse environnementale Gemini
  late String imagePath; // Chemin local du cliché capturé

  late double latitude;
  late double longitude;
  String? districtName; // Ex: Paris 12e

  late double temperature;
  late int humidity;
  late double rainRisk;

  late DateTime createdAt;
  bool isSynced = false; // true si déjà poussé dans Firebase
}