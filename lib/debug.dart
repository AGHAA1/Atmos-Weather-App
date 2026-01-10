
void main () {
  List <String> allWeathers = ['new york', 'lahore', 'alaska'];

  print(allWeathers);


  delete (String cityName) {
    allWeathers.removeWhere((name) {
      return name == cityName;
    });
  }

  delete('new york');

  print(allWeathers);
}

