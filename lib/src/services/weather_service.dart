import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$BASE_URL?lat=$lat&lon=$lon&APPID=$apiKey&units=metric&lang=pt_br',
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(response.body);
    }

    throw Exception('Failed to load data');
  }

  Future<(double, double)> getCurrentCity() async {
    await checkPermission();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return (
      position.latitude,
      position.longitude,
    );
  }

  Future<(double, double)> getPositionByCity(String cityName) async {
    try {
      await checkPermission();

      final location = await locationFromAddress(cityName);

      return (
        location.first.latitude,
        location.first.longitude,
      );
    } catch (e) {
      log(e.toString());

      throw Exception(e.toString());
    }
  }

  Future<void> checkPermission() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }
}
