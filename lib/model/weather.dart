import 'daily_weather.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String icon;
  final List<DailyWeather> dailyWeather;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.dailyWeather,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
      cityName: city,
      temperature: json['currently']['temperature'].toDouble(),
      mainCondition: json['currently']['summary'],
      icon: json['currently']['icon'],
      dailyWeather: (json['daily']['data'] as List)
          .map((data) => DailyWeather.fromJson(data))
          .toList(),
    );
  }
}
