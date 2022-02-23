import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';

import 'package:weather/widgets/info_image.dart';
import 'package:weather/widgets/weather_state.dart';

class TodayWeather extends StatelessWidget {
  final Future<WeatherInfo> todayWeatherInfo;
  const TodayWeather(this.todayWeatherInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherInfo>(
        future: todayWeatherInfo,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: [
                WeatherState(snapshot.data!.weatherStateName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Column(children: [
                        const Text('Max', style: TextStyle(fontSize: 15)),
                        Text('${snapshot.data!.maxTemp.toInt()}°',
                            style: const TextStyle(
                                fontSize: 70, fontWeight: FontWeight.w600))
                      ]),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 110,
                      child: Column(children: [
                        const Text('Min', style: TextStyle(fontSize: 15)),
                        Text('${snapshot.data!.minTemp.toInt()}°',
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
                            const InfoImage('N'),
                            Text(
                                '${snapshot.data!.windSpeed.toStringAsFixed(1)} mph'),
                          ],
                        ),
                        Row(
                          children: [
                            const InfoImage('Preasure'),
                            Text(
                                '${snapshot.data!.airPressure..toStringAsFixed(1)} mbar'),
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
                            Text('${snapshot.data!.humidity.toInt()} %'),
                          ],
                        ),
                        Row(
                          children: [
                            const InfoImage('Visibility'),
                            Text(
                                '${snapshot.data!.visibility.toStringAsFixed(1)} km'),
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
          return const SizedBox(height: 479.1,);
        });
  }
}
