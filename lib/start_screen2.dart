import 'package:flutter/material.dart';

class StartScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Light green at the top
              Colors.white, // White at the bottom
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            // Chat bubble icon in a green circle
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF4CAF50), // Green circle background
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            // Title text
            Text(
              "AI Health Assistant",
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
                "Get instant answers to your health questions with our smart chatbot",
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
                    color: Colors.grey, // Inactive dot
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4CAF50), // Active dot (green)
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
                  Navigator.pushReplacementNamed(context, '/start3');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Green button
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