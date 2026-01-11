import 'package:flutter/material.dart';
import 'package:weather/screens/allweathers_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather/data.dart';


void main () {



  runApp(


    ChangeNotifierProvider(
      create: (context) => Data (), //passing data instance through out our app

      child: MaterialApp(

        home: WeatherScreen()
      ),
    ),
  );
}