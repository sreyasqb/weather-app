import 'package:flutter/material.dart';
import 'package:vishwa_test/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body:HomePage()
      )
    );
  }
}




