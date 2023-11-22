import '../assets/animations_path.dart';
import '../models/weather_condition_enum.dart';

class WeatherUtilsMethods {
  static String getWeatherAnimation(
    WeatherConditionEnum? mainCondition,
    DateTime? sunrise,
    DateTime? sunset,
  ) {
    if (mainCondition == null) {
      return SUNNY;
    }

    final isDay = DateTime.now().isAfter(sunrise ?? DateTime.now()) &&
        DateTime.now().isBefore(sunset ?? DateTime.now());

    switch (mainCondition) {
      case WeatherConditionEnum.snow:
      case WeatherConditionEnum.fog:
      case WeatherConditionEnum.clouds:
      case WeatherConditionEnum.mist:
        return MIST;
      case WeatherConditionEnum.sand:
      case WeatherConditionEnum.smoke:
      case WeatherConditionEnum.haze:
      case WeatherConditionEnum.dust:
      case WeatherConditionEnum.ash:
        return PARTLY_CLOUDY;
      case WeatherConditionEnum.rain:
      case WeatherConditionEnum.drizzle:
        return RAINNY_DAY;
      case WeatherConditionEnum.thunderstorm:
      case WeatherConditionEnum.squall:
        return STORM;
      case WeatherConditionEnum.tornado:
        return WINDY;
      case WeatherConditionEnum.clear:
      default:
        return isDay ? SUNNY : NIGHT;
    }
  }
}
