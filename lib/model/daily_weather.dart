class DailyWeather {
  final double temperatureHigh;
  final double temperatureLow;
  final int time;
  final double precipIntensity;

  DailyWeather({
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.time,
    required this.precipIntensity,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      temperatureHigh: json['temperatureHigh'].toDouble(),
      temperatureLow: json['temperatureLow'].toDouble(),
      time: json['time'],
      precipIntensity: json['precipIntensityMax'],
    );
  }
}
