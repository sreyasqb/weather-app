import 'package:flutter/material.dart';
import 'package:vishwa_test/components/add_weather_card.dart';
import 'package:vishwa_test/components/weather_card.dart';
import 'package:vishwa_test/screens/weather_page.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(city: "Prague", image: "assets/night.jpg", maxTemp: 11, minTemp: 6,weatherIcon:Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03),
                  onPress: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage()));
                  },
                ),
                WeatherCard(city: "Coimbatore", image: "assets/day.jpg", maxTemp: 28, minTemp: 22,weatherIcon:Icon(WeatherIcons.day_storm_showers,color: Colors.black,size:screenheight*0.03),
                  onPress: (){
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage()));
                  },
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(city: "Chennai", image: "assets/day.jpg", maxTemp: 32, minTemp: 30,weatherIcon:Icon(WeatherIcons.day_sunny,color: Colors.black,size:screenheight*0.03),
                  onPress: (){},
                ),
                AddWeatherCard(
                  onPress: (){},
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}