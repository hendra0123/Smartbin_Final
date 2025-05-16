 
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Edukasi',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          centerTitle: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: Colors.green),
                insets: EdgeInsets.symmetric(horizontal: 100.0),
              ),
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Kategori'),
                Tab(text: 'Tips'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            Center(child: Text('Kategori')),
            Center(child: Text('Tips')),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  final List<Map<String, String>> videoList = const [
    {
      'videoId': '6jQ7y_qQYUA&t',
      'title': 'Kenapa harus recycle?',
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
        // Trending section
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
            children: const [
              QuizCard(
                title: 'Recycle dalam dunia pendidikan',
                questionCount: '5 pertanyaan',
                points: '10 poin',
                progress: 0.4,
                quizTitle: 'Quiz Pendidikan',
              ),
              SizedBox(width: 12),
              QuizCard(
                title: 'Dasar-dasar daur ulang',
                questionCount: '8 pertanyaan',
                points: '15 poin',
                progress: 0.0,
                quizTitle: 'Quiz Dasar',
              ),
              SizedBox(width: 12),
              QuizCard(
                title: 'Teknik pemilahan sampah',
                questionCount: '6 pertanyaan',
                points: '12 poin',
                progress: 0.75,
                quizTitle: 'Quiz Pemilahan',
              ),
            ],
          ),
        ),

        // Other information section
        const SizedBox(height: 24),
        const Text(
          'Informasi Lainnya',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const InfoCard(
          title: 'Recycle',
          subtitle: 'Pelajari cara mendaur ulang berbagai jenis material',
          imagePath: 'assets/recycle.png',
        ),
        const InfoCard(
          title: 'Non-Recycle',
          subtitle: 'Material yang tidak bisa didaur ulang dan alternatifnya',
          imagePath: 'assets/nonrecycle.png',
        ),
      ],
    );
  }
}

class YoutubeVideoCard extends StatefulWidget {
  final String videoId;
  final String title;

  const YoutubeVideoCard({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  State<YoutubeVideoCard> createState() => _YoutubeVideoCardState();
}

class _YoutubeVideoCardState extends State<YoutubeVideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            width: 300,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              FullScreenButton(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final String questionCount;
  final String points;
  final double progress;
  final String quizTitle;

  const QuizCard({
    required this.title,
    required this.questionCount,
    required this.points,
    required this.progress,
    required this.quizTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 220,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz title above the icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.quiz, size: 40, color: Colors.purple),
                  const SizedBox(height: 4),
                  Text(
                    quizTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '$questionCount • $points',
                style: const TextStyle(fontSize: 11),
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: Colors.green,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const InfoCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
