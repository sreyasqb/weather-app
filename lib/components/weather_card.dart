import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vishwa_test/models/city.dart';
import 'package:vishwa_test/screens/weather_page.dart';
class WeatherCard extends StatelessWidget {
  City city;
  Function onPress;
  WeatherCard({required this.city,required this.onPress});


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        onPress();
        // Navigator.push(context,MaterialPageRoute(builder:(context)=>WeatherPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.05,vertical:screenheight*0.05),
        height:screenheight*0.45,
        width:screenwidth*0.47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image:DecorationImage(
            image:AssetImage(city.image),
            fit:BoxFit.cover,
          )
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              height: screenheight*0.05,
              child: AutoSizeText(
                city.name,
                presetFontSizes: [30,28,26,24,22],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:Colors.white,
                ),
                
              ),
            ),
            SizedBox(height:screenheight*0.02),
            CircleAvatar(
              radius:screenheight*0.04,
              backgroundColor: Colors.grey[200],
              child:Center(
                child:city.weatherIcon,
              )
            ),
            Container(
              height: screenheight*0.1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height:screenheight*0.05,
                    child:AutoSizeText(
                      city.maxTemp.toString()+"\u00B0",
                      presetFontSizes: [28,26,24,22],
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ),
                  SizedBox(width:screenwidth*0.02),
                  Container(
                    height:screenheight*0.05,
                    child:AutoSizeText(
                      city.minTemp.toString()+"\u00B0",
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
      ),
    );
  }
}