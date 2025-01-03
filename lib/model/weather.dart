import 'daily_weather.dart';
import 'hourly_weather.dart';

class Weather {
  final String cityName;
  final List<DailyWeather> dailyWeather;

  Weather({required this.cityName, required this.dailyWeather});

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
        cityName: city,
        dailyWeather: (json['properties']['timeseries'] as List)
            .map((data) => DailyWeather.fromJson(data))
            .toList());
  }
}
