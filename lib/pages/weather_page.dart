import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/pages/hourly.dart';

import '../services/weather_service.dart';
import '../util/descriptions.dart';
import '../util/icon_service.dart';
import 'app_resources.dart';
import 'daily.dart';
import 'rain_snow.dart';
import 'wind_speed.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherService _weatherService;
  Weather? _weather;
  bool _showWeatherInfo = false;
  static const double FONT_SIZE = 13.0;

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
    const int maxLength = 13;
    Color titleColor = AppColors.contentColorWhite.withOpacity(0.8);

    return SafeArea(
      child: Scaffold(
        body: _weather?.timeseries == null
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
                                  _weather!.cityName.length > maxLength
                                      ? "${_weather!.cityName.substring(0, maxLength).toUpperCase()}..."
                                      : _weather!.cityName.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30.0,
                                  ),
                                ),
                                Text(
                                    "${_weather!.timeseries.elementAt(0).airTemperature.round()}°C, "
                                    "${mapDescription()[_weather!.timeseries.elementAt(0).icon_1h]}"),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Image.asset(
                              IconService.getIconHourly(_weather!, 0),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 5.0,
                                left: 20.0,
                                bottom: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: titleColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3.0),
                                child: Text(
                                  "HOURLY",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FONT_SIZE,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _showWeatherInfo
                              ? _buildWeatherInfo().animate(
                                  effects: [FadeEffect()],
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 4.0, left: 0.0, bottom: 10, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showWeatherInfo = !_showWeatherInfo;
                                    });
                                  },
                                  child: _showWeatherInfo
                                      ? Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.info_outline,
                                          color: Colors.white.withOpacity(0.4),
                                          size: 20,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              color: titleColor, // Background color
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
                                fontSize: FONT_SIZE, // Adjust font size
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
                            bottom: 10,
                          ), // Add 20 pixels of padding from the left
                          child: Container(
                            decoration: BoxDecoration(
                              color: titleColor, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "PRECIPITATION (mm)",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: FONT_SIZE, // Adjust font size
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
                              color: titleColor, // Background color
                              borderRadius:
                                  BorderRadius.circular(2.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 3.0), // Padding inside the container
                            child: Text(
                              "WIND SPEED (km/h)",
                              style: TextStyle(
                                color: Colors.black87, // Text color
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: FONT_SIZE, // Adjust font size
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

  Widget _buildWeatherInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 7.0,
              bottom: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Text(
                "NIGHT",
                style: TextStyle(
                  color: AppColors.contentColorWhite.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 0.0,
              bottom: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Text(
                "DAY",
                style: TextStyle(
                  color: Colors.orange.shade300.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 0.0,
              bottom: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Text(
                "PRECIP. (mm)",
                style: TextStyle(
                  color: AppColors.contentColorCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 0.0,
              bottom: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Text(
                "WIND (km/h)",
                style: TextStyle(
                  color: AppColors.contentColorRed,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
