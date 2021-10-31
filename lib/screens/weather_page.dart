import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vishwa_test/components/constants.dart';
import 'package:vishwa_test/components/row_data.dart';
import 'package:vishwa_test/components/time_weather.dart';
import 'package:vishwa_test/components/week_weather.dart';
import 'package:vishwa_test/models/city.dart';
import 'package:vishwa_test/models/hourly_weather.dart' ;
import 'package:vishwa_test/screens/home_page.dart' show timeNow;
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;


class WeatherPage extends StatefulWidget {
  City city;
  WeatherPage({required this.city});
  @override
  _WeatherPageState createState() => _WeatherPageState(city);
}

class _WeatherPageState extends State<WeatherPage> {
  List <HourlyWeather> hourly=[];
  City city;
  _WeatherPageState(this.city);
  int weather=0;
  int feelsLike=0;
  String description='Partly cloudy';
  String sunrise="06:51";
  String sunset="18:45";
  int rainPercentage=10,humidity=72,wind=34,precipitation=0;

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    // print(timeNow.hour);
    // print(city.sunrise);
    // print(city.sunset);
    // print(DateFormat('hh:mm a').format(city.sunrise));
    

    getInfo();
    // print(hourly);


  }
  void getInfo() async {
    
      http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=${city.name}&mode=json&appid=d6ea61dc7abbaa7a34606beff25b1a7b"));
      
     
      Map dataJson= jsonDecode(response.body);
      // print(dataJson);
      var weatherList=dataJson['list'];
      // print(weatherList);
      // print(DateTime);
      
      
      
      for (int i = 0 ;i<24-city.localTime.hour;i++){
        int testTime=weatherList[i]['dt']*1000;
        DateTime predHours=DateTime.fromMillisecondsSinceEpoch((city.timezone-indiaTimeZone)*1000+testTime);
        if (DateTime(city.localTime.year, city.localTime.month, city.localTime.day).difference(DateTime(predHours.year, predHours.month, predHours.day)).inDays<0){
          break;
        }
        setState(() {
          hourly.add(HourlyWeather(time: predHours, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:30), temp: (weatherList[i]['main']['temp']-273.15).round()));
        });

      }
      // print(hourly.length);

      // print(hourly);
      

      

  }


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: screenheight*0.1),
                  height: screenheight*0.55,
                  width:screenwidth,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                    image:DecorationImage(
                      image:AssetImage(city.image),
                      fit:BoxFit.cover,
                    )
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                      Container(
                        height: screenheight*0.1,
                        child: AutoSizeText(
                          city.name,
                          presetFontSizes: [30,28,26,24,22],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:Colors.white,
                          ),
                          
                        ),
                      ),
                      Container(
                        height:screenheight*0.15,
                        child: AutoSizeText(
                          
                          " "+city.temp.toString()+"\u00B0",
                          presetFontSizes: [100,90,80,70],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height:screenheight*0.05,
                        child: AutoSizeText(
                          
                          city.description,
                          presetFontSizes: [20,18,16,14],
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height:screenheight*0.05,
                        child: AutoSizeText(
                          
                          "Feels like ${city.feelsLike}\u00B0",
                          presetFontSizes: [16,14,12,10],
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      
                    ],
                  )
          
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth*0.05),
                  alignment: Alignment.bottomLeft,
                  height: screenheight*0.05,
                  child:AutoSizeText(
                    "Today's forecast",
                    
                    presetFontSizes: [25,23,21,19],
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      color:Colors.black,
                    )
                  )
                ),
                SizedBox(height:screenheight*0.01),
                Container(
                  height: screenheight*0.15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                      hourly!=[]? 
                      hourly.map((hour)=>TimeWeather(hourly: hour)).toList():[],
                      // TimeWeather(time: 12, temperature: 2, weatherIcon: Icon(WeatherIcons.night_alt_rain_wind,color: Colors.black,size:screenheight*0.03)),
                      
                    )
                  ),
                ),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                SizedBox(height:screenheight*0.02),
                RowData(text1:"SUNRISE",data1:DateFormat('hh:mm a').format(city.sunrise),text2:"SUNSET",data2:DateFormat('hh:mm a').format(city.sunset)),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                RowData(text1:"CHANCE OF RAIN (%)",data1:city.rainPercentage.toString(),text2:"HUMIDITY (%)",data2:city.humidity.toString(),),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                RowData(text1:"WIND (km/hour)",data1:city.wind.toString(),text2:"PRECIPITAION (mm)",data2:city.precipitation.toString(),),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth*0.05),
                  alignment: Alignment.bottomLeft,
                  height: screenheight*0.05,
                  child:AutoSizeText(
                    "This week's forecast",
                    
                    presetFontSizes: [25,23,21,19],
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      color:Colors.black,
                    )
                  )
                ),
                SizedBox(height:screenheight*0.05),
                Container(
                  height: screenheight*0.1,
                  padding: EdgeInsets.only(left:screenwidth*0.05),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                    children: [
                        WeekWeather(day: "MONDAY", maxTemp: 11, minTemp: 5, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03)),
                        SizedBox(width:screenwidth*0.05),
                        WeekWeather(day: "TUESDAY", maxTemp: 13, minTemp: 7, weatherIcon: Icon(WeatherIcons.sunrise,color: Colors.black,size:screenheight*0.03)),
                        SizedBox(width:screenwidth*0.05),
                        WeekWeather(day: "WEDNESDAY", maxTemp: 11, minTemp: 5, weatherIcon: Icon(WeatherIcons.day_cloudy_high,color: Colors.black,size:screenheight*0.03)),
                        SizedBox(width:screenwidth*0.05),
                        WeekWeather(day: "THURSDAY", maxTemp: 9, minTemp: 4, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03)),
                        SizedBox(width:screenwidth*0.05),
                      ]
                    )
                  ),
                ),
                SizedBox(height: screenheight*0.02),
    
    
    
                
              ],
            ),
          )
        ),
    );
  }
}


