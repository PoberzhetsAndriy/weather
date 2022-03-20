import 'package:flutter/material.dart';
import 'package:weather/models/weather_icons.dart';

class WeatherIcon extends StatelessWidget {
  final String sky;
  const WeatherIcon(this.sky,{Key? key}) : super(key: key);
  static const Map icons ={
      'Clear': WeatherIcons.clear,
      'Hail': WeatherIcons.hail,
      'Heavy Cloud': WeatherIcons.heavyCloud,
      'Heavy Rain': WeatherIcons.heavyRain,
      'Light Cloud': WeatherIcons.lightCloud,
      'Light Rain': WeatherIcons.lightRain,
      'Showers': WeatherIcons.showers,
      'Snow': WeatherIcons.snow,
      'Thunder': WeatherIcons.thunder,
      'Sleet':WeatherIcons.sleet,
  };

  @override
  Widget build(BuildContext context) {
    return Icon(icons[sky]);
  }
}
