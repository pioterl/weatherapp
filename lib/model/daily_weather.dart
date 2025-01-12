class Timeseries {
  static const double TO_KMH_MULTIPLIER = 3.6;

  final double airTemperature;
  final DateTime time;
  final String icon_1h;
  final String icon_6h;
  final String icon_12h;
  final double windSpeed;
  final double precipitationAmount1h;
  final double precipitationAmount6h;

  Timeseries({
    required this.airTemperature,
    required this.time,
    required this.icon_1h,
    required this.icon_6h,
    required this.icon_12h,
    required this.windSpeed,
    required this.precipitationAmount1h,
    required this.precipitationAmount6h,
  });

  factory Timeseries.fromJson(Map<String, dynamic> json) {
    return Timeseries(
      time: DateTime.parse(json['time']).toLocal(),
      airTemperature:
          (json['data']?['instant']?['details']?['air_temperature'] ?? 0)
              .toDouble(),
      icon_1h: json['data']?['next_1_hours']?['summary']?['symbol_code'] ?? '',
      icon_6h: json['data']?['next_6_hours']?['summary']?['symbol_code'] ?? '',
      icon_12h:
          json['data']?['next_12_hours']?['summary']?['symbol_code'] ?? '',
      windSpeed: (json['data']?['instant']?['details']?['wind_speed'] ?? 0)
              .toDouble() *
          TO_KMH_MULTIPLIER,
      precipitationAmount1h: (json['data']?['next_1_hours']?['details']
                  ?['precipitation_amount'] ??
              0)
          .toDouble(),
      precipitationAmount6h: (json['data']?['next_6_hours']?['details']
                  ?['precipitation_amount'] ??
              0)
          .toDouble(),
    );
  }
}
