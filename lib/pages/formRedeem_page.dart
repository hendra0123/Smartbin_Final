import 'package:flutter/material.dart';
import 'package:smartbin/pages/waitingConfirmation_page.dart';

class FormRedeemPage extends StatefulWidget {
  @override
  _FormRedeemPageState createState() => _FormRedeemPageState();
}

class _FormRedeemPageState extends State<FormRedeemPage> {
  final _formKey = GlobalKey<FormState>();
  String nim = '', email = '', jumlah = '';

  // Contoh data poin (ini bisa kamu ganti dari backend nantinya)
  int currentPoints = 120;
  int requiredPoints = 100;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (currentPoints < requiredPoints) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Poin kamu tidak mencukupi")),
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
      appBar: AppBar(title: Text("Penukaran Kredit Poin (KP)")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset('assets/images/voucher.jpg', height: 150),
              Text("Poin UCM",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // Informasi Poin
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Poin yang kamu miliki:"),
                  Text("$currentPoints Recycle",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Poin yang dibutuhkan:"),
                  Text("$requiredPoints Recycle",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(height: 30),

              TextFormField(
                decoration: InputDecoration(labelText: "Masukkan NIM"),
                validator: (value) => value!.isEmpty ? "Harus diisi" : null,
                onChanged: (val) => nim = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Masukkan Email"),
                validator: (value) => value!.isEmpty ? "Harus diisi" : null,
                onChanged: (val) => email = val,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: "Jumlah yang ditukarkan"),
                validator: (value) => value!.isEmpty ? "Harus diisi" : null,
                onChanged: (val) => jumlah = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text("Kirim"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
