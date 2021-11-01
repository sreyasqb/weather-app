import 'package:flutter/material.dart';

class AddWeatherCard extends StatelessWidget {
  Function onPress;
  AddWeatherCard({required this.onPress});
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap:(){
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.05,vertical:screenheight*0.05),
        height:screenheight*0.45,
        width:screenwidth*0.47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child:Center(
          child: Icon(
            Icons.add,
            color:Colors.grey[700],
            size: screenheight*0.05,
          ),
        ),
        
      ),
    );
  }
}