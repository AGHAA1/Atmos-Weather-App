A Flutter-based weather application that allows users to track weather for up to 5 cities.  
Uses **Provider** for state management and **SharedPreferences** for local data persistence.  
# Atmos-Weather-App (Flutter)

## Features
- Add and manage up to 5 cities with validation and constraints
- Fetch and display real-time weather data using OpenWeather API
- Persistent storage of user-selected cities with SharedPreferences
- Handles loading, success, and error states efficiently
- Responsive and user-friendly UI built with Flutter widgets




## Setup Instructions
In order for this app to work, you need your own API key from OpenWeather: [https://openweathermap.org/api](https://openweathermap.org/api)

### Steps to set up
1. Clone the repository
```bash
git clone
```
2. Navigate to the project directory
```bash
cd Atnos-Weather-App
```
3. Install dependencies
```bash
flutter pub get
```
4. In the `lib` directory, create a new folder named `config`. Inside it, create a Dart file named `api_key.dart`.
5. Copy and paste this code:

```dart
class APIKEY {
  final apiKey = 'paste your API key here';
}
```


Screenshots:

![home](https://github.com/user-attachments/assets/c7cc40e9-19a3-499a-abe8-120dbd36f3d8)
![weather3](https://github.com/user-attachments/assets/786fe69e-5408-44e1-8f71-2f9b19afd45e)
![weather2](https://github.com/user-attachments/assets/eb5e6d6e-7d80-45a4-a780-da8d813d12ba)
![weather1](https://github.com/user-attachments/assets/64e04357-dde9-4b75-b00a-7d2fc0df34d2)
