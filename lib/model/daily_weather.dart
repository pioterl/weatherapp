class DailyWeather {
  final double temperatureHigh;
  final double temperatureLow;
  final int time;
  final double precipIntensity;
  final double windSpeed;
  final String icon;

  DailyWeather({
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.time,
    required this.precipIntensity,
    required this.windSpeed,
    required this.icon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      temperatureHigh: json['temperatureHigh'].toDouble(),
      temperatureLow: json['temperatureLow'].toDouble(),
      time: json['time'],
      precipIntensity: json['precipProbability'],
      windSpeed: json['windSpeed'],
      icon: json['icon'],
    );
  }
}
