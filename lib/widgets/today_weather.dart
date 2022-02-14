import 'package:flutter/material.dart';

import 'package:weather/widgets/info_image.dart';
import 'package:weather/widgets/weather_state.dart';

class TodayWeather extends StatelessWidget {
  TodayWeather({Key? key}) : super(key: key);
  final todayInfo = {
    'Sky': 'Hail',
    'Max': 5,
    'Min': 4,
    'Wind': 10,
    'Humidity': 0.56,
    'Preasure': 1018,
    'Visibility': 15.8,
  };
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherState(todayInfo['Sky'] as String),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 85,
              child: Column(children: [
                const Text('Max', style: TextStyle(fontSize: 15)),
                Text('${todayInfo['Max'].toString()}°',
                    style: const TextStyle(
                        fontSize: 70, fontWeight: FontWeight.w600))
              ]),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 85,
              child: Column(children: [
                const Text('Min', style: TextStyle(fontSize: 15)),
                Text('${todayInfo['Min'].toString()}°',
                    style: const TextStyle(
                        fontSize: 70, fontWeight: FontWeight.w600))
              ]),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const InfoImage('ES'),
                    Text(todayInfo['Wind'].toString()),
                  ],
                ),
                Row(
                  children: [
                    const InfoImage('Preasure'),
                    Text(todayInfo['Preasure'].toString()),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const InfoImage('Humidity'),
                    Text(todayInfo['Humidity'].toString()),
                  ],
                ),
                Row(
                  children: [
                    const InfoImage('Visibility'),
                    Text(todayInfo['Visibility'].toString()),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
