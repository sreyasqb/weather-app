import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vishwa_test/components/add_weather_card.dart';
import 'package:vishwa_test/components/constants.dart';
import 'package:vishwa_test/components/weather_card.dart';
import 'package:vishwa_test/models/city.dart';
import 'package:vishwa_test/screens/weather_page.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;


List <City> cities=[];
List <String> namesOfCities=["Brasilia ","Coimbatore","Chennai",];
DateTime timeNow=DateTime.now();

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // print(timeNow.toUtc().millisecondsSinceEpoch);
    
    for (String city in namesOfCities) {
      getInfo(city);
    }
    
  }

  void getInfo(String city) async {
    http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=d6ea61dc7abbaa7a34606beff25b1a7b"),
      
      );
      Map dataJson= jsonDecode(response.body);
      // print(dataJson['sys']['sunrise']);
      // print(DateTime.fromMillisecondsSinceEpoch(dataJson['sys']['sunrise']*1000));
      // print(DateTime.fromMillisecondsSinceEpoch(dataJson['sys']['sunset']*1000));
      
      //print(dataJson);
      // print("${dataJson['timezone']} $indiaTimeZone");
      
      DateTime localTime=DateTime.fromMillisecondsSinceEpoch((dataJson['timezone']-indiaTimeZone)*1000+timeNow.toUtc().millisecondsSinceEpoch);
      DateTime sunrise=DateTime.fromMillisecondsSinceEpoch((dataJson['timezone']-indiaTimeZone)*1000 + dataJson['sys']['sunrise']*1000);
      DateTime sunset=DateTime.fromMillisecondsSinceEpoch((dataJson['timezone']-indiaTimeZone)*1000 +dataJson['sys']['sunset']*1000);
      // print("$sunset - $sunrise - $localTime");
      setState(() {
        
        
        
        // print("${sunset.compareTo(localTime)>0 && sunrise.compareTo(localTime)<0}");
        cities.add(
          City(
            name: city,
            temp:(dataJson["main"]["temp"]-273.15).round(),
            minTemp: (dataJson["main"]["temp_min"]-273.15).round(),
            maxTemp: (dataJson["main"]["temp_max"]-273.15).round(),
            
            weatherIcon:Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:30),
            feelsLike: (dataJson["main"]["feels_like"]-273.15).round(),
            description: dataJson["weather"][0]["description"],
            sunrise: sunrise,
            sunset: sunset,
            image: sunset.compareTo(localTime)>0 && sunrise.compareTo(localTime)<0? "assets/day.jpg" :"assets/night.jpg",
            humidity: dataJson['main']['humidity'],
            wind: (dataJson["wind"]["speed"]*1.6).round(),
            precipitation:0,
            rainPercentage: 0,
            localTime: localTime,
            timezone: dataJson['timezone'],

            // rainPercentage: 

          )
        );
      });
  }

  @override
  
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        height:screenheight,
        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.02,vertical:screenheight*0.04),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cities!=[] ? [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(city: cities[0],
                  onPress: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(city:cities[0])));
                  },
                ),
                WeatherCard(city: cities[1],
                  onPress: (){
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(city:cities[1])));
                  },
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(city: cities[2],
                  onPress: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(city:cities[2])));
                  },
                ),
                AddWeatherCard(
                  onPress: (){},
                ),
              ],
            )
          ] : [],
        )
      ),
    );
  }
}