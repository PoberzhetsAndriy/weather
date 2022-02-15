import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';

import 'package:weather/widgets/info_image.dart';
import 'package:weather/widgets/weather_state.dart';

class TodayWeather extends StatefulWidget {
  TodayWeather({Key? key}) : super(key: key);

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  late int townWoeid ;
  late Future<WeatherInfo> todayWeatherInfo;

  @override
  void initState() {
    const int townWoeid = 44418;
    todayWeatherInfo = fetchWeatherInfo(0, townWoeid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherInfo>(
        future: todayWeatherInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                WeatherState(snapshot.data!.weatherStateName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 85,
                      child: Column(children: [
                        const Text('Max', style: TextStyle(fontSize: 15)),
                        Text('${snapshot.data!.maxTemp.toInt()}°',
                            style: const TextStyle(
                                fontSize: 70, fontWeight: FontWeight.w600))
                      ]),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 85,
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}
