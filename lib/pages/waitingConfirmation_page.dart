import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaitingConfirmationPage extends StatelessWidget {
  const WaitingConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menunggu Permintaan")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/waiting.svg', height: 200),
              const SizedBox(height: 20),
              const Text("Menunggu Permintaan",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                "Penukaran kamu sedang dikonfirmasi,\nmohon menunggu selama maksimal\n3 x 24 jam di hari kerja",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
