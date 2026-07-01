import 'package:flutter/material.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/screens/full_city_weather_screen.dart';
import 'package:weather/misc/requestWeather.dart';
import 'package:intl/intl.dart';




//read me ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//this is where city weather card is created and city name is passed to this..
//..class and this class calls our requestWeather class to fetch weather data



class CreateWeatherCard extends StatefulWidget {
  const CreateWeatherCard({super.key, required this.city,  required this.longPressFunction});
  final String city;
  final VoidCallback longPressFunction;

  @override
  State <CreateWeatherCard> createState() => _CreateWeatherCardState();
}


//this function gives aqi category based on aqi
(String category, Color color) giveAqiCategory (int aqi) {
  if (aqi > 0  && aqi <= 50) {
    return ('Good', Color(0xff00E400));
  }else if (aqi > 50 && aqi <= 100) {
    return ('Moderate', Color(0xffFEFE00));
  }else if (aqi > 100 && aqi <= 150) {
    return ('Unhealthy for sensitive group', Color(0xffFE7E00));
  }else if (aqi > 150 && aqi <= 200) {
    return ('Unhealthy', Color(0xffFE0000));
  }else if (aqi > 200 && aqi <= 300) {
    return ('Very Unhealthy', Color(0xff99004C));
  }else if (aqi > 300) {
    return ('Hazardous', Color(0xff7E0022));
  }else {
    return ('No Data', Colors.transparent);
  }
}



class  _CreateWeatherCardState extends State <CreateWeatherCard> {

  int temp = 0; // temp will be shown 0 when weather data is not fetched yet
  late dynamic weatherData;  //whole response gets stored
  late dynamic aqiData; // whole response form api gets stored


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
  late int aqi;
  late String aqiCategory;
  late Color aqiColor;

  bool navigateToFullWeatherScreen = false; // if user entered correct city and our try block got succeeded without..
  //...catching any error then this will become true and user can navigate to next screen which is full city weather
  @override
  void initState () {
    getWeather(); //calling getWeather to instantly fetch weather data when card is created
    super.initState();
  }


  //sunrise and sunset is provided in utc time format so need to convert it before showing in app
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



    try {



      final apiResponses = await Future.wait ([
        requestWeather.getWeather(),
        requestWeather.getCityAqi()
      ]);




      weatherData = apiResponses[0];
      aqiData = apiResponses[1];



      aqi = aqiData['data']['aqi']; //storing aqi received

      final (category, color) = giveAqiCategory(aqi);
      aqiCategory = category; //storing aqi category received form our function above
      aqiColor = color;




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


        formatSunRiseAndSet (); //api gives utc so need to convert


        //once everything gets loaded from api and set to variabeles
        //only then we allow user to go to full weather city screen
        navigateToFullWeatherScreen = true; //setting it true at end of try block so that user can navigate to next screen
      });
    }catch(error) {
      navigateToFullWeatherScreen = false; // setting it false if try block fails
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {

           // print('navigate to full screen : $navigateToFullWeatherScreen');
            if (navigateToFullWeatherScreen == true) {

              Navigator.push(context, MaterialPageRoute(builder: (context) => CityWeatherCard(cityName: widget.city,
                temp: temp, feelsLikeTemp: feelsLike, pressure: press, humidity: hum, windSpeed: windSpd, tempMinimum: tempMin, tempMaximum: tempMax ,
                sunrise: sunRise, sunset: sunSet, weatherDiscription: weatherDiscrpt, weatherID: weatherId,
                weatherIcon: weatherI, weatherAQI: aqi.toString(), weatherAqiCategory: aqiCategory,
              aqiCategoryColor : aqiColor
              )

              ));
            }
            // when user presses on card data will be sent to next screen

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