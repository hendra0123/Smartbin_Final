import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/signin_page.dart';

void main() {
  testWidgets('SigninPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SigninPage()));

    // Check for title
    expect(find.text('Sign In'), findsOneWidget);

    // Check for username and password fields by key
    expect(find.byKey(const Key('usernameField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);

    // Check for login button by key
    expect(find.byKey(const Key('loginButton')), findsOneWidget);

    // Check for social login texts
    expect(find.text('Continue with Phone number'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);

    // Scroll to bottom to find signupNavButton
    final signupButton = find.byKey(const Key('signupNavButton'));
    await tester.ensureVisible(signupButton);
    expect(signupButton, findsOneWidget);
  });

  testWidgets('Tap login button shows validation if empty', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SigninPage()));

    // Tap login button without entering any text
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump(); // Rebuild UI to show errors

    // Check if validation messages appear
    expect(find.text('Username tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);
  });

  testWidgets('Tap sign up button navigates to SignupPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const SigninPage(),
        // Menyediakan dummy route untuk navigasi
        onGenerateRoute: (settings) {
          if (settings.name == '/signup') {
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('SignupPage')),
              ),
            );
          }
          return null;
        },
      ),
    );

    final signupButton = find.byKey(const Key('signupNavButton'));

    // Pastikan tombol terlihat dan bisa disentuh
    await tester.ensureVisible(signupButton);
    await tester.tap(signupButton);
    await tester.pumpAndSettle();

    // Verifikasi bahwa telah berpindah ke halaman SignupPage dummy
    expect(find.text('SignupPage'), findsOneWidget);
  });
}
