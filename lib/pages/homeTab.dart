import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartbin/widget/youtubeCard.dart';
import 'package:smartbin/pages/quizDetail_page.dart'; // Import halaman detail quiz

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  final List<Map<String, String>> videoList = const [
    {
      'videoId': '6jQ7y_qQYUA',
      'title': 'Belajar Recycle',
    },
    {
      'videoId': 'xpAnLXc_bIU',
      'title': 'Importance of Recycle',
    },
    {
      'videoId': '71DmyhloazQ',
      'title': 'Recycling',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Trending about recycle',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              final video = videoList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: YoutubeVideoCard(
                  videoId: video['videoId']!,
                  title: video['title']!,
                ),
              );
            },
          ),
        ),

        // Quiz section
        const SizedBox(height: 24),
        const Text(
          'Kuis recycle',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Belajar tanpa aksi hanyalah teori, seperti peta tanpa perjalanan.',
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              QuizCard(
                title: 'Recycle dalam dunia pendidikan',
                questionCount: '10 pertanyaan',
                points: '2500',
                quizTitle: 'Quiz Pendidikan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const QuizDetailPage(title: 'Quiz Pendidikan'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final String questionCount;
  final String points;
  final String quizTitle;
  final VoidCallback onTap;

  const QuizCard({
    Key? key,
    required this.title,
    required this.questionCount,
    required this.points,
    required this.quizTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 16, left: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF3CD3AD), Color(0xFF4CB8C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              offset: const Offset(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.recycling, size: 36, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              quizTitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.help_outline, size: 18, color: Colors.white70),
                const SizedBox(width: 6),
                Text(
                  questionCount,
                  style: const TextStyle(color: Colors.white70),
                ),
                const Spacer(),
                SvgPicture.asset('assets/images/coin.svg', height: 18),
                const SizedBox(width: 4),
                Text(
                  points,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress Bar
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: LinearProgressIndicator(
            //     value: progress,
            //     backgroundColor: Colors.white24,
            //     color: Colors.yellowAccent,
            //     minHeight: 8,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
