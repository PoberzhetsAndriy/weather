import 'package:http/http.dart' as http;
import 'dart:convert';

Future<WeatherInfo> fetchWeatherInfo(int day) async {
  final response = await http
      .get(Uri.parse('https://www.metaweather.com/api/location/44418/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherInfo.fromJson(jsonDecode(response.body),day);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class WeatherInfo {
  final String weatherStateName;
  final String windDirectionCompass;
  final int windSpeed;
  final int humidity;
  final int minTemp;
  final int maxTemp;

  const WeatherInfo({
    required this.weatherStateName,
    required this.windDirectionCompass,
    required this.windSpeed,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,

  });

  factory WeatherInfo.fromJson(Map<String,dynamic> json,int day) {
    return WeatherInfo (
      weatherStateName: json["consolidated_weather"][day]['weatherStateName'],
      windDirectionCompass: json["consolidated_weather"][day]['windDirectionCompass'],
      windSpeed: json["consolidated_weather"][day]['windSpeed'],
      humidity: json["consolidated_weather"][day]['humidity'],
      minTemp: json["consolidated_weather"][day]['minTemp'],
      maxTemp: json["consolidated_weather"][day]['maxTemp'],
    );
  }
}