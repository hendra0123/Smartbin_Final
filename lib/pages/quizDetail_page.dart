import 'package:flutter/material.dart';
import 'package:smartbin/pages/quizResult_page.dart';

class QuizDetailPage extends StatefulWidget {
  final String title;

  const QuizDetailPage({super.key, required this.title});

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Manakah dari berikut ini yang termasuk sampah yang dapat didaur ulang?',
      'options': [
        'Kulit pisang',
        'Tisu bekas',
        'Botol plastik',
        'Sisa makanan'
      ],
      'correctIndex': 2,
    },
    {
      'question': 'Apa jenis sampah koran?',
      'options': [
        'Sampah organik',
        'Sampah B3',
        'Sampah yang dapat didaur ulang',
        'Sampah yang tidak dapat didaur ulang'
      ],
      'correctIndex': 2,
    },
    {
      'question': 'Bahan apa yang biasanya dapat didaur ulang?',
      'options': [
        'Stoples kaca',
        'Popok bekas',
        'Puntung rokok',
        'Kemasan Makanan yang berminyak'
      ],
      'correctIndex': 0,
    },
    {
      'question':
          'Mana dari berikut ini yang dapat dimasukkan ke tempat sampah daur ulang?',
      'options': [
        'Busa polistirena',
        'Piring keramik',
        'Kaleng aluminium',
        'Sedotan plastik'
      ],
      'correctIndex': 2,
    },
    {
      'question':
          'Barang mana yang paling baik dikategorikan sebagai barang yang dapat didaur ulang?',
      'options': ['Cermin pecah', 'Kotak kardus', 'Pembalut wanita', 'Baterai'],
      'correctIndex': 1,
    },
    {
      'question': 'Jenis plastik apa yang umumnya dapat didaur ulang?',
      'options': [
        'LDPE (Low-Density Polyethylene)',
        'Pipa PVC',
        'Baki plastik hitam',
        'Kemasan blister'
      ],
      'correctIndex': 0,
    },
    {
      'question': 'Barang apa yang harus dibersihkan sebelum didaur ulang?',
      'options': [
        'Kotak pizza berisi minyak',
        'Botol air plastik kosong',
        'Tisu bekas',
        'Bungkus permen karet'
      ],
      'correctIndex': 1,
    },
    {
      'question':
          'Mengapa penting untuk memisahkan sampah yang dapat didaur ulang?',
      'options': [
        'Untuk membuat kompos',
        'Untuk mengurangi penggunaan TPA',
        'Untuk membakar sampah',
        'Untuk menambah jumlah sampah'
      ],
      'correctIndex': 1,
    },
    {
      'question':
          'Barang apa saja yang dapat didaur ulang jika bersih dan kering?',
      'options': [
        'Wadah makanan bawa pulang (dengan sisa makanan)',
        'Serbet bekas',
        'Botol kaca',
        'Kemasan plastik dengan aluminium foil'
      ],
      'correctIndex': 2,
    },
    {
      'question':
          'Barang apa saja yang berkontribusi terhadap daur ulang dan penggunaan kembali?',
      'options': [
        'Membuang semua sampah dalam satu tempat sampah',
        'Memisahkan sampah di sumbernya',
        'Mencampur sampah makanan dengan plastik',
        'Membakar bahan yang dapat didaur ulang'
      ],
      'correctIndex': 1,
    },
  ];

  void handleOptionTap(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        if (selectedOptionIndex ==
            questions[currentQuestionIndex]['correctIndex']) {
          score += 10;
        }
        currentQuestionIndex++;
        selectedOptionIndex = null;
      });
    } else {
      if (selectedOptionIndex ==
          questions[currentQuestionIndex]['correctIndex']) {
        score += 10;
      }
      _showFinishConfirmationDialog();
    }
  }

  void _showFinishConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selesaikan Quiz'),
        content: const Text('Apakah Anda yakin sudah menjawab dengan baik?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizResultPage(score: score),
                ),
              );
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Row(
              children: [
                Text(
                  'Question ${currentQuestionIndex + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' /${questions.length}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey.shade300,
              color: Colors.green,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 24),

            // Question Text
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),

            // Options
            ...List.generate(question['options'].length, (index) {
              final option = question['options'][index];
              final isSelected = selectedOptionIndex == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => handleOptionTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected
                          ? Colors.green.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.green.shade800
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Quit Quiz'),
                ),
                ElevatedButton(
                  onPressed: selectedOptionIndex != null ? nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? 'Selesaikan Quiz'
                        : 'Next',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
