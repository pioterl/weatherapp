import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/weather.dart';

class WeatherService {
  static const BASE_URL = 'https://api.pirateweather.net/forecast';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(List<String> positions) async {
    // final response = await http
    // .get(Uri.parse('$BASE_URL/$apiKey/51.759445%2C%2019.457216?units=ca'));
    final response = await http.get(Uri.parse(
        '$BASE_URL/$apiKey/${positions[1]},${positions[2]}?units=ca'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body), positions.first);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<String>> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return [
      city ?? "",
      position.latitude.toString(),
      position.longitude.toString()
    ];
  }
}
