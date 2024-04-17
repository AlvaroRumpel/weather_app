import 'dart:convert';

class LocationModel {
  final String key;
  final String type;
  final int rank;
  final String localizedName;
  final String englishName;
  final String primaryPostalCode;
  final AreaModel region;
  final AreaModel country;
  final AreaModel administrativeArea;
  final List<AreaModel> supplementalAdminAreas;
  LocationModel({
    required this.key,
    required this.type,
    required this.rank,
    required this.localizedName,
    required this.englishName,
    required this.primaryPostalCode,
    required this.region,
    required this.country,
    required this.administrativeArea,
    required this.supplementalAdminAreas,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'type': type,
      'rank': rank,
      'localizedName': localizedName,
      'englishName': englishName,
      'primaryPostalCode': primaryPostalCode,
      'region': region.toMap(),
      'country': country.toMap(),
      'administrativeArea': administrativeArea.toMap(),
      'supplementalAdminAreas':
          supplementalAdminAreas.map((x) => x.toMap()).toList(),
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      key: map['key'] ?? '',
      type: map['type'] ?? '',
      rank: map['rank']?.toInt() ?? 0,
      localizedName: map['localizedName'] ?? '',
      englishName: map['englishName'] ?? '',
      primaryPostalCode: map['primaryPostalCode'] ?? '',
      region: AreaModel.fromMap(map['region']),
      country: AreaModel.fromMap(map['country']),
      administrativeArea: AreaModel.fromMap(map['administrativeArea']),
      supplementalAdminAreas: List<AreaModel>.from(
          map['supplementalAdminAreas']?.map((x) => AreaModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));
}

class AreaModel {
  final String id;
  final String localizedName;
  final String englishName;
  final int? level;
  final String? localizedType;
  final String? englishType;
  final String? countryId;
  AreaModel({
    required this.id,
    required this.localizedName,
    required this.englishName,
    this.level,
    this.localizedType,
    this.englishType,
    this.countryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'localizedName': localizedName,
      'englishName': englishName,
      'level': level,
      'localizedType': localizedType,
      'englishType': englishType,
      'countryId': countryId,
    };
  }

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      id: map['id'] ?? '',
      localizedName: map['localizedName'] ?? '',
      englishName: map['englishName'] ?? '',
      level: map['level']?.toInt(),
      localizedType: map['localizedType'],
      englishType: map['englishType'],
      countryId: map['countryId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaModel.fromJson(String source) =>
      AreaModel.fromMap(json.decode(source));
}
