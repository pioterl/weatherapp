import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../model/weather.dart';

import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey;
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String city) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode != 200) {
      throw Exception('Error getting weather for city');
    }

    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }

  Future<String> getCity() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty && placemarks[0].locality != null) {
      return placemarks[0].locality!;
    } else {
      return "Unknown";
    }
  }
}
