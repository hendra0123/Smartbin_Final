import 'package:smartbin/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartbin/services/auth_service.dart';
// import 'package:smartbin/services/api_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage> {
  // const SignupPage({super.key});
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String responseMessage = "";

  void _registerUser() async {
    final authService = AuthService();
    final response = await authService.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      responseMessage = response;
    });

    // Optional: show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response)),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Join us! ',
                    style: TextStyle(
                        color: Color.fromRGBO(105, 155, 77, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'and be part of',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'the ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'recycling',
                    style: TextStyle(
                        color: Color.fromRGBO(105, 155, 77, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                'movement',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _registerUser(); // Call the register function
                  // Optionally, navigate to another page or show a success message 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                },
                icon: Icon(Icons.phone, color: Colors.green),
                label: const Text(
                  "Continue with Phone number",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: SignupPage with Google
                },
                icon: SvgPicture.asset('assets/images/google.svg', height: 24),
                label: const Text("Continue with Google",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninPage()));
                    },
                    child: const Text(
                      'Sign in here',
                      style: TextStyle(
                          color: Color.fromRGBO(105, 155, 77, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
