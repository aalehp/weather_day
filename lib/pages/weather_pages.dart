import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_day/models/weather_model.dart';
import 'package:weather_day/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  //api key
  final _WeatherService = WeatherService('b1a567d269b547e67acd1c1542a8c3a8');
  Weather? _weather;

  //fetch the weather data
  _fecthWeather() async{
    //gete the current city
    String cityName = await _WeatherService.getCurrentCity();

    //get the weather data
    try{
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    
    }catch(e){
        print(e.toString());
      }
  }

  //weather animations 
  String getWeatherAnimation(String? mainCondition){
    switch(mainCondition){
      case 'Clear':
        return 'assets/sunny.json';
      case 'Rain':
        return 'assets/rain.json';
      case 'Clouds':
        return 'assets/clouds.json';
      case 'Snow':
        return 'assets/snow.json';
      default:
        return 'assets/sunny.json';
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fecthWeather();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/location.json', height: 100, width: 100),
          
          //city name
          Text(_weather?.cityName ?? "Loading city..", style: TextStyle(fontSize: 45, color: Colors.white), ),

          //animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition), height: 180, width: 180),

          //temperature
          Text('${_weather?.temperature.round()}°C', style: TextStyle(fontSize: 35, color: Colors.white), ),

          //weather condition
          Text(_weather?.mainCondition ?? "", style: TextStyle(fontSize: 28, color: Colors.white),),
        ]
        )
      ),
    );
  }
}