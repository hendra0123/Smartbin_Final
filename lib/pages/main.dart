import 'package:smartbin/pages/onBoarding_page.dart';
import 'package:smartbin/pages/qrscan_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartbin/pages/home_page.dart';
import 'package:smartbin/pages/redeem_page.dart';
import 'package:smartbin/pages/maps_page.dart';
import 'package:smartbin/pages/education_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottle App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final Color activeColor = const Color(0xFF6BA15E); // Hijau
  final Color inactiveColor = Colors.black87;

  List<Widget> pages = [
    const HomePage(),
    RedeemPage(),
    MapsPage(),
    const EducationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QRScannerPage()),
          );
        },
        backgroundColor: activeColor,
        child: const Icon(Icons.qr_code_scanner, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // LEFT SIDE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
                  _buildNavItem(
                      icon: Icons.storefront, label: 'Redeem', index: 1),
                ],
              ),
              // RIGHT SIDE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(icon: Icons.map, label: 'Maps', index: 2),
                  _buildNavItem(
                      icon: Icons.school, label: 'Education', index: 3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    bool isSelected = _selectedIndex == index;
    return MaterialButton(
      minWidth: 40,
      onPressed: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 28,
          ),
          const SizedBox(height: 4),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : inactiveColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
