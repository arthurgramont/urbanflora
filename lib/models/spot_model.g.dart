// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSpotModelCollection on Isar {
  IsarCollection<SpotModel> get spotModels => this.collection();
}

const SpotModelSchema = CollectionSchema(
  name: r'SpotModel',
  id: -2749345920550038888,
  properties: {
    r'cloudId': PropertySchema(id: 0, name: r'cloudId', type: IsarType.string),
    r'commonName': PropertySchema(
      id: 1,
      name: r'commonName',
      type: IsarType.string,
    ),
    r'confidence': PropertySchema(
      id: 2,
      name: r'confidence',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'districtName': PropertySchema(
      id: 4,
      name: r'districtName',
      type: IsarType.string,
    ),
    r'ecologicalNiche': PropertySchema(
      id: 5,
      name: r'ecologicalNiche',
      type: IsarType.string,
    ),
    r'family': PropertySchema(id: 6, name: r'family', type: IsarType.string),
    r'humidity': PropertySchema(id: 7, name: r'humidity', type: IsarType.long),
    r'imagePath': PropertySchema(
      id: 8,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(id: 9, name: r'isSynced', type: IsarType.bool),
    r'latitude': PropertySchema(
      id: 10,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 11,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'rainRisk': PropertySchema(
      id: 12,
      name: r'rainRisk',
      type: IsarType.double,
    ),
    r'scientificName': PropertySchema(
      id: 13,
      name: r'scientificName',
      type: IsarType.string,
    ),
    r'temperature': PropertySchema(
      id: 14,
      name: r'temperature',
      type: IsarType.double,
    ),
  },

  estimateSize: _spotModelEstimateSize,
  serialize: _spotModelSerialize,
  deserialize: _spotModelDeserialize,
  deserializeProp: _spotModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'cloudId': IndexSchema(
      id: -1631172865471370506,
      name: r'cloudId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'cloudId',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _spotModelGetId,
  getLinks: _spotModelGetLinks,
  attach: _spotModelAttach,
  version: '3.3.2',
);

int _spotModelEstimateSize(
  SpotModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cloudId.length * 3;
  bytesCount += 3 + object.commonName.length * 3;
  {
    final value = object.districtName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ecologicalNiche.length * 3;
  bytesCount += 3 + object.family.length * 3;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.scientificName.length * 3;
  return bytesCount;
}

void _spotModelSerialize(
  SpotModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cloudId);
  writer.writeString(offsets[1], object.commonName);
  writer.writeDouble(offsets[2], object.confidence);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.districtName);
  writer.writeString(offsets[5], object.ecologicalNiche);
  writer.writeString(offsets[6], object.family);
  writer.writeLong(offsets[7], object.humidity);
  writer.writeString(offsets[8], object.imagePath);
  writer.writeBool(offsets[9], object.isSynced);
  writer.writeDouble(offsets[10], object.latitude);
  writer.writeDouble(offsets[11], object.longitude);
  writer.writeDouble(offsets[12], object.rainRisk);
  writer.writeString(offsets[13], object.scientificName);
  writer.writeDouble(offsets[14], object.temperature);
}

SpotModel _spotModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SpotModel();
  object.cloudId = reader.readString(offsets[0]);
  object.commonName = reader.readString(offsets[1]);
  object.confidence = reader.readDouble(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.districtName = reader.readStringOrNull(offsets[4]);
  object.ecologicalNiche = reader.readString(offsets[5]);
  object.family = reader.readString(offsets[6]);
  object.humidity = reader.readLong(offsets[7]);
  object.id = id;
  object.imagePath = reader.readString(offsets[8]);
  object.isSynced = reader.readBool(offsets[9]);
  object.latitude = reader.readDouble(offsets[10]);
  object.longitude = reader.readDouble(offsets[11]);
  object.rainRisk = reader.readDouble(offsets[12]);
  object.scientificName = reader.readString(offsets[13]);
  object.temperature = reader.readDouble(offsets[14]);
  return object;
}

P _spotModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _spotModelGetId(SpotModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _spotModelGetLinks(SpotModel object) {
  return [];
}

void _spotModelAttach(IsarCollection<dynamic> col, Id id, SpotModel object) {
  object.id = id;
}

extension SpotModelQueryWhereSort
    on QueryBuilder<SpotModel, SpotModel, QWhere> {
  QueryBuilder<SpotModel, SpotModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhere> anyCloudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'cloudId'),
      );
    });
  }
}

extension SpotModelQueryWhere
    on QueryBuilder<SpotModel, SpotModel, QWhereClause> {
  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdEqualTo(
    String cloudId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'cloudId', value: [cloudId]),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdNotEqualTo(
    String cloudId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cloudId',
                lower: [],
                upper: [cloudId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cloudId',
                lower: [cloudId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cloudId',
                lower: [cloudId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cloudId',
                lower: [],
                upper: [cloudId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdGreaterThan(
    String cloudId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'cloudId',
          lower: [cloudId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdLessThan(
    String cloudId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'cloudId',
          lower: [],
          upper: [cloudId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdBetween(
    String lowerCloudId,
    String upperCloudId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'cloudId',
          lower: [lowerCloudId],
          includeLower: includeLower,
          upper: [upperCloudId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdStartsWith(
    String CloudIdPrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'cloudId',
          lower: [CloudIdPrefix],
          upper: ['$CloudIdPrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'cloudId', value: ['']),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterWhereClause> cloudIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'cloudId', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'cloudId', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'cloudId', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'cloudId', upper: ['']),
            );
      }
    });
  }
}

extension SpotModelQueryFilter
    on QueryBuilder<SpotModel, SpotModel, QFilterCondition> {
  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cloudId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cloudId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cloudId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> cloudIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cloudId', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  cloudIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cloudId', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  commonNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'commonName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  commonNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'commonName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> commonNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'commonName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  commonNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'commonName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  commonNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'commonName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> confidenceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  confidenceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> confidenceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'confidence',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> confidenceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'confidence',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> createdAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'districtName'),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'districtName'),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> districtNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> districtNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'districtName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'districtName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> districtNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'districtName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'districtName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  districtNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'districtName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ecologicalNiche',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'ecologicalNiche',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'ecologicalNiche',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ecologicalNiche', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  ecologicalNicheIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'ecologicalNiche', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'family',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'family',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'family',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'family', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> familyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'family', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> humidityEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'humidity', value: value),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> humidityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'humidity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> humidityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'humidity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> humidityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'humidity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> isSyncedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isSynced', value: value),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'latitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'longitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> rainRiskEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rainRisk',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> rainRiskGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rainRisk',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> rainRiskLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rainRisk',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> rainRiskBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rainRisk',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scientificName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'scientificName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'scientificName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scientificName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  scientificNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'scientificName', value: ''),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> temperatureEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'temperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition>
  temperatureGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'temperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> temperatureLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'temperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterFilterCondition> temperatureBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'temperature',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension SpotModelQueryObject
    on QueryBuilder<SpotModel, SpotModel, QFilterCondition> {}

extension SpotModelQueryLinks
    on QueryBuilder<SpotModel, SpotModel, QFilterCondition> {}

extension SpotModelQuerySortBy on QueryBuilder<SpotModel, SpotModel, QSortBy> {
  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCloudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudId', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCloudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudId', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByDistrictName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'districtName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByDistrictNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'districtName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByEcologicalNiche() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ecologicalNiche', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByEcologicalNicheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ecologicalNiche', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByHumidity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidity', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByHumidityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidity', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByRainRisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainRisk', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByRainRiskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainRisk', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> sortByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }
}

extension SpotModelQuerySortThenBy
    on QueryBuilder<SpotModel, SpotModel, QSortThenBy> {
  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCloudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudId', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCloudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudId', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByDistrictName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'districtName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByDistrictNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'districtName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByEcologicalNiche() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ecologicalNiche', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByEcologicalNicheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ecologicalNiche', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByHumidity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidity', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByHumidityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidity', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByRainRisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainRisk', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByRainRiskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainRisk', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QAfterSortBy> thenByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }
}

extension SpotModelQueryWhereDistinct
    on QueryBuilder<SpotModel, SpotModel, QDistinct> {
  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByCloudId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cloudId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByCommonName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByDistrictName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'districtName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByEcologicalNiche({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'ecologicalNiche',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByFamily({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'family', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByHumidity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'humidity');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByImagePath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByRainRisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rainRisk');
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByScientificName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'scientificName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SpotModel, SpotModel, QDistinct> distinctByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperature');
    });
  }
}

extension SpotModelQueryProperty
    on QueryBuilder<SpotModel, SpotModel, QQueryProperty> {
  QueryBuilder<SpotModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> cloudIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cloudId');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> commonNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonName');
    });
  }

  QueryBuilder<SpotModel, double, QQueryOperations> confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<SpotModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SpotModel, String?, QQueryOperations> districtNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'districtName');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> ecologicalNicheProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ecologicalNiche');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> familyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'family');
    });
  }

  QueryBuilder<SpotModel, int, QQueryOperations> humidityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'humidity');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<SpotModel, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<SpotModel, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<SpotModel, double, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<SpotModel, double, QQueryOperations> rainRiskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rainRisk');
    });
  }

  QueryBuilder<SpotModel, String, QQueryOperations> scientificNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scientificName');
    });
  }

  QueryBuilder<SpotModel, double, QQueryOperations> temperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperature');
    });
  }
}
