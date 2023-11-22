enum WeatherConditionEnum {
  thunderstorm(2, 'Trovoadas'),
  drizzle(3, 'Chuvisco'),
  rain(5, 'Chuva'),
  snow(6, 'Neve'),
  mist(701, 'Névoa'),
  smoke(711, 'Fumaça'),
  haze(721, 'Neblina'),
  dust(731, 'Poeira'),
  fog(741, 'Nevoeiro'),
  sand(751, 'Areia'),
  ash(762, 'Cinzas'),
  squall(771, 'Tempestade'),
  tornado(781, 'Tornado'),
  clear(800, 'Limpo'),
  clouds(8, 'Nublado');

  const WeatherConditionEnum(this.id, this.name);

  final int id;
  final String name;

  factory WeatherConditionEnum.fromId(int id) {
    var idString = id.toString();

    if (idString.startsWith('2') ||
        idString.startsWith('3') ||
        idString.startsWith('5') ||
        idString.startsWith('6') ||
        (idString.startsWith('8') && !idString.endsWith('0'))) {
      idString = idString.substring(0, 1);
    }

    return values.firstWhere(
      (e) => e.id == int.parse(idString),
      orElse: () => clear,
    );
  }
}
