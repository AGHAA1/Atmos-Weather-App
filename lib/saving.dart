import 'package:shared_preferences/shared_preferences.dart';

class Storage {




  Future<dynamic> createStorage ()  async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allCities = [];
    if (!prefs.containsKey('cities')) {
      prefs.setStringList('cities', allCities); //creating array inside local storage named cities and giving it array of strings
    }else {
      allCities = prefs.getStringList('cities')!; //getting array of strings from local storage and assigning it to array of strings
      return allCities;
    }

  }


  void saveCity (String cityToSave) async  {
    final prefs = await SharedPreferences.getInstance();
    List <String>?  cities =  prefs.getStringList('cities');
    cities!.add(cityToSave);
    prefs.setStringList('cities', cities);

  }

  void deleteCity (String cityToDelete) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cities = prefs.getStringList('cities');
    cities!.remove(cityToDelete); //this will deleteCity
    prefs.setStringList('cities', cities); //saving back to local storage after deleting

  }


}