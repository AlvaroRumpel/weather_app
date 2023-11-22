import 'package:flutter/material.dart';

import 'src/pages/weather_page.dart';

part 'src/theme/color_schemes.g.dart';
part 'src/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      home: const WeatherPage(),
    );
  }
}
