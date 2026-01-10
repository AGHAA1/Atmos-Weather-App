import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/config/api_key.dart';


class RequestWeather {

  RequestWeather ({required this.cityName});
  late String cityName;


  String apiKey = APIKEY().apiKey; //gets api key from /config/api_key.dart


  late String url;
  late Uri parsedUrl;

  Future <dynamic>  getWeather () async {

    url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    parsedUrl = Uri.parse(url);

    try {
      var weatherDataJson = await http.get(parsedUrl) ; //getting weather data from api in json
      if (weatherDataJson.statusCode == 200) {
        var weatherData = jsonDecode(weatherDataJson.body); // converting json to dart before using

        return weatherData; //returning full weather profile
      }else {
        print ('Bad status code ${weatherDataJson.statusCode}');
      }
    }catch (error) {
      print('something went wrong $error');
    }



  }
}