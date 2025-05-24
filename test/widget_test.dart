import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project/main.dart';
import 'package:project/splash_screen.dart';

void main() {
  testWidgets('Splash screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is Scaffold &&
            widget.backgroundColor == const Color(0xFFC8E6C9),
      ),
      findsOneWidget,
    );

    expect(
      find.byType(CustomPaint),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is CustomPaint && widget.painter is MedicalCrossPainter,
      ),
      findsOneWidget,
    );
  });
}