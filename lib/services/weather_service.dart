import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/weather.dart';

class WeatherService {
  static const BASE_URL =
      'https://api.met.no/weatherapi/locationforecast/2.0/compact';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(List<String> positions) async {
    // final response = await http
    //     .get(Uri.parse('$BASE_URL/$apiKey/51.1642%2C%2023.4716?units=ca'));
    // final http.Response response = await http.get(
    //     Uri.parse(
    //         'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=-32.3567&lon=22.5830'),
    //     headers: {
    //       'User-Agent': 'WeatherApp/1.0 https://github.com/pioterl/weatherapp'
    //     }); // Beaufort West

    // final http.Response response = await http.get(
    //     Uri.parse(
    //         'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=69.3535&lon=88.2027'),
    //     headers: {
    //       'User-Agent': 'WeatherApp/1.0 https://github.com/pioterl/weatherapp'
    //     }); // Norylsk

    // final http.Response response = await http.get(
    //     Uri.parse(
    //         'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=51.759445&lon=19.457216'),
    //     headers: {
    //       'User-Agent': 'WeatherApp/1.0 https://github.com/pioterl/weatherapp'
    //     }); // LDZ

    final http.Response response = await http.get(
        Uri.parse('$BASE_URL?lat=${positions[1]}&lon=${positions[2]}'),
        headers: {
          'User-Agent': 'WeatherApp/1.0 https://github.com/pioterl/weatherapp'
        });

    if (response.statusCode == 200) {
      Weather weather =
          Weather.fromJson(jsonDecode(response.body), positions.first);
      return weather;
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
