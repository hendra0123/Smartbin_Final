import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'kategoriDetail_page.dart';

class KategoriTab extends StatelessWidget {
  const KategoriTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArticleCard(context, 'Daur Ulang', 'Recycle',
              'assets/images/recycle.jpg', 'assets/images/plastic.svg'),
          const SizedBox(height: 12),
          _buildArticleCard(context, 'Tidak Dapat di Daur Ulang', 'Non-Recycle',
              'assets/images/nonrecycle.jpg', 'assets/images/fish.svg'),
          const SizedBox(height: 12),
          _buildArticleCard(context, 'Bahan Berbahaya dan Beracun', 'B3',
              'assets/images/b3.jpeg', 'assets/images/battery.svg'),
        ],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, String label, String title,
      String imagePath, String svgIconPath) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke KategoriDetailPage dan kirim label kategori
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KategoriDetailPage(kategori: title),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.green.shade700,
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    svgIconPath,
                    color: Colors.white,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
