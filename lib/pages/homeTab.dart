import 'package:flutter/material.dart';
import 'package:smartbin/pages/youtubeCard.dart';
import 'package:smartbin/pages/quizDetail_page.dart'; // Import halaman detail quiz

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  final List<Map<String, String>> videoList = const [
    {
      'videoId': '6jQ7y_qQYUA',
      'title': 'Belajar Recycle',
    },
    {
      'videoId': 'xvFZjo5PgG0',
      'title': 'Cara daur ulang botol plastik',
    },
    {
      'videoId': '3tmd-ClpJxA',
      'title': 'Tutorial kompos rumahan',
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
                questionCount: '5 pertanyaan',
                points: '10 poin',
                progress: 0.4,
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
              const SizedBox(width: 12),
              QuizCard(
                title: 'Dasar-dasar daur ulang',
                questionCount: '8 pertanyaan',
                points: '15 poin',
                progress: 0.0,
                quizTitle: 'Quiz Dasar',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const QuizDetailPage(title: 'Quiz Dasar'),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              QuizCard(
                title: 'Teknik pemilahan sampah',
                questionCount: '6 pertanyaan',
                points: '12 poin',
                progress: 0.75,
                quizTitle: 'Quiz Pemilahan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const QuizDetailPage(title: 'Quiz Pemilahan'),
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
  final double progress;
  final String quizTitle;
  final VoidCallback? onTap;

  const QuizCard({
    super.key,
    required this.title,
    required this.questionCount,
    required this.points,
    required this.progress,
    required this.quizTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quizTitle,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(title),
            const Spacer(),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 8),
            Text('$questionCount • $points'),
          ],
        ),
      ),
    );
  }
}
