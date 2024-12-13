import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/pages/hourly.dart';

import '../services/weather_service.dart';
import 'app_resources.dart';
import 'daily.dart';
import 'hourly_new.dart';
import 'wind_speed.dart';
import 'rain_snow.dart';

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
                                Text(
                                  _weather!.cityName.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                ),
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
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align the container to the left
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                            left: 20.0,
                            bottom: 10,
                          ), // Add 20 pixels of padding from the left
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors
                                  .contentColorCyan, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "HOURLY",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: 12.0, // Adjust font size
                              ),
                            ),
                          ),
                        ),
                      ),
                      HourlyChart(weather: _weather),
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align the container to the left
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20.0,
                            bottom: 10,
                          ), // Add 20 pixels of padding from the left
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors
                                  .contentColorCyan, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "DAILY",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: 12.0, // Adjust font size
                              ),
                            ),
                          ),
                        ),
                      ),
                      DailyChart(weather: _weather),
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align the container to the left
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            bottom: 0,
                          ), // Add 20 pixels of padding from the left
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors
                                  .contentColorCyan, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "CHANCE OF RAIN/SNOW",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: 12.0, // Adjust font size
                              ),
                            ),
                          ),
                        ),
                      ),
                      RainSnow(weather: _weather),
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align the container to the left
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            bottom: 40,
                          ), // Add 20 pixels of padding from the left
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors
                                  .contentColorCyan, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "WIND SPEED",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: 12.0, // Adjust font size
                              ),
                            ),
                          ),
                        ),
                      ),
                      WindSpeed(weather: _weather),
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
