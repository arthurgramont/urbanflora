import 'package:isar_community/isar.dart';

part 'spot_model.g.dart';

@collection
class SpotModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String cloudId;

  late String commonName;
  late String scientificName;
  late String family;
  late double confidence;
  late String ecologicalNiche;
  late String imagePath;

  late double latitude;
  late double longitude;
  String? districtName;

  late double temperature;
  late int humidity;
  late double rainRisk;

  late DateTime createdAt;
  bool isSynced = false;
}
