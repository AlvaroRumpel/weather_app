import 'dart:convert';

class WeatherModel {
  final HeadlineModel headline;
  final List<DailyForecastsModel> dailyForecast;
  WeatherModel({
    required this.headline,
    required this.dailyForecast,
  });

  Map<String, dynamic> toMap() {
    return {
      'headline': headline.toMap(),
      'dailyForecast': dailyForecast.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      headline: HeadlineModel.fromMap(map['headline']),
      dailyForecast: List<DailyForecastsModel>.from(
        map['dailyForecast']?.map((x) => DailyForecastsModel.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
}

class HeadlineModel {
  final DateTime effectiveDate;
  final int effectiveEpochDate;
  final int severity;
  final String text;
  final String category;
  final DateTime endDate;
  final int endEpochDate;

  HeadlineModel({
    required this.effectiveDate,
    required this.effectiveEpochDate,
    required this.severity,
    required this.text,
    required this.category,
    required this.endDate,
    required this.endEpochDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'effectiveDate': effectiveDate.millisecondsSinceEpoch,
      'effectiveEpochDate': effectiveEpochDate,
      'severity': severity,
      'text': text,
      'category': category,
      'endDate': endDate.millisecondsSinceEpoch,
      'endEpochDate': endEpochDate,
    };
  }

  factory HeadlineModel.fromMap(Map<String, dynamic> map) {
    return HeadlineModel(
      effectiveDate: DateTime.parse(map['effectiveDate']),
      effectiveEpochDate: map['effectiveEpochDate']?.toInt() ?? 0,
      severity: map['severity']?.toInt() ?? 0,
      text: map['text'] ?? '',
      category: map['category'] ?? '',
      endDate: DateTime.parse(map['endDate']),
      endEpochDate: map['endEpochDate']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HeadlineModel.fromJson(String source) =>
      HeadlineModel.fromMap(json.decode(source));
}

class DailyForecastsModel {
  final DateTime date;
  final int epochDate;
  final TemperatureModel temperature;
  final DayModel day;
  final DayModel night;
  DailyForecastsModel({
    required this.date,
    required this.epochDate,
    required this.temperature,
    required this.day,
    required this.night,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'epochDate': epochDate,
      'temperature': temperature.toMap(),
      'day': day.toMap(),
      'night': night.toMap(),
    };
  }

  factory DailyForecastsModel.fromMap(Map<String, dynamic> map) {
    return DailyForecastsModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      epochDate: map['epochDate']?.toInt() ?? 0,
      temperature: TemperatureModel.fromMap(map['temperature']),
      day: DayModel.fromMap(map['day']),
      night: DayModel.fromMap(map['night']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyForecastsModel.fromJson(String source) =>
      DailyForecastsModel.fromMap(json.decode(source));
}

class TemperatureModel {
  final MinMaxModel minimum;
  final MinMaxModel maximum;

  TemperatureModel({
    required this.minimum,
    required this.maximum,
  });

  Map<String, dynamic> toMap() {
    return {
      'minimum': minimum.toMap(),
      'maximum': maximum.toMap(),
    };
  }

  factory TemperatureModel.fromMap(Map<String, dynamic> map) {
    return TemperatureModel(
      minimum: MinMaxModel.fromMap(map['minimum']),
      maximum: MinMaxModel.fromMap(map['maximum']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemperatureModel.fromJson(String source) =>
      TemperatureModel.fromMap(json.decode(source));
}

class MinMaxModel {
  final double value;
  final String unit;
  final int unityType;

  MinMaxModel({
    required this.value,
    required this.unit,
    required this.unityType,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'unit': unit,
      'unityType': unityType,
    };
  }

  factory MinMaxModel.fromMap(Map<String, dynamic> map) {
    return MinMaxModel(
      value: map['value']?.toDouble() ?? 0.0,
      unit: map['unit'] ?? '',
      unityType: map['unityType']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MinMaxModel.fromJson(String source) =>
      MinMaxModel.fromMap(json.decode(source));
}

class DayModel {
  final int icon;
  final String iconPhrase;
  final bool hasPrecipitation;
  DayModel({
    required this.icon,
    required this.iconPhrase,
    required this.hasPrecipitation,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'iconPhrase': iconPhrase,
      'hasPrecipitation': hasPrecipitation,
    };
  }

  factory DayModel.fromMap(Map<String, dynamic> map) {
    return DayModel(
      icon: map['icon']?.toInt() ?? 0,
      iconPhrase: map['iconPhrase'] ?? '',
      hasPrecipitation: map['hasPrecipitation'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayModel.fromJson(String source) =>
      DayModel.fromMap(json.decode(source));
}
