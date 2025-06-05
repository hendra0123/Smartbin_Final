import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/phoneNumber_page.dart';
import 'package:smartbin/pages/otpVerification_page.dart';

void main() {
  testWidgets('PhoneNumberPage UI and validation test',
      (WidgetTester tester) async {
    // 📌 PURPOSE:
    // This test verifies that the PhoneNumberPage renders correctly,
    // validates the phone number input properly, and navigates to OtpVerificationPage
    // with the correct phone number when the form is submitted with valid input.

    // ✅ EXPECTED OUTCOME:
    // - The page title, TextFormField, and submit button are rendered.
    // - When submitting empty input, validation error 'Nomor telepon tidak boleh kosong' appears.
    // - When submitting invalid input (wrong format), validation error 'Format nomor telepon tidak valid' appears.
    // - When submitting valid input, navigates to OtpVerificationPage and passes the phone number.

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - PhoneNumberPage and OtpVerificationPage exist and can be instantiated.
    // - OtpVerificationPage has a constructor that takes a phoneNumber string parameter.
    // - Navigation context is properly provided by MaterialApp.

    // 🔧 Render the PhoneNumberPage inside MaterialApp for proper widget context.
    await tester.pumpWidget(
      MaterialApp(home: PhoneNumberPage()),
    );

    // ⏳ Wait for the widget to settle.
    await tester.pumpAndSettle();

    // ✅ Verify page title is displayed
    expect(find.text('Masukkan Nomor Telepon'), findsOneWidget);

    // ✅ Verify TextFormField with hint is present
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Contoh: 081234567890'), findsOneWidget);

    // ✅ Verify submit button is present
    final sendOtpButton = find.widgetWithText(ElevatedButton, 'Kirim Kode OTP');
    expect(sendOtpButton, findsOneWidget);

    // ✏️ Attempt to submit empty form to trigger validation error
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();

    // 🔍 EXPECTATION: Validation error message for empty phone number
    expect(find.text('Nomor telepon tidak boleh kosong'), findsOneWidget);

    // ✏️ Enter invalid phone number (includes letters)
    await tester.enterText(find.byType(TextFormField), '123abc');
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();

    // 🔍 EXPECTATION: Validation error message for invalid format
    expect(find.text('Format nomor telepon tidak valid'), findsOneWidget);

    // ✏️ Enter valid phone number
    await tester.enterText(find.byType(TextFormField), '081234567890');
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();

    // 🔍 EXPECTATION: Navigates to OtpVerificationPage with the correct phone number
    expect(find.byType(OtpVerificationPage), findsOneWidget);

    // 🕵️‍♂️ Confirm that the phone number is passed correctly to OtpVerificationPage
    final otpPage =
        tester.widget<OtpVerificationPage>(find.byType(OtpVerificationPage));
    expect(otpPage.phoneNumber, '081234567890');
  });
}
