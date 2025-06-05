import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Test for actual elements in your app
    expect(find.byType(Scaffold), findsOneWidget);
    // Add more expectations for your actual UI
  });
}