import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/pages/chart_hourly.dart';

import '../services/weather_service.dart';
import 'chart.dart';
import 'chart2.dart';
import 'chart3.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherService _weatherService;
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in .env file');
    }
    _weatherService = WeatherService(apiKey: apiKey);
    _fetchWeather();
  }

  _fetchWeather() async {
    try {
      List<String> positions = await _weatherService.getCurrentCity();
      final Weather weather = await _weatherService.getWeather(positions);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _weather?.temperature == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ).animate(effects: [FadeEffect()]),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await _fetchWeather();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_weather!.cityName),
                                Text(
                                    "${_weather!.temperature.round()}°C, ${_weather!.mainCondition}"),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: BoxedIcon(getIcon(_weather!.icon), size: 44),
                          ),
                        ],
                      ),
                      BarChartSample3(weather: _weather),
                      Text("\n"),
                      HourlyChart(weather: _weather),
                      // Text("\n\nWind speed"),
                      Text("\n"),
                      LineChartSample5(weather: _weather),
                      LineChartSample2(weather: _weather),
                      // Text("\n\nProbability of precipitation"),
                    ],
                  ).animate(effects: [FadeEffect()]),
                ),
              ),
      ),
    );
  }

  IconData getIcon(String icon) {
    switch (icon) {
      case 'clear-day':
        return WeatherIcons.day_sunny;
      case 'clear-night':
        return WeatherIcons.night_clear;
      case 'rain':
        return WeatherIcons.rain;
      case 'snow':
        return WeatherIcons.snow;
      case 'sleet':
        return WeatherIcons.sleet;
      case 'wind':
        return WeatherIcons.strong_wind;
      case 'fog':
        return WeatherIcons.fog;
      case 'cloudy':
        return WeatherIcons.cloudy;
      case 'partly-cloudy-day':
        return WeatherIcons.day_cloudy;
      case 'partly-cloudy-night':
        return WeatherIcons.night_alt_cloudy;
      default:
        return WeatherIcons.na;
    }
  }
}
