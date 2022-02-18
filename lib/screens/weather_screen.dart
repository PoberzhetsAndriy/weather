import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/screens/saved_screen.dart';
import 'package:weather/screens/settings_screen.dart';
import 'package:weather/widgets/today_weather.dart';
import 'package:weather/widgets/week_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  DateTime today = DateTime.now();

  String mainTown = '';
  int? mainTownWoeid;
  List<Future<WeatherInfo>> weekWeatherInfo = [];
  void setMainTown(townTitle, woeid) {
    setState(() {
      mainTown = townTitle;
      mainTownWoeid = woeid;
    });
  }

  void fetchWeekWeatherInfo() {
    setState(() {
      weekWeatherInfo.clear();
      if (mainTownWoeid != null) {
        for (int i = 0; i < 6; i++) {
          weekWeatherInfo.add(fetchWeatherInfo(i, mainTownWoeid!));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchWeekWeatherInfo();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
              MaterialPageRoute(builder: (context) => SavedScreen(setMainTown)),
            );
          },
          icon: const Icon(Icons.menu),
        ),
        backgroundColor: Colors.transparent,
        shape: const Border(),
        title: Text(mainTown,
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
          child: mainTownWoeid != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TodayWeather(weekWeatherInfo[0]),
                    WeekWeather(weekWeatherInfo),
                  ],
                )
              : const SizedBox(
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        height: 300,
                        child: Center(
                            child: Text('No towns added yet',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white)))),
                  )),
        ),
      ),
    );
  }
}
