class DailyWeather {
  final double air_temperature;
  final int time;
  final String icon_1h;
  final String icon_6h;
  final String icon_12h;
  final double windSpeed;
  final double precipitationAmount;

  DailyWeather({
    required this.air_temperature,
    required this.time,
    required this.icon_1h,
    required this.icon_6h,
    required this.icon_12h,
    required this.windSpeed,
    required this.precipitationAmount,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: toUnixTimestamp(json),
      air_temperature:
          (json['data']?['instant']?['details']?['air_temperature'] ?? 0)
              .toDouble(),
      icon_1h: json['data']?['next_1_hours']?['summary']?['symbol_code'] ?? '',
      icon_6h: json['data']?['next_6_hours']?['summary']?['symbol_code'] ?? '',
      icon_12h:
          json['data']?['next_12_hours']?['summary']?['symbol_code'] ?? '',
      windSpeed:
          (json['data']?['instant']?['details']?['wind_speed'] ?? 0).toDouble(),
      precipitationAmount: (json['data']?['next_1_hours']?['details']
                  ?['precipitation_amount'] ??
              0)
          .toDouble(),
    );
  }

  static toUnixTimestamp(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['time'] ?? '');
    return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}
