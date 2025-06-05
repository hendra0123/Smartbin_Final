import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/phoneNumber_page.dart';
import 'package:smartbin/pages/otpVerification_page.dart';

void main() {
  testWidgets('PhoneNumberPage UI and validation test',
      (WidgetTester tester) async {
    // PURPOSE:
    // To test the UI components, validation, and navigation logic of the PhoneNumberPage.

    // EXPECTED OUTCOME:
    // - UI elements should appear as expected.
    // - Validation should trigger when input is empty or invalid.
    // - Valid input should navigate to OtpVerificationPage and pass the phone number.

    // ASSUMPTIONS / PREREQUISITES:
    // - PhoneNumberPage uses a TextFormField with validation.
    // - OtpVerificationPage accepts phoneNumber via constructor.
    // - Navigator.push is used to transition pages.

    // RENDER PHONE NUMBER PAGE
    await tester.pumpWidget(MaterialApp(home: PhoneNumberPage()));

    // Check if the title text is rendered
    expect(find.text('Masukkan Nomor Telepon'), findsOneWidget);

    // Check if the TextFormField and its hint text are rendered
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Contoh: 081234567890'), findsOneWidget);

    // Check if the "Kirim Kode OTP" button is rendered
    final sendOtpButton = find.widgetWithText(ElevatedButton, 'Kirim Kode OTP');
    expect(sendOtpButton, findsOneWidget);

    // SCENARIO 1: Submit without input
    // PURPOSE: Validate that empty input triggers error
    // EXPECTED: "Nomor telepon tidak boleh kosong" appears
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();
    expect(find.text('Nomor telepon tidak boleh kosong'), findsOneWidget);

    // SCENARIO 2: Input invalid phone number format
    // PURPOSE: Ensure input with non-numeric or malformed phone number triggers validation error
    // EXPECTED: "Format nomor telepon tidak valid" appears
    await tester.enterText(find.byType(TextFormField), '123abc');
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();
    expect(find.text('Format nomor telepon tidak valid'), findsOneWidget);

    // SCENARIO 3: Input valid phone number and submit
    // PURPOSE: Check if valid input navigates to OTP page
    // EXPECTED: OtpVerificationPage is shown with correct phone number passed
    await tester.enterText(find.byType(TextFormField), '081234567890');
    await tester.tap(sendOtpButton);
    await tester.pumpAndSettle();

    // Confirm the new page is OtpVerificationPage
    expect(find.byType(OtpVerificationPage), findsOneWidget);

    // Confirm the correct phone number is passed
    final otpPage =
        tester.widget<OtpVerificationPage>(find.byType(OtpVerificationPage));
    expect(otpPage.phoneNumber, '081234567890');
  });
}
