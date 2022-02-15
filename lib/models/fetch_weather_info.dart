import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<WeatherInfo> fetchWeatherInfo(int day, int woeid) async {
  final response = await http
      .get(Uri.parse('https://www.metaweather.com/api/location/$woeid/'));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body), day);
  } else {
    throw Exception('Failed to load album');
  }
}

class WeatherInfo {
  final String weatherStateName;
  final String windDirectionCompass;
  final String title;
  final num woeid;
  final num windSpeed;
  final num humidity;
  final num minTemp;
  final num maxTemp;
  final num airPressure;
  final num visibility;

  const WeatherInfo({
    required this.woeid,
    required this.weatherStateName,
    required this.windDirectionCompass,
    required this.title,
    required this.windSpeed,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
    required this.airPressure,
    required this.visibility,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json, int day) {
    return WeatherInfo(
        weatherStateName: json["consolidated_weather"][day]
            ['weather_state_name'],
        windDirectionCompass: json["consolidated_weather"][day]
            ['wind_direction_compass'],
        windSpeed: json["consolidated_weather"][day]['wind_speed'],
        humidity: json["consolidated_weather"][day]['humidity'],
        minTemp: json["consolidated_weather"][day]['min_temp'],
        maxTemp: json["consolidated_weather"][day]['max_temp'],
        airPressure: json["consolidated_weather"][day]['air_pressure'],
        visibility: json["consolidated_weather"][day]['visibility'],
        title: json["title"],
        woeid: json["woeid"]);
  }
}
