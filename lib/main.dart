
import 'package:flutter/material.dart';
import 'package:project/home_page.dart';
import 'package:project/login_page.dart';
import 'package:project/splash_screen.dart';
import 'package:project/start_screen1.dart';
import 'package:project/start_screen2.dart';
import 'package:project/start_screen3.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/start1': (context) => StartScreen1(),
        '/start2': (context) => StartScreen2(),
        '/start3': (context) => StartScreen3(),
        '/sign_in': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
