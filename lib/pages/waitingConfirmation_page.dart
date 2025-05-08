import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaitingConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menunggu Permintaan")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/waiting.svg', height: 200),
              SizedBox(height: 20),
              Text("Menunggu Permintaan",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                "Penukaran kamu sedang dikonfirmasi,\nmohon menunggu selama maksimal\n3 x 24 jam di hari kerja",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
