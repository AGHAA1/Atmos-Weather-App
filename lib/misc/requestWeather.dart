import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/config/api_key.dart';


class RequestWeather {

  RequestWeather ({required this.cityName});
  late String cityName;


  //below apikey stores key for open weather
  String apiKey = APIKEY().apiKey; //gets api key from /config/api_key.dart




  Future <dynamic>  getWeather () async {

    //url for open weather
    String url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    Uri parsedUrl = Uri.parse(url);

    try {
      var weatherDataJson = await http.get(parsedUrl) ; //getting weather data from api in json
      if (weatherDataJson.statusCode == 200) {
        var weatherData = jsonDecode(weatherDataJson.body); // converting json to dart before using

        return weatherData; //returning full weather profile
      }else {

          return 'client side error';
      }
    }catch (error) {
     // print('something went wrong $error');
    }
  }




  //gets aqi from another api
  Future <dynamic> getCityAqi () async {

    String apiKey = 'a5dfc008fe60db7cd0e4e4eb18cbd573c37ed69c';
    String url  = 'https://api.waqi.info/feed/$cityName/?token=$apiKey';
    Uri parsedUrl = Uri.parse(url);



    try  {


      final response = await http.get(parsedUrl);
      if (response.statusCode == 200) {
      //  print(response.statusCode);
        final data = jsonDecode(response.body);
        print('aqi is :: ${data['data']['aqi']}');
        //print('data')
        //print('aqi is :::::  ${data['overall_aqi']}');
        return data;
      }else {
        throw Exception ('client side error');
      }

    }catch (error) {
      throw Exception (error);
    }
  }


}