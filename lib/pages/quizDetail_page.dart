import 'package:flutter/material.dart';

class QuizDetailPage extends StatefulWidget {
  final String title;

  const QuizDetailPage({super.key, required this.title});

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  int currentQuestionIndex = 0;
  bool? isCorrect;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Kotak bekas nasi dari kantin biasanya terbuat dari Kardus. Kotak ini harus dibuang ke tempat sampah mana?',
      'options': ['Recycle', 'Non-Recycle', 'Limbah B3'],
      'correct': 'Recycle',
    },
    // Tambahkan pertanyaan lain di sini
  ];

  void checkAnswer(String selectedOption) {
    final isAnswerCorrect =
        selectedOption == questions[currentQuestionIndex]['correct'];
    setState(() {
      isCorrect = isAnswerCorrect;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAnswerCorrect ? Icons.check_circle : Icons.cancel,
              color: isAnswerCorrect ? Colors.green : Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              isAnswerCorrect
                  ? 'Correct,\nkeep it up!'
                  : 'Wrong answer,\ncheck the question carefully.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  if (currentQuestionIndex < questions.length - 1) {
                    currentQuestionIndex++;
                    isCorrect = null;
                  } else {
                    // TODO: Navigasi ke halaman hasil
                  }
                });
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionButton(String text, IconData icon) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        foregroundColor: Colors.green,
      ),
      onPressed: () => checkAnswer(text),
      icon: Icon(icon),
      label: Expanded(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  IconData getIconForOption(String option) {
    switch (option) {
      case 'Recycle':
        return Icons.recycling;
      case 'Non-Recycle':
        return Icons.delete_outline;
      case 'Limbah B3':
        return Icons.dangerous;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Text(
                question['question'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              ...question['options'].map<Widget>((option) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: buildOptionButton(option, getIconForOption(option)),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
