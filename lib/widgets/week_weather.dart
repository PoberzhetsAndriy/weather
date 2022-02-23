import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:weather/widgets/weather_icon.dart';
import 'package:weather/widgets/week_weather_row.dart';

class WeekWeather extends StatelessWidget {
  final List<Future<WeatherInfo>> weekWeatherInfo;
  WeekWeather(this.weekWeatherInfo, {Key? key}) : super(key: key);
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Column(
        children: weekWeatherInfo.map((dayWeatherInfo) {
          return FutureBuilder<WeatherInfo>(
            future: dayWeatherInfo,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                return WeakWeatherRow(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('d MMMM')
                              .format(today.add(Duration(
                                  days:
                                      weekWeatherInfo.indexOf(dayWeatherInfo))))
                              .toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                            today.day ==
                                    today
                                        .add(Duration(
                                            days: weekWeatherInfo
                                                .indexOf(dayWeatherInfo)))
                                        .day
                                ? 'Today'
                                : DateFormat('EEEE')
                                    .format(today.add(Duration(
                                        days: weekWeatherInfo
                                            .indexOf(dayWeatherInfo))))
                                    .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    ShortWeather(
                      weatherState: snapshot.data!.weatherStateName,
                      minTemp: snapshot.data!.minTemp,
                      maxTemp: snapshot.data!.maxTemp,
                    ),
                  ],
                );
              }
              return const WeakWeatherRow();
            },
          );
        }).toList(),
      ),
    );
  }
}
