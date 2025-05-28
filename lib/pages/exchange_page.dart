import 'package:flutter/material.dart';
import 'package:smartbin/controller/points_controller.dart';
import 'package:smartbin/pages/formExchange_page.dart';

class ExchangePage extends StatelessWidget {
  const ExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // Top green header dengan gradient
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF164C3E), // hijau tua
                  Color(0xFF69994D), // hijau muda
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Redeem",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 0), // Padding antara judul dan coin
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on,
                              color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          ValueListenableBuilder<int>(
                            valueListenable: PointsController.points,
                            builder: (context, value, child) => Text(
                              '$value',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "Receive a small thankyou\nfrom us for your big\nefforts!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),

          // Voucher section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Poin & Vouchers",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 20), // Tambahan jarak antar judul dan kartu
                _buildVoucherCard(
                  context,
                  image: 'assets/images/voucher.jpg',
                  title: 'Poin UCM',
                  subtitle: 'Tukarkan ke poin digital',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormExchangePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
          trailing:
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF2D6B47)),
        ),
      ),
    );
  }
}
