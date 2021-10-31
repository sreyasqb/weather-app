import 'package:flutter/material.dart' show Icon;

class City{
  String name;
  String image;
  int temp;
  int minTemp;
  int maxTemp;
  Icon weatherIcon;
  int feelsLike;
  String description;
  DateTime sunset;
  DateTime sunrise;
  int rainPercentage;
  int humidity;
  int wind;
  double precipitation;
  DateTime localTime;
  int timezone;
  City({required this.name,required this.image,required this.temp,required this.minTemp,required this.maxTemp,required this.weatherIcon,required this.feelsLike,required this.description,required this.sunset,required this.sunrise,required this.rainPercentage,required this.humidity,required this.wind,required this.precipitation,required this.localTime,required this.timezone
  });

}