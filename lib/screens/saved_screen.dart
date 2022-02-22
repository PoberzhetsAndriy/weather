import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/screens/adding_screen.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedScreen extends StatefulWidget {
  final Function setMainTown;
  const SavedScreen(this.setMainTown, {Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Future<WeatherInfo>> savedTownsWeather = [];
  //List<int> savedTownsWoeids = [];

  void deleteTown(int index) {
    var woeids = Hive.box<int>('woeids');
    setState(() {
      savedTownsWeather.removeAt(index);
      woeids.deleteAt(index);
    });
  }

  void addNewTownWoeid(int woeid) {
    var woeids = Hive.box<int>('woeids');
    setState(() {
      if (woeids.values.contains(woeid) == false) {
        woeids.add(woeid);
        //savedTownsWoeids.add(woeid);
        savedTownsWeather.add(fetchWeatherInfo(0, woeid));
      }
    });
  }

  void addTownsWeather() {
    print('start');
    var woeids = Hive.box<int>('woeids');
    print(woeids.values);
    for (int i = 0; i < woeids.values.length; i++) {
      setState(() {
        savedTownsWeather.add(fetchWeatherInfo(0, woeids.getAt(i)));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    addTownsWeather();
  }

  @override
  Widget build(BuildContext context) {
    print(savedTownsWeather);
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          "Saved",
        ),
      ),
      body: ListView.builder(
          itemCount: savedTownsWeather.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                deleteTown(index);
              },
              child: FutureBuilder<WeatherInfo>(
                future: savedTownsWeather[index],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        widget.setMainTown(
                            snapshot.data!.title, snapshot.data!.woeid);
                        Navigator.pop(context);
                      },
                      child: Theme(
                        data: Theme.of(context).copyWith(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).primaryColorDark))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.title),
                                ShortWeather(
                                    weatherState:
                                        snapshot.data!.weatherStateName,
                                    minTemp: snapshot.data!.minTemp.toInt(),
                                    maxTemp: snapshot.data!.maxTemp.toInt()),
                              ],
                            ),
                          ),
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
