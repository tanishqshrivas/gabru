import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC8E6C9), // Light green background
      body: Center(
        child: Image.asset(
          'assets/app_logo.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}