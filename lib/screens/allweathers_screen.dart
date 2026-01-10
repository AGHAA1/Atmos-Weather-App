import 'package:flutter/material.dart';
import 'package:weather/reusable_components/my_components.dart';
import 'package:weather/reusable_components/create_weather_card.dart';
import 'package:weather/saving.dart';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen ({super.key});

  @override
  State <WeatherScreen> createState () => _WeatherScreenState();
}

class _WeatherScreenState extends State <WeatherScreen> {

  late String cityName;
  bool isCityAdded = false;
  List <CreateWeatherCard> allWeathers = []; // weathers for different cities are stored here full weather card not literal city names.
  List <String> allUpdatedCities = []; //will store added cities here and then save to local storage using sharedPrefs

  Storage storage = Storage(); //creating object of storage class



  @override
  void initState () { //using state lifecycle which runs when widget is created before build method
    fetchStorage();
    super.initState();
  }


  void fetchStorage () async { // this function fetches storage from local storage
    allUpdatedCities = await storage.createStorage();
    createNewWeatherCards();
  }


  bool checkBeforeAddingCity () {
    if (cityName.isNotEmpty && !allUpdatedCities.contains(cityName)) {
      return true;
    }
    return false;
  }

  void createNewWeatherCards () { //This will create weather and add it to all weathers list
    setState(() {
      for (int i = 0 ; i < allUpdatedCities.length; i ++) { //for loop loop over updatedCities that we got from local
        //storage and create weather card for each city
        String cityName = allUpdatedCities[i];//storing cityName in variable

        allWeathers.add(CreateWeatherCard(key : ValueKey(cityName), city: cityName, longPressFunction: () {

          setState(() {
            storage.deleteCity(cityName);// calling delete function from storage class this will trigger on long press
            allWeathers.removeWhere((weatherCard) {


              return weatherCard.city == cityName;
            }) ;//this will remove weather card from allWeathers list how this works is that..
            //.. it searches for widgets and check for specific property in that widget in that case weatherCard.city



          });



        },)); //this will create weather card for each city in array of allCities;
      }
    });



  }












  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton( //floating action button
        backgroundColor: Colors.white,
          child: Icon(Icons.cloud_rounded),
          onPressed: () async {
            if (allWeathers.length <= 4) { //number of weathers user can add
              await showDialog(context: context, builder: (context) { //show dialog is future
                return CreateAlertDialog(onChangedFunc: (value) {
                  cityName = value;
                }, onPressedFunc: () {

                  if (checkBeforeAddingCity()) {
                    isCityAdded = true; //only if user pressed add we say isCityAdded is true
                    allUpdatedCities.clear();//clear before for loop runs in weather card function to avoid repeating of cities
                    allUpdatedCities.add(cityName); //adding city name to array of cities when user presses add in dialog
                    storage.saveCity(cityName); //this will save city to local storage
                    Navigator.pop(context); //this will destroy dialog after user presses add
                  }

                },);
              });// showDialog ends here


              if (isCityAdded) {


                  createNewWeatherCards();
                  isCityAdded = false;



              }


            }



          }),

        appBar: AppBar(
          backgroundColor: Colors.black,
            title: Text(
              'Weather',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                color: Colors.white
              ),

            )
        ),


        body: Column (
          children: allWeathers,
        ),
    );
  }
}