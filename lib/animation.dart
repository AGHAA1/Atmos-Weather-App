
import 'package:flutter/cupertino.dart';

class Weather {




  String giveAnimation (String weatherIcon) {
    final lastCharPos = weatherIcon.length - 1;

    debugPrint('weather icon $weatherIcon');
    final lastChar = weatherIcon.substring(lastCharPos, weatherIcon.length);

    if (lastChar == 'd') {
      return dayAnimation(weatherIcon);
    }else {
      return nightAnimation(weatherIcon);
    }

  }


  String dayAnimation (String weatherIcon) {

    if (weatherIcon == '01d') {
      return 'assets/weatherAnimations/sunny.json';//
    }else if (weatherIcon == '02d') {
      return 'assets/weatherAnimations/cloudWithSun.json';//
    }else if (weatherIcon == '03d') {
      return 'assets/weatherAnimations/cloudy.json';//
    }else if (weatherIcon == '04d') {
      return 'assets/weatherAnimations/cloudy.json'; //
    }else if (weatherIcon == '09d') {
      return 'assets/weatherAnimations/showerRain.json';//
    }else if (weatherIcon  == '10d') {
      return 'assets/weatherAnimations/rainy.json';//
    }else if (weatherIcon  == '11d') {
      return 'assets/weatherAnimations/thunderstormDay.json'; //
    }else if (weatherIcon  == '13d') {
      return 'assets/weatherAnimations/snow.json'; //
    }else {
      return 'assets/weatherAnimations/fog.json'; //
    }
  }



  String nightAnimation (String weatherIcon) {

    if (weatherIcon == '01n') {
      return 'assets/weatherAnimations/nightMoon.json';
    }else if (weatherIcon == '02n') {
      return 'assets/weatherAnimations/cloudyNight.json';
    }else if (weatherIcon == '03n') {
      return 'assets/weatherAnimations/cloudy.json';//
    }else if (weatherIcon == '04n') {
      return 'assets/weatherAnimations/cloudy.json'; //
    }else if (weatherIcon == '09n') {
      return 'assets/weatherAnimations/showerRain.json';
    }else if (weatherIcon  == '10n') {
      return 'assets/weatherAnimations/rainy.json'; //
    }else if (weatherIcon  == '11n') {
      return 'assets/weatherAnimations/thunderstormDay.json'; //
    }else if (weatherIcon  == '13n') {
      return 'assets/weatherAnimations/snow.json'; //
    }else {
      return 'assets/weatherAnimations/fog.json'; //
    }
  }
}