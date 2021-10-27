import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vishwa_test/components/row_data.dart';
import 'package:vishwa_test/components/time_weather.dart';
import 'package:vishwa_test/components/week_weather.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String city="Prague";
  int weather=6;
  String description='Partly cloudy';
  String sunrise="06:51";
  String sunset="18:45";
  int rainPercentage=10,humidity=72,wind=34,precipitation=0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: screenheight*0.1),
                  height: screenheight*0.55,
                  width:screenwidth,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                    image:DecorationImage(
                      image:AssetImage('assets/night.jpg'),
                      fit:BoxFit.cover,
                    )
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                      Container(
                        height: screenheight*0.1,
                        child: AutoSizeText(
                          city,
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
                          
                          " "+weather.toString()+"\u00B0",
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
                          
                          description,
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
                          
                          "Feels like 4\u00B0",
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
                    children: [
                      TimeWeather(time: 18, temperature: 4, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03)),
                      TimeWeather(time: 19, temperature: 4, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03)),
                      TimeWeather(time: 20, temperature: 3, weatherIcon: Icon(WeatherIcons.night_alt_lightning,color: Colors.black,size:screenheight*0.03)),
                      TimeWeather(time: 21, temperature: 2, weatherIcon: Icon(WeatherIcons.night_alt_rain_mix,color: Colors.black,size:screenheight*0.03)),
                      TimeWeather(time: 22, temperature: 2, weatherIcon: Icon(WeatherIcons.night_alt_cloudy,color: Colors.black,size:screenheight*0.03)),
                      TimeWeather(time: 23, temperature: 2, weatherIcon: Icon(WeatherIcons.night_alt_showers,color: Colors.black,size:screenheight*0.03)),
                      // TimeWeather(time: 12, temperature: 2, weatherIcon: Icon(WeatherIcons.night_alt_rain_wind,color: Colors.black,size:screenheight*0.03)),
                      ]
                    )
                  ),
                ),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                SizedBox(height:screenheight*0.02),
                RowData(text1:"SUNRISE",data1:sunrise,text2:"SUNSET",data2:sunset),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                RowData(text1:"CHANCE OF RAIN (%)",data1:rainPercentage.toString(),text2:"HUMIDITY (%)",data2:humidity.toString(),),
                Divider(
                  indent:screenwidth*0.1,
                  endIndent:screenwidth*0.1,
                  color: Colors.grey,
                ),
                RowData(text1:"WIND (km/hour)",data1:wind.toString(),text2:"PRECIPITAION (cm)",data2:precipitation.toString(),),
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


