import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:weather/widgets/weather_icon.dart';

class WeekWeather extends StatelessWidget {
  final List<Future<WeatherInfo>> weekWeatherInfo;
  WeekWeather(this.weekWeatherInfo, {Key? key}) : super(key: key);

  final now = DateTime.now();

  var today = DateTime.now();
  bool isToday = true;
  void addOneDay() {
    isToday ? isToday = false : today = today.add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Column(
        children: weekWeatherInfo.map(
          (day) {
            addOneDay();
            return FutureBuilder<WeatherInfo>(
              future: day,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Color(0xFFF7F8F9)))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('d MMMM').format(today).toString(),
                                style: const TextStyle(
                                    fontSize: 11, color: Color(0xFF6D6D73)),
                              ),
                              Text(
                                  now.day == today.day
                                      ? 'Today'
                                      : DateFormat('EEEE')
                                          .format(today)
                                          .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          ShortWeather(
                            weatherState: snapshot.data!.weatherStateName,
                            minTemp: snapshot.data!.minTemp,
                            maxTemp: snapshot.data!.maxTemp,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
