import 'package:smartbin/pages/editProfile_page.dart';
import 'package:smartbin/pages/qrscan_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartbin/pages/home_page.dart';
import 'package:smartbin/pages/exchange_page.dart';
import 'package:smartbin/pages/maps_page.dart';
import 'package:smartbin/pages/education_page.dart';
import 'package:smartbin/pages/profilehome_page.dart';
import 'package:smartbin/pages/signin_page.dart';

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
      home: SigninPage(),
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
    ExchangePage(),
    MapsPage(),
    const EducationPage(),
    ProfileHomePage(),
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
        backgroundColor: activeColor,
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QRScannerPage()),
          );
        },
        child: const Icon(Icons.qr_code_scanner, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
              _buildNavItem(icon: Icons.storefront, label: 'Redeem', index: 1),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(icon: Icons.map, label: 'Maps', index: 2),
              _buildNavItem(icon: Icons.school, label: 'Education', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    IconData finalIcon;
    switch (label) {
      case 'Home':
        finalIcon = isSelected ? Icons.home : Icons.home_outlined;
        break;
      case 'Redeem':
        finalIcon = isSelected ? Icons.storefront : Icons.storefront_outlined;
        break;
      case 'Maps':
        finalIcon = isSelected ? Icons.map : Icons.map_outlined;
        break;
      case 'Education':
        finalIcon = isSelected ? Icons.school : Icons.school_outlined;
        break;
      default:
        finalIcon = icon;
    }

    return MaterialButton(
      minWidth: 40,
      onPressed: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(finalIcon,
              color: isSelected ? activeColor : inactiveColor, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : inactiveColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
