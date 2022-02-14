import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/screens/adding_screen.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:weather/widgets/weather_icon.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Future<WeatherInfo>> savedTownsWeather = [];
  List<int> savedTownsWoeids = [];
  void addNewTownWoeid(int woeid) {
    setState(() {
      if(savedTownsWoeids.contains(woeid) == false){savedTownsWoeids.add(woeid);
      savedTownsWeather.add(fetchWeatherInfo(0, woeid));}
    });
  }

  void addTownsWeather(List<int> woeids) {
    woeids.map((woeid) {
      setState(() {
        savedTownsWeather.add(fetchWeatherInfo(0, woeid));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    addTownsWeather(savedTownsWoeids);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color(0xFFF7F8F9), width: 2)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddingScreen(addNewTownWoeid)),
                );
              },
              icon: const Icon(Icons.add))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0XFF00A3FF)),
        title: const Text(
          "Saved",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: savedTownsWeather.length,
          itemBuilder: (ctx, index) {
            return SizedBox(
              child: FutureBuilder<WeatherInfo>(
                future: savedTownsWeather[index],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFF7F8F9)))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data!.title),
                            ShortWeather(
                                weatherState: snapshot.data!.weatherStateName,
                                minTemp: snapshot.data!.minTemp.toInt(),
                                maxTemp: snapshot.data!.maxTemp.toInt()),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
          }),
    );
  }
}
