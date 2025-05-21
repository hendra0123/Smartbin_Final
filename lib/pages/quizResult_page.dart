import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizResultPage extends StatelessWidget {
  final int score;

  const QuizResultPage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxScore = 100; // ubah sesuai jumlah soal
    int coins = score * 25; // misalnya 1 poin = 25 koin

    return Scaffold(
      // backgroundColor: const Color(0xFF0C0C2E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/trophy.png', // tambahkan gambar trofi ke assets
                      height: 180,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You have completed the quiz.',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    const Text(
                      'YOUR SCORE',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$score / $maxScore',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'EARNED COINS',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/coin.svg', // coin icon
                          height: 24,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$coins',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aksi share bisa ditambahkan di sini
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share Results'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // kembali ke halaman awal quiz
                      },
                      child: const Text('Take New Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white38),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
