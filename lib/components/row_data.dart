import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class RowData extends StatelessWidget {
  String text1,text2,data1,data2;
  
  RowData({required this.text1,required this.text2,required this.data1,required this.data2});


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      
      height:screenheight*0.09,
      padding: EdgeInsets.symmetric(horizontal: screenwidth*0.1,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:screenheight*0.03,
                child:AutoSizeText(
                  text1,
                  presetFontSizes: [16,14,12,10],
                  style: TextStyle(
                    color:Colors.grey,
                    fontWeight: FontWeight.w500,

                  )
                ),
              ),
              Container(
                height:screenheight*0.05,
                child:AutoSizeText(
                  data1,
                  presetFontSizes: [30,28,26,24],
                  style: TextStyle(
                    color:Colors.black,
                    fontWeight: FontWeight.w500,
                  )
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height:screenheight*0.03,
                child:AutoSizeText(
                  text2,
                  presetFontSizes: [16,14,12,10],
                  style: TextStyle(
                    color:Colors.grey,
                    fontWeight: FontWeight.w500,

                  )
                ),
              ),
              Container(
                height:screenheight*0.05,
                child:AutoSizeText(
                  data2,
                  presetFontSizes: [30,28,26,24],
                  style: TextStyle(
                    color:Colors.black,
                    fontWeight: FontWeight.w500,
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}