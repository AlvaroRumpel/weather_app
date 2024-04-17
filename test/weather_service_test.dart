import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/src/models/weather_condition_enum.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/services/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
  });
  group('weatherService', () {
    group('getWeather', () {
      test('getWeather returns Weather object on success', () async {
        // Arrange

        final weatherResponse = Weather(
          cityName: 'Teste',
          mainCondition: WeatherConditionEnum.clear,
          sunrise: DateTime.now(),
          sunset: DateTime.now(),
          tempMax: 10,
          tempMin: 10,
          temperature: 10,
        );

        when(() => mockWeatherService.getWeather(any(), any()))
            .thenAnswer((_) async => weatherResponse);

        // Act
        final result = await mockWeatherService.getWeather(37.7749, -122.4194);

        // Assert
        expect(result, isNotNull);
        expect(result.temperature, 10);
      });

      test('getWeather throws exception on failure', () async {
        // Arrange

        when(() => mockWeatherService.getWeather(any(), any()))
            .thenAnswer((_) async {
          throw Exception();
        });

        // Act and Assert
        expect(
          mockWeatherService.getWeather(37.7749, -122.4194),
          throwsException,
        );
      });
    });

    group('getCurrentCity', () {
      test('getCurrentCity returns valid position', () async {
        // Arrange
        const latLonResponse = (10.0, 10.0);
        when(() => mockWeatherService.getCurrentCity())
            .thenAnswer((_) async => latLonResponse);

        // Act
        final result = await mockWeatherService.getCurrentCity();

        // Assert
        expect(result, equals(latLonResponse));
      });

      test('getCurrentCity throws exception on failure', () async {
        // Arrange
        when(() => mockWeatherService.getCurrentCity())
            .thenAnswer((_) async => throw Exception());

        // Act and Assert
        expect(
          () => mockWeatherService.getCurrentCity(),
          throwsException,
        );
      });
    });

    group('getPositionByCity', () {
      test('getPositionByCity returns valid position', () async {
        // Arrange

        const latLonResponse = (10.0, 10.0);

        when(() => mockWeatherService.getPositionByCity(any()))
            .thenAnswer((_) async => latLonResponse);

        // Act
        final result = await mockWeatherService.getPositionByCity('Berlin');

        // Assert
        expect(result, equals(latLonResponse));
      });

      test('getPositionByCity throws exception on failure', () async {
        // Arrange

        when(() => mockWeatherService.getPositionByCity(any()))
            .thenAnswer((_) async => throw Exception());

        // Act and Assert
        expect(
          () => mockWeatherService.getPositionByCity(''),
          throwsException,
        );
      });
    });
  });
}
