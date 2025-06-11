import 'package:flutter/material.dart';

class StartScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE5E5), // Light red at the top
              Colors.white, // White at the bottom
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),

            // Replaced shield icon with uploaded image
            Icon(Icons.shield_outlined, color: Colors.red[600], size: 50),

            SizedBox(height: 12),

            // Title text
            Text(
              "Emergency Support",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 12),

            // Subtitle text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Quick access to emergency contacts\n and medical history when needed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),

            Spacer(),

            // Pagination dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF44336), // Active dot (red)
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Get Started button
            Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sign_in');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF44336), // Red button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
