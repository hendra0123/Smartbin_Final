import 'package:flutter/material.dart';
import 'package:smartbin/pages/otpVerification_page.dart'; // Halaman OTP yang akan kita buat

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitPhoneNumber() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text;
      // TODO: Implementasi logika pengiriman nomor telepon ke backend/Firebase Auth
      // Untuk saat ini, kita langsung navigasi ke halaman OTP dengan nomor telepon
      print('Nomor Telepon: $phoneNumber');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationPage(phoneNumber: phoneNumber),
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Masukkan Nomor Telepon',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Kami akan mengirimkan kode verifikasi ke nomor telepon Anda.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 081234567890',
                    labelText: 'Nomor Telepon',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                      return 'Format nomor telepon tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(105, 153, 77, 1),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Kirim Kode OTP",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
