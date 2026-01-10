import 'package:flutter/material.dart';


final BoxDecoration kWeatherCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end : Alignment.bottomLeft,
      colors: [
        Colors.amberAccent,
        Colors.amber,

      ]
    )
   // boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 5)]
);


final BoxDecoration kBottomWeatherContainerDecoration =  BoxDecoration(
  borderRadius: BorderRadius.circular(50),
  gradient: LinearGradient (
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Colors.amber,
      Colors.amberAccent
    ]
  ),
);


final ThemeData kThemeDataForFullWeatherCity = ThemeData(
    textTheme: TextTheme(
        bodyMedium: TextStyle( //default text style that flutter looks for is bodyMedium for everything else i have to manually provide widgets
            fontSize: 28,
            color: Colors.black
        ),
        bodySmall: TextStyle(
            fontSize: 25,
            color: Colors.grey
        )

    ),

);