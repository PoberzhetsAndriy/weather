import 'package:flutter/material.dart';

class WeatherState extends StatelessWidget {
  String weatherState;
  WeatherState(this.weatherState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(
          'assets/images/$weatherState.png',
          scale: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Text(
            weatherState,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
