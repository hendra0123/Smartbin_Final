import 'package:smartbin/pages/signin_page.dart';
import 'package:smartbin/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Let's Start",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Recycling",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(105, 153, 77, 1)),
              ),
              Row(
                children: [
                  Text(
                    'with ',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Smartbin",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(105, 153, 77, 1),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // Gambar ilustrasi (gunakan asset atau network image)
              Expanded(
                child: SvgPicture.asset(
                  'assets/images/earth.svg',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Sign Up if you first time and Sign In to proceed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(105, 153, 77, 1),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("OR")),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.green),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Color.fromRGBO(105, 153, 77, 1), fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
