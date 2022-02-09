import 'package:flutter/material.dart';
import 'package:weather/widgets/get_info.dart';
import 'package:weather/widgets/today_weather.dart';
import 'package:weather/widgets/week_weather.dart';
import 'package:flutter/services.dart';
import 'package:weather/widgets/get_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  getHttp('https://www.metaweather.com/api/location/924938/');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  final town = 'Kyiv';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(town,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18)),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: AlignmentDirectional.topCenter,
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/Light Sky Gradient.png'),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TodayWeather(),
                const WeekWeather(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
