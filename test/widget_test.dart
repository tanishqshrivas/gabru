import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/main.dart';
import 'package:project/splash_screen.dart';
import 'package:project/start_screen1.dart';

void main() {
  group('Splash Screen Tests', () {
    testWidgets('Splash screen displays correctly', (WidgetTester tester) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Verify the splash screen is displayed with the correct background color
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Scaffold &&
              widget.backgroundColor == const Color(0xFFC8E6C9),
        ),
        findsOneWidget,
        reason: 'Splash screen should have a light green background color',
      );

      // Verify the logo image is displayed
      expect(
        find.byKey(Key('splash_logo')),
        findsOneWidget,
        reason: 'Splash screen should display the app logo image',
      );

      // Verify the image is the correct asset
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == 'assets/app_logo.png',
        ),
        findsOneWidget,
        reason: 'Splash screen should display the correct logo image asset',
      );
    });

    testWidgets('Splash screen navigates to StartScreen1 after 2 seconds',
            (WidgetTester tester) async {
          // Build the app and trigger a frame
          await tester.pumpWidget(MyApp());

          // Wait for the 2-second delay (plus a little extra to ensure navigation completes)
          await tester.pump(Duration(seconds: 2));
          await tester.pumpAndSettle(); // Wait for navigation animations to complete

          // Verify that StartScreen1 is now displayed
          expect(
            find.byKey(Key('start_screen1')),
            findsOneWidget,
            reason: 'App should navigate to StartScreen1 after 2 seconds',
          );

          // Verify some elements of StartScreen1 to ensure correct navigation
          expect(
            find.text('Never Miss Your Medicine'),
            findsOneWidget,
            reason: 'StartScreen1 should display its title text',
          );
        });
  });
}