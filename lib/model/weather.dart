import 'daily_weather.dart';
import 'hourly_weather.dart';

class Weather {
  final String cityName;
  final List<Timeseries> timeseries;

  Weather({required this.cityName, required this.timeseries});

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
        cityName: city,
        timeseries: (json['properties']['timeseries'] as List)
            .map((data) => Timeseries.fromJson(data))
            .toList());
  }
}
