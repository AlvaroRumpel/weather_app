import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/pages/weather_page.dart';

void main() {
  group('weatherPage', () {
    testWidgets('Displays correct information', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: WeatherPage(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.restart_alt_outlined));

      // Assert
      expect(find.text('Buscando cidade...'), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.textContaining('°C'), findsOneWidget);
      expect(find.text('Buscando dados...'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Buscar'), findsOneWidget);
    });

    testWidgets('Switches to search mode when FloatingActionButton is pressed',
        (WidgetTester tester) async {
      // Arrange
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: WeatherPage(),
        ),
      );

      // Act
      await tester.tap(find.byType(FloatingActionButton));
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      // Assert
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.text('Nome da cidade'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);
    });
  });
}
