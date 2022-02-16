import 'package:flutter/material.dart';
import 'package:weather/widgets/weather_icon.dart';

class ShortWeather extends StatelessWidget {
  final String weatherState;
  final num maxTemp;
  final num minTemp;
  const ShortWeather(
      {required this.weatherState,
      required this.maxTemp,
      required this.minTemp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 40,
            alignment: Alignment.center,
            child: WeatherIcon(weatherState)),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            '${maxTemp.toInt().toString()}°',
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            '${minTemp.toInt().toString()}°',
          ),
        )
      ],
    );
  }
}
