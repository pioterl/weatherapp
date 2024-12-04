class HourlyWeather {
  final double temperature;
  final int time;
  final double precipProbability;
  final double windSpeed;
  final String icon;

  HourlyWeather({
    required this.temperature,
    required this.time,
    required this.precipProbability,
    required this.windSpeed,
    required this.icon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temperature: json['temperature'].toDouble(),
      time: json['time'],
      precipProbability: json['precipProbability'],
      windSpeed: json['windSpeed'],
      icon: json['icon'],
    );
  }
}
