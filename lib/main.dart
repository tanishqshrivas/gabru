import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'start_screen1.dart';

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
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to StartScreen1 after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/start1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenWidget();
  }
}