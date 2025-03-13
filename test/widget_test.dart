import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_task/main.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if home screen loads by checking if a known text appears.
    expect(find.text('My Flutter App'), findsOneWidget);

    // Check if the drawer menu icon is present.
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
