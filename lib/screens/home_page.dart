import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vishwa_test/components/add_weather_card.dart';
import 'package:vishwa_test/components/constants.dart';
import 'package:vishwa_test/components/weather_card.dart';
import 'package:vishwa_test/models/city.dart';
import 'package:vishwa_test/screens/weather_page.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;


List <City> cities=[];
List <String> namesOfCities=["Prague","Coimbatore","Chennai","Bangalore"];
DateTime timeNow=DateTime.now();
int index=0;

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hi");
    
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
      // double prec=dataJson['rain']['rain.3h']!=null?dataJson['rain']['rain.3h'] : 0;
      // print(dataJson['rain']['rain.1h']);
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
      print(cities.length);
  }
  

  TextEditingController controller = TextEditingController();

  @override
  
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                WeatherCard(city: cities[3],
                  onPress: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(city:cities[3])));
                  },
                ),
                
              ],
            )
          ] : [],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
        onPressed: ()=>showDialog(
            context: context,
            builder: (context){
              return BackdropFilter(
                filter:ImageFilter.blur(sigmaX: 6,sigmaY: 6),
                child: AlertDialog(
                  insetPadding:EdgeInsets.only(bottom: screenheight*0.3),
                  backgroundColor:Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  
                  content:Container(
                    height: screenheight*0.2,
                    color:Colors.transparent,
                    child: Column(
                      
                      children: [
                        Container(
                          width: screenwidth*0.8,
                          height:screenheight*0.08,
                          
                          decoration:BoxDecoration(
                            color:Colors.blueGrey[900],
                            borderRadius:BorderRadius.circular(20),

                          ),
                          
                          padding:EdgeInsets.only(top:screenheight*0.01),
                          child:TextField(
                            controller:controller,
                            textAlign:TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'City',
                              // prefixIcon:Icon(Icons.search,size:screenheight*0.04,color:Colors.white),
                              // prefixIconConstraints: BoxConstraints(),
                              hintStyle:TextStyle(
                                color:Colors.grey,
                              )
                            ),
                            style:TextStyle(
                              color:Colors.white,
                              fontSize:20,
                              
                            )
                          )
                        ),
                        SizedBox(height:screenheight*0.02),
                        InkWell(
                          onTap:(){
                            setState(() {
                              namesOfCities.add(controller.text);
                              namesOfCities.removeAt(0);
                              cities.removeAt(0);
                              getInfo(controller.text);
                              


                              

                            });
                          },
                          child: CircleAvatar(
                            radius: screenheight*0.03,
                            backgroundColor:Colors.blueGrey[900],
                            child:Center(
                              child:Icon(Icons.search)
                            )
                            
                          ),
                        )
                      ],
                    ),
                  )
                ),
              );
            }

          ),
        child:Icon(Icons.add)


      ),
    );
  }
}