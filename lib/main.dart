import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/weather_page.dart';

main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        Colors.transparent, // Set navigation bar to transparent
    systemNavigationBarIconBrightness:
        Brightness.dark, // Change icons' brightness
    statusBarColor: Colors.transparent, // Set status bar to transparent
    statusBarIconBrightness:
        Brightness.dark, // Change status bar icons' brightness
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
