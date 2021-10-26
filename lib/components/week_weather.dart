import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WeekWeather extends StatelessWidget {
  final String day;
  final int maxTemp,minTemp;
  final Icon weatherIcon;
  WeekWeather({required this.day,required this.maxTemp,required this.minTemp,required this.weatherIcon});


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      
      width:screenwidth*0.45,
      height:screenheight*0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.grey[300],
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenwidth*0.06,
            child:Center(child: weatherIcon),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width:screenwidth*0.02),
          Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height:screenheight*0.03,
                child:AutoSizeText(
                  day,
                  presetFontSizes: [16,14,12,10],
                  style: TextStyle(
                    color:Colors.grey,
                    fontWeight: FontWeight.w500,

                  )
                ),

              ),
              Container(
                height: screenheight*0.05,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height:screenheight*0.05,
                      child:AutoSizeText(
                        maxTemp.toString()+"\u00B0",
                        presetFontSizes: [28,26,24,22],
                        style: TextStyle(
                          color:Colors.black,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ),
                    SizedBox(width:screenwidth*0.02),
                    Container(
                      height:screenheight*0.05,
                      child:AutoSizeText(
                        minTemp.toString()+"\u00B0",
                        presetFontSizes: [28,26,24,22],
                        style: TextStyle(
                          color:Colors.grey,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    )
                  ],
                )
              )
            ],
          )

        ],
      )
    );
  }
}