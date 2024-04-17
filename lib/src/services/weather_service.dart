import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/location_model.dart';
import '../models/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'http://dataservice.accuweather.com/';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String locationKey) async {
    final response = await http.get(
      Uri.parse(
        '${BASE_URL}forecasts/v1/daily/5day/$locationKey?apikey=$apiKey&language=pt-br&metric=true',
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.body);
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

  Future<LocationModel> getLocationKey(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${BASE_URL}locations/v1/cities/geoposition/search?apikey=$apiKey&q=$lat%2C$lon&language=pt-BR',
        ),
      );

      if (response.statusCode == 200) {
        return LocationModel.fromJson(response.body);
      }

      throw Exception('Failed to load data');
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
