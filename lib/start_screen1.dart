import 'package:flutter/material.dart';

class StartScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE6F0FA), // Light blue at the top
              Colors.white, // White at the bottom
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            // Pill icon in a blue circle
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2196F3), // Blue circle background
              ),
              child: Icon(
                Icons.medication,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            // Title text
            Text(
              "Never Miss Your Medicine",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Subtitle text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Get timely reminders for all your medications with smart notifications",
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
                    color: Color(0xFF2196F3), // Active dot (blue)
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey, // Inactive dot
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey, // Inactive dot
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            // Next button
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to the next screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2196F3), // Blue button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "Next",
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