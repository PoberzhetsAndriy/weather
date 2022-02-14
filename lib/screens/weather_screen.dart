import 'package:flutter/material.dart';
import 'package:weather/screens/saved_screen.dart';
import 'package:weather/screens/settings_screen.dart';
import 'package:weather/widgets/today_weather.dart';
import 'package:weather/widgets/week_weather.dart';

class WeatherScreen extends StatelessWidget {
  final town = 'Kyiv';
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
              icon: const Icon(Icons.settings))
        ],
        leading: IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedScreen()),
            );
          },
          icon: const Icon(Icons.menu),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(town,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
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
    );
  }
}
