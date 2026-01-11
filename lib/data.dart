import 'package:flutter/material.dart';
import 'package:weather/reusable_components/create_weather_card.dart';
import 'package:weather/saving.dart';


class Data extends ChangeNotifier {


  List <CreateWeatherCard> allWeathers = [];
  Storage storage = Storage(); //creating object of storage class
  List<String> allUpdatedCities = []; //this will hold all cities from local storage



  void fetchStorage () async { // this function fetches storage from local storage
    allUpdatedCities = await storage.createStorage(); //now alUpdatedCities has either empty or list of cities from local

    createNewWeatherCards(allUpdatedCities);
    notifyListeners();
  }


  void createNewWeatherCards (List<String> allUpdatedCities) { //This will create weather and add it to all weathers list
    for (int i = 0 ; i < allUpdatedCities.length; i ++) { //for loop loop over updatedCities that we got from local
      //storage and create weather card for each city
      print('isnide for loop');
      String cityName = allUpdatedCities[i];//storing cityName in variable
      allWeathers.add(CreateWeatherCard(key : ValueKey(cityName), city: cityName, longPressFunction: () {

        storage.deleteCity(cityName);// calling delete function from storage class this will trigger on long press
        allWeathers.removeWhere((weatherCard) { //this will remove weathercard from all weathers
          return weatherCard.city == cityName;
        }) ;
        //.. it searches for widgets and check for specific property in that widget in that case weatherCard.city


        notifyListeners(); //notifying listeners when weatherCard gets removed on longPress

      },));
    }



  }

  void addCity (String cityName) {
    allUpdatedCities.add(cityName);
    createNewWeatherCards(allUpdatedCities);
    notifyListeners();
  }


  bool checkIfCityExists (String cityName) {

    if (cityName.isNotEmpty) {

      if (allWeathers.isNotEmpty) {

        for (CreateWeatherCard weatherCards in allWeathers) {

          if (weatherCards.city == cityName) {
            return false; //returns false if city already exists
          }
        }

        return true; //returns true if there is no city already present in allWeathers

      }
      return true; //returns true if allWeathers is empty
    }

    return false; // returns false if city name is empty

  }


  List<CreateWeatherCard> getAllWeathers () {
    return allWeathers;
  }

  void clearUpdatedCities () {
    allUpdatedCities.clear();
  }


  int  getTotalWeatherCards () {
    return allWeathers.length;
  }
}