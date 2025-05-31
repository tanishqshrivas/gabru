
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/start1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenWidget();
  }
}

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC8E6C9),
      body: Center(
        child: Image.asset(
          'assets/logo_sanjeevika.jpeg',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
