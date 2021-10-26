import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class TimeWeather extends StatelessWidget {
  int time;
  int temperature;
  Icon weatherIcon;
  TimeWeather({required this.time,required this.temperature,required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      height: screenheight*0.18,
      width:screenwidth*0.23,
      child:Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height:screenheight*0.02,
            child: AutoSizeText(
              
              time/12 <1 ? "$time AM" :"${time%12} PM",
              presetFontSizes: [16,14,12,10],
              style: TextStyle(
                color:Colors.grey,
                fontWeight: FontWeight.w500,
              )
            ),
          ),
          SizedBox(height: screenheight*0.01,),
          
          CircleAvatar(
            radius: screenwidth*0.06,
            child:Center(child: weatherIcon),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(height: screenheight*0.01,),
          Container(
            height:screenheight*0.04,
            child: AutoSizeText(
              
              "${temperature.toString()}"+"\u00B0",
              presetFontSizes: [22,20,18,16],
              style: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.w500,
              )
            ),
          ),
        ],
      )

    );
  }
}