import 'package:flutter/material.dart';
import 'package:smartbin/pages/waitingConfirmation_page.dart';

class FormExchangePage extends StatefulWidget {
  const FormExchangePage({super.key});

  @override
  _FormExchangePageState createState() => _FormExchangePageState();
}

class _FormExchangePageState extends State<FormExchangePage> {
  final _formKey = GlobalKey<FormState>();
  String nim = '', email = '', jumlah = '';
  int currentPoints = 120;
  int requiredPoints = 100;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (currentPoints < requiredPoints) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Poin kamu tidak mencukupi")),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WaitingConfirmationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Text(
            "Penukaran Kredit Poin (KP)",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18, // Ukuran lebih kecil
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(38),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Gambar dengan border radius dan shadow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/voucher.jpg'),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "Poin UCM",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "10 poin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Divider(
                indent: 100,
                endIndent: 100,
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "100 Recycle",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Form Input
              buildInputField(
                label: "Masukan NIM",
                hint: "NIM",
                onChanged: (val) => nim = val,
              ),
              const SizedBox(height: 12),
              buildInputField(
                label: "Masukan Email",
                hint: "email",
                onChanged: (val) => email = val,
              ),
              const SizedBox(height: 12),
              buildInputField(
                label: "Jumlah Yang Ditukarkan",
                hint: "XXXXXX",
                onChanged: (val) => jumlah = val,
              ),
              const SizedBox(height: 55), // Tambahkan jarak ekstra

              // Tombol Kirim
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6DA544),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Text(
                    "Kirim",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required String hint,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          validator: (value) => value!.isEmpty ? "Harus diisi" : null,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}