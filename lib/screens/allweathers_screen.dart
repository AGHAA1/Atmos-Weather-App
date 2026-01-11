import 'package:flutter/material.dart';
import 'package:weather/reusable_components/my_components.dart';
import 'package:weather/reusable_components/create_weather_card.dart';
import 'package:weather/saving.dart';
import 'package:provider/provider.dart';
import 'package:weather/data.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen ({super.key});

  @override
  State <WeatherScreen> createState () => _WeatherScreenState();
}

class _WeatherScreenState extends State <WeatherScreen> {

  late String cityName;
  bool isCityAdded = false;

  Storage storage = Storage(); //creating object of storage class

  @override
  void initState () { //using state lifecycle which runs when widget is created before build method

    context.read<Data>().fetchStorage(); //this will fetch user data
    super.initState();
  }




  bool checkBeforeAddingCity(String cityName) {

    return context.read<Data>().checkIfCityExists(cityName);


  }









  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton( //floating action button
        backgroundColor: Colors.white,
          child: Icon(Icons.cloud_rounded),
          onPressed: () async {
            if (context.read<Data>().allWeathers.length <= 4) { //number of weathers user can add
              await showDialog(context: context, builder: (context) { //show dialog is future
                return CreateAlertDialog(onChangedFunc: (value) {
                  cityName = value;
                }, onPressedFunc: () {


                 if (checkBeforeAddingCity(cityName)) { //checking that city was not added before or is not empty
                    isCityAdded = true; //only if user pressed add we say isCityAdded is true
                    context.read<Data>().clearUpdatedCities();//clear before for loop runs in weather card function to avoid repeating of cities
                    // ...as it already will contain cities when user open apps and data from local gets stored
                    context.read<Data>().addCity(cityName); //adding city name to array of cities when user presses add in dialog
                    storage.saveCity(cityName); //this will save city to local storage
                    Navigator.pop(context); //this will destroy dialog after user presses add
                 }else {
                   print('already exists');
                 }

                },);
              });// showDialog ends here





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
          children: context.watch<Data>().getAllWeathers()
        ),
    );
  }
}