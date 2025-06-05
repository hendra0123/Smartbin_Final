import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/signup_page.dart';

void main() {
  testWidgets('SignupPage UI test', (WidgetTester tester) async {
    // Build SignupPage widget inside MaterialApp for Navigator and Theme support
    await tester.pumpWidget(
      const MaterialApp(
        home: SignupPage(),
      ),
    );

    // Check AppBar title
    // NOTE: Judul AppBar di SignupPage kamu adalah 'Create Account', bukan 'Sign Up'
    expect(find.text('Create Account'), findsOneWidget);

    // Check welcome texts
    expect(find.text('Join us! '), findsOneWidget);
    expect(find.text('and be part of'), findsOneWidget);
    expect(find.text('recycling'), findsOneWidget);
    expect(find.text('movement'), findsOneWidget);

    // Check presence of 3 TextFields (username, email, password)
    expect(find.byType(TextField), findsNWidgets(3));

    // Check TextField hints
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration != null &&
            widget.decoration!.hintText == 'username',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration != null &&
            widget.decoration!.hintText == 'email',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration != null &&
            widget.decoration!.hintText == 'password',
      ),
      findsOneWidget,
    );

    // Check ElevatedButton with text "Sign Up"
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);

    // Instead of find.widgetWithText for OutlinedButton.icon,
    // just check the presence of the texts inside the buttons
    expect(find.text('Continue with Phone number'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);

    // Check bottom navigation texts for Sign In
    expect(find.text('Have an account?'), findsOneWidget);
    expect(find.text('Sign in here'), findsOneWidget);
  });
}
