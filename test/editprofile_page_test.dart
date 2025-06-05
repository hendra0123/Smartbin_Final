import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/editProfile_page.dart'; // sesuaikan import path

void main() {
  testWidgets('ProfilePage basic UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfilePage(profileImageUrl: ''),
      ),
    );

    // Cek tombol Save ada dan teksnya benar
    final saveButton = find.widgetWithText(ElevatedButton, 'Save');
    expect(saveButton, findsOneWidget);

    // Cek semua label input ada
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);

    // Karena ada 2 widget 'Phone Number', expect 2 widget
    expect(find.text('Phone Number'), findsNWidgets(2));

    // Cek semua TextField ada (4)
    expect(find.byType(TextField), findsNWidgets(4));

    // Cek photo profil ada (CircleAvatar)
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Cek ikon kamera ada (Icon with Icons.camera_alt)
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);

    // Cek tombol back di AppBar ada
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Scroll ke tombol Save agar terlihat dan bisa di tap
    await tester.ensureVisible(saveButton);

    // Tes klik tombol Save, yang memanggil Navigator.pop()
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Setelah pop, seharusnya ProfilePage hilang
    // PASTIKAN di kode ProfilePage tombol Save memang memanggil Navigator.pop()
    expect(find.byType(ProfilePage), findsNothing);
  });
}
