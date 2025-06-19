import 'package:flutter/material.dart';
import 'package:smartbin/pages/waitingConfirmation_page.dart';
import 'package:smartbin/utils/exchange_validator.dart'; // ✅ Tambahkan import

class FormExchangePage extends StatefulWidget {
  final int currentPoints;
  final int requiredPoints;

  const FormExchangePage({
    super.key,
    this.currentPoints = 120,
    this.requiredPoints = 100,
  });

  @override
  _FormExchangePageState createState() => _FormExchangePageState();
}

//entahlah  testing 223121

class _FormExchangePageState extends State<FormExchangePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      int enteredPoints = int.tryParse(_jumlahController.text) ?? 0;

      // ✅ Gunakan fungsi eksternal yang dapat di-unit test
      final result = validateExchange(
        currentPoints: widget.currentPoints,
        requiredPoints: widget.requiredPoints,
        enteredPoints: enteredPoints,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
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
        title: const Text(
          "Penukaran Kredit Poin (KP)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
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
                  boxShadow: const [
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
                  "Poin KP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "10 poin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "100 Poin Recycle",
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
                label: "Masukkan NIM",
                hint: "NIM",
                controller: _nimController,
                key: const Key('nimField'),
              ),
              const SizedBox(height: 12),
              buildInputField(
                label: "Masukkan Email",
                hint: "Email",
                controller: _emailController,
                key: const Key('emailField'),
              ),
              const SizedBox(height: 12),
              buildInputField(
                label: "Jumlah Yang Ditukarkan",
                hint: "Misal: 100",
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                key: const Key('jumlahField'),
              ),
              const SizedBox(height: 55),

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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required Key key,
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
          key: key,
          validator: (value) => value!.isEmpty ? "Harus diisi" : null,
          controller: controller,
          keyboardType: keyboardType,
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
