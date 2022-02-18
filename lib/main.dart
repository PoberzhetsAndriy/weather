import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
            iconTheme: IconThemeData(color: Color(0XFF00A3FF)),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            shape:
                Border(bottom: BorderSide(color: Color(0xFFF7F8F9), width: 2)),
          ),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
              bodyText2: TextStyle(color: Colors.black))),
      home: const WeatherScreen(),
    );
  }
}
