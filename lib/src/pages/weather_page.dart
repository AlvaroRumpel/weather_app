import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../secrets.dart';
import '../mixins/snackbars.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'weather_utils_methods.dart';

part 'custom_fab_animator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with CustomSnackBar {
  final _weatherService = WeatherService(API_KEY);
  var isSearchMode = false;
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  Weather? _weather;

  Future<void> _fetchWeatherByCity(String cityName) async {
    if (cityName.isEmpty) {
      showSnackBar('Insira uma cidade');

      _fetchWeather();
      return;
    }

    setState(() {
      _weather = null;
    });

    try {
      final coordinates = await _weatherService.getPositionByCity(cityName);
      final weather = await _weatherService.getWeather(
        coordinates.$1,
        coordinates.$2,
      );

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      showSnackBar('Não foi possivel buscar pela cidade $cityName');
      _fetchWeather();
    }
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _weather = null;
    });

    try {
      final coordinates = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(
        coordinates.$1,
        coordinates.$2,
      );

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      showSnackBar('Não foi possivel buscar sua localização');
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _fetchWeather,
              icon: const Icon(Icons.restart_alt_outlined),
            ),
          ],
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _weather?.cityName ?? 'Buscando cidade...',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Lottie.asset(
                  WeatherUtilsMethods.getWeatherAnimation(
                    _weather?.mainCondition,
                    _weather?.sunrise,
                    _weather?.sunset,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (_weather?.temperature ?? 0) >= 20
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    '${(_weather?.temperature ?? 0).round()}°C',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _weather?.mainCondition.name ?? 'Buscando dados...',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isSearchMode
              ? MediaQuery.sizeOf(context).width * .9
              : MediaQuery.sizeOf(context).width * .35,
          height: 56,
          child: isSearchMode
              ? SearchBar(
                  focusNode: searchFocus,
                  controller: searchController,
                  hintText: 'Nome da cidade',
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      await _fetchWeatherByCity(searchController.text);
                    }
                  },
                  trailing: [
                    IconButton(
                      onPressed: () async {
                        isSearchMode = false;
                        searchFocus.unfocus();
                        await _fetchWeatherByCity(searchController.text);
                        searchController.clear();
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      isSearchMode = true;
                      searchFocus.requestFocus();
                    });
                  },
                  label: const Text(
                    'Buscar',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  icon: const Icon(Icons.search),
                ),
        ),
        floatingActionButtonAnimator: _CustomFabAnimatior(),
        floatingActionButtonLocation: isSearchMode
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
