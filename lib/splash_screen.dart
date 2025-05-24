import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E986), // Light green background
      body: Center(
        child: CustomPaint(
          size: Size(100, 100),
          painter: MedicalCrossPainter(),
        ),
      ),
    );
  }
}

class MedicalCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF4CAF50) // Green color for the cross
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12 // Thicker stroke to match the design
      ..strokeCap = StrokeCap.round;

    final double armLength = size.width * 0.3;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Define the path for the cross with a continuous line
    final path = Path();

    // Start at the top-left arm
    path.moveTo(centerX - armLength, centerY - armLength);

    // Top arm: move down
    path.lineTo(centerX - armLength, centerY);

    // Left arm: move right
    path.lineTo(centerX, centerY);

    // Right arm: move right
    path.lineTo(centerX + armLength, centerY);

    // Bottom arm: move down
    path.lineTo(centerX + armLength, centerY + armLength);

    // Loop back to the top-left arm
    path.lineTo(centerX, centerY + armLength); // Bottom to center
    path.lineTo(centerX, centerY); // Center to middle
    path.lineTo(centerX - armLength, centerY); // Middle to left
    path.lineTo(centerX - armLength, centerY - armLength); // Left to top

    // Continue the line from top-left to bottom-right with a curve
    path.quadraticBezierTo(
      centerX - armLength, centerY - armLength + 20, // Control point
      centerX, centerY + armLength + 10, // End point near the bottom-right
    );

    // Draw the path
    canvas.drawPath(path, paint);

    // Draw the small circle at the bottom-right
    final circlePaint = Paint()
      ..color = Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(
      Offset(centerX + 10, centerY + armLength + 10),
      5,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}