import 'dart:convert';

import 'weather_condition_enum.dart';

class Weather {
  final String cityName;
  final double temperature;
  final double tempMax;
  final double tempMin;
  final WeatherConditionEnum mainCondition;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.tempMax,
    required this.tempMin,
    required this.mainCondition,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'mainCondition': mainCondition.id,
      'sunrise': sunrise.millisecondsSinceEpoch,
      'sunset': sunset.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      cityName: map['name'] ?? '',
      temperature: map['main']['temp']?.toDouble() ?? 0.0,
      tempMax: map['main']['temp_max']?.toDouble() ?? 0.0,
      tempMin: map['main']['temp_min']?.toDouble() ?? 0.0,
      mainCondition: WeatherConditionEnum.fromId(map['weather'][0]['id'] ?? 0),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (map['sunrise'] ?? 0) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch((map['sunset'] ?? 0) * 1000),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));
}
