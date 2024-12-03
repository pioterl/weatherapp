class DailyWeather {
  final double temperatureHigh;
  final double temperatureLow;
  final int time;
  final double precipProbability;
  final double windSpeed;
  final String icon;

  DailyWeather({
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.time,
    required this.precipProbability,
    required this.windSpeed,
    required this.icon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      temperatureHigh: json['temperatureHigh'].toDouble(),
      temperatureLow: json['temperatureLow'].toDouble(),
      time: json['time'],
      precipProbability: json['precipProbability'],
      windSpeed: json['windSpeed'],
      icon: json['icon'],
    );
  }
}
