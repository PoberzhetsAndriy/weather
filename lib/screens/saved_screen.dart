import 'dart:convert';
import 'package:http/http.dart' as http1;
import 'package:flutter/material.dart';
import 'package:weather/models/fetch_weather_info.dart';
import 'package:weather/screens/adding_screen.dart';
import 'package:weather/widgets/short_weather.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import '../models/town.dart';
import '../widgets/saved_row.dart';

class SavedScreen extends StatefulWidget {
  final Function setMainTown;
  const SavedScreen(this.setMainTown, {Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  Town? curentLocation;
  String? latt;
  String? long;
  List<Future<WeatherInfo>> savedTownsWeather = [];

  get http => null;

  void fetchLocationTown(String? latt, String? long) async {
    final response = await http1.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?lattlong=$latt,$long'));

    if (response.statusCode == 200) {
      setState(() {
        curentLocation = Town.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load town');
    }
  }

  void getLocation() async {
    Location location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      latt = _locationData.latitude.toString();
      long = _locationData.longitude.toString();
    });
    fetchLocationTown(latt, long);
  }

  void deleteTown(int index) {
    var towns = Hive.box<Town>('towns');
    setState(() {
      savedTownsWeather.removeAt(index);
      towns.deleteAt(index);
    });
  }

  void addNewTown(Town town) {
    var towns = Hive.box<Town>('towns');
    setState(() {
      if (towns.values.contains(town) == false) {
        towns.add(town);
        savedTownsWeather.add(fetchWeatherInfo(0, town.woeid));
      }
    });
  }

  void addTownsWeather() {
    var towns = Hive.box<Town>('towns');

    for (int i = 0; i < towns.values.length; i++) {
      setState(() {
        savedTownsWeather.add(fetchWeatherInfo(0, towns.getAt(i)!.woeid));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    addTownsWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddingScreen(addNewTown)),
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text(
          "Saved",
        ),
      ),
      body: ListView.builder(
          itemCount: savedTownsWeather.length + 1,
          itemBuilder: (ctx, index) {
            if (index == savedTownsWeather.length) {
              if (curentLocation != null) {
                return TextButton(
                  onPressed: () {
                    addNewTown(curentLocation!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const [
                        Text('Add you current location'),
                        Icon(Icons.location_pin)
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            } else {
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
                          widget.setMainTown(Town(snapshot.data!.title,
                              snapshot.data!.woeid.toInt()));
                          Navigator.pop(context);
                        },
                        child: SavedRow(
                          children: [
                            Text(snapshot.data!.title),
                            ShortWeather(
                                weatherState: snapshot.data!.weatherStateName,
                                minTemp: snapshot.data!.minTemp.toInt(),
                                maxTemp: snapshot.data!.maxTemp.toInt()),
                          ],
                        ),
                      );
                    }
                    return const SavedRow();
                  },
                ),
              );
            }
          }),
    );
  }
}
