class QuizController {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int score = 0;

  final List<Map<String, dynamic>> questions;

  QuizController({required this.questions});

  void selectOption(int index) {
    selectedOptionIndex = index;
  }

  /// Return true jika quiz selesai
  bool nextQuestion() {
    if (selectedOptionIndex ==
        questions[currentQuestionIndex]['correctIndex']) {
      score += 10;
    }
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      selectedOptionIndex = null;
      return false;
    } else {
      return true;
    }
  }
}
