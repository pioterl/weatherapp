import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/model/weather.dart';

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
    return Scaffold(
      body: Center(
        child: _weather?.temperature == null
            ? CircularProgressIndicator(
                color: Colors.grey,
              ).animate(effects: [FadeEffect()])
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_weather!.cityName),
                    Text(_weather!.temperature.toStringAsFixed(1)),
                    Text(_weather!.mainCondition),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ..._weather!.dailyWeather.map((daily) => Text(
                          daily.temperatureHigh.toStringAsFixed(1),
                        )),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ..._weather!.dailyWeather.map((daily) => Text(
                          daily.temperatureLow.toStringAsFixed(1),
                        )),
                    BarChartSample3(weather: _weather),
                    Text("\n\n"),
                    LineChartSample5(weather: _weather),
                    LineChartSample2(weather: _weather),
                  ],
                ).animate(effects: [FadeEffect()]),
              ),
      ),
    );
  }
}
