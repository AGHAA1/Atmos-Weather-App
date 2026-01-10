import 'package:flutter/material.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/screens/full_city_weather_screen.dart';
import 'package:weather/misc/requestWeather.dart';
import 'dart:math';
import 'package:intl/intl.dart';


class CreateWeatherCard extends StatefulWidget {
  const CreateWeatherCard({super.key, required this.city,  required this.longPressFunction});
  final String city;
  final VoidCallback longPressFunction;

  @override
  State <CreateWeatherCard> createState() => _CreateWeatherCardState();
}


class  _CreateWeatherCardState extends State <CreateWeatherCard> {

  int temp = 0; // temp will be shown 0 when weather data is not fetched yet
  late dynamic weatherData;

  late int feelsLike;
  late int press;
  late int hum;
  late int windSpd;
  late int tempMin;
  late int tempMax;
  late String sunRise; //value stored here will be formatted to hr:min by 'intl' package
  late String sunSet; //value stored here will be formatted to hr:min by 'intl' package
  late int weatherId;
  late String weatherDiscrpt ;
  late String weatherI; //weather icon
  @override
  void initState () {
    getWeather();
    super.initState();
  }

  void formatSunRiseAndSet () {

    //date and time class works with milliseconds that why multiply by 1000 as api gives in seconds

    DateTime formattedSunset = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset']*1000, isUtc: true);
    DateTime formattedSunrise = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise']*1000, isUtc: true);
    formattedSunset = formattedSunset.toLocal(); //this will convert date time to users local time
    formattedSunrise = formattedSunrise.toLocal(); // this will convert date time to users local time
    sunSet = DateFormat.jm().format(formattedSunset); //using intl package to extract time and  format  time to hr:min
    sunRise = DateFormat.jm().format(formattedSunrise);
  }

  void getWeather ()  async {
    RequestWeather requestWeather = RequestWeather(cityName : widget.city);
    weatherData = await requestWeather.getWeather();

     setState(() {
       temp = weatherData['main']['temp'].round();
       feelsLike = weatherData['main']['feels_like'].round();
       press = weatherData['main']['pressure'];
       hum = weatherData['main']['humidity'];
       windSpd = (weatherData['wind']['speed']).floor();
       tempMin = weatherData['main']['temp_min'].round();
       tempMax = weatherData['main']['temp_max'].round();
       weatherId = weatherData['weather'][0]['id'];
       weatherDiscrpt = weatherData['weather'][0]['description'];
       weatherI = weatherData['weather'][0]['icon'];
       formatSunRiseAndSet ();
     });
  }
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            // when user presses on card data will be sent to next screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => CityWeatherCard(cityName: widget.city,
                temp: temp, feelsLikeTemp: feelsLike, pressure: press, humidity: hum, windSpeed: windSpd, tempMinimum: tempMin, tempMaximum: tempMax ,
                sunrise: sunRise, sunset: sunSet, weatherDiscription: weatherDiscrpt, weatherID: weatherId,
                weatherIcon: weatherI,)

            ));
          },
          onLongPress: widget.longPressFunction,
          child: Container(
            height: 125,
            width: double.infinity,
            decoration: kWeatherCardDecoration,

            child: Row (

              children: [
                Expanded(
                  child: Text(
                      widget.city.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,

                    )
                  ),
                ),
                Expanded(
                  child: Text(
                      '${temp.toString()}°',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}