import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:weather/widgets/weather_icon.dart';

class WeekWeather extends StatefulWidget {
  const WeekWeather({Key? key}) : super(key: key);

  @override
  State<WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<WeekWeather> {
  final now = DateTime.now();

  var today = DateTime.now();
  bool isToday = true;
  void addOneDay() {
    setState(() {
      isToday ? isToday = false : today = today.add(const Duration(days: 1));
    });
  }

  final weekInfo = const [
    {'Sky': 'Light Clouds', 'Max': 5, 'Min': 4},
    {'Sky': 'Heavy Clouds', 'Max': 5, 'Min': 4},
    {'Sky': 'Snow', 'Max': 5, 'Min': 4},
    {'Sky': 'Light Rain', 'Max': 5, 'Min': 4},
    {'Sky': 'Heavy Rain', 'Max': 5, 'Min': 4},
    {'Sky': 'Thunder', 'Max': 5, 'Min': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Column(
        children: weekInfo.map(
          (day) {
            addOneDay();
            return Container(
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: Color(0xFFF7F8F9)))),
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
                                : DateFormat('EEEE').format(today).toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    const ShortWeather(
                      weatherState: 'Light Cloud',
                      minTemp: -1,
                      maxTemp: 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
