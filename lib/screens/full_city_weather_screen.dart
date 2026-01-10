import 'package:flutter/material.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/reusable_components/my_components.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/animation.dart';

class CityWeatherCard extends StatefulWidget {
  const CityWeatherCard({
    super.key,
    required this.cityName,
    required this.temp,
    required this.feelsLikeTemp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.tempMinimum,
    required this.tempMaximum,
    required this.sunrise,
    required this.sunset,
    required this.weatherID,
    required this.weatherDiscription,
    required this.weatherIcon,
  });
  //i will pass all things that i need to show in this card
  final String cityName;
  final int temp;
  final int feelsLikeTemp;
  final int pressure;
  final int humidity;
  final int windSpeed;
  final int tempMinimum;
  final int tempMaximum;
  final String sunset;
  final String sunrise;
  final int weatherID;
  final String weatherDiscription;
  final String weatherIcon;

  @override
  State<CityWeatherCard> createState() => _CityWeatherCardState();
}

class _CityWeatherCardState extends State<CityWeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController
  _controller; //cant initialize controller here since it requires context
  // of this class which is only ready when field is initialized that why i put it in initState

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    ); //'this' means reference to this class
    super.initState();
  }

  @override
  void dispose() {
    _controller
        .dispose(); //this will destroy controller and hence animation will not run in bg
    super.dispose();
  }

  //this function will check if animation received contains file or is empty
  // String fetchAndCheckIfAnimationEmpty () {
  //   final  weatherAnimation =  Weather().giveAnimation(widget.weatherIcon);
  //
  //   if (weatherAnimation != ''){
  //     return weatherAnimation;
  //   }
  //   return weatherAnimation ; //is empty
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      //if theme widget is used and inside text theme is used then flutter will check if there is body medium rule
      //then it auto applies that and if not then it wont apply our defined rules
      data: kThemeDataForFullWeatherCity,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),

                  child: Column(
                    children: [
                      //topContainer

                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [

                              Expanded(
                                child: Row (
                                  children: [

                                    Expanded(
                                      child: Text(
                                          widget.cityName,
                                          style: Theme.of(context).textTheme.bodySmall
                                      ),
                                    ),
                                    Expanded(

                                      child: Lottie.asset(
                                        //every animation package have their own properties
                                        Weather().giveAnimation(
                                          widget.weatherIcon,
                                        ), //giving our weather class animation method weather icon


                                        fit: BoxFit.cover,
                                        controller:
                                        _controller, //giving my controller to it so i can control this animation with my controller
                                        onLoaded: (composition) {
                                          //as soon as lottie file is loaded , onLoaded function will execute so inside we can
                                          // play animation without using controller.forward outside
                                          _controller.duration = composition
                                              .duration; //composition has duration property which has
                                          // total length of animation and setting it to controller if i give duration to controller than i wont know
                                          //what is the actual length of the animation so i might miss some frames
                                          _controller
                                              .repeat(); //animation will play again after it finishes.
                                        },
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                              Expanded(

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${widget.temp}°',
                                        style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row( //weather discription
                                  children: [
                                    Text(
                                      widget.weatherDiscription,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      // bottom container
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: kBottomWeatherContainerDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CreateWeatherDetails(
                                  data1: widget.tempMinimum,
                                  data2: widget.tempMaximum,
                                  weatherPara1: 'Min',
                                  weatherPara2: 'Max',
                                  unit1: '°',
                                  unit2: '°',
                                ),
                                CreateWeatherDetails(
                                  data1: widget.pressure,
                                  data2: widget.humidity,
                                  weatherPara1: 'Pressure',
                                  weatherPara2: 'Humidity',
                                  unit1: 'hPa',
                                  unit2: '%',
                                ),
                                CreateWeatherDetails(
                                  data1: widget.sunrise,
                                  data2: widget.sunset,
                                  weatherPara1: 'Sunrise',
                                  weatherPara2: 'Sunset',
                                  unit1: '',
                                  unit2: '',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
