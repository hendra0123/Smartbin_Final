import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/pages/quizController.dart';

void main() {
  late QuizController quizController;

  // 🔧 Dummy list of questions to be used in all tests
  final sampleQuestions = [
    {
      'question': 'Apa warna langit?',
      'options': ['Merah', 'Biru', 'Hijau', 'Kuning'],
      'correctIndex': 1,
    },
    {
      'question': 'Berapa 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'correctIndex': 1,
    },
  ];

  // 🔄 Run before each test to reset controller
  setUp(() {
    quizController = QuizController(questions: sampleQuestions);
  });

  test('📌 Initial state should be correct', () {
    // 📌 PURPOSE:
    // This test verifies the initial state of the QuizController when first created.

    // ✅ EXPECTED OUTCOME:
    // - currentQuestionIndex = 0
    // - selectedOptionIndex = null
    // - score = 0

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - quizController is instantiated with 2 questions

    expect(quizController.currentQuestionIndex, 0);
    expect(quizController.selectedOptionIndex, isNull);
    expect(quizController.score, 0);
  });

  test(
      '✅ Selecting the correct option should increase score after nextQuestion',
      () {
    // 📌 PURPOSE:
    // This test checks if selecting the correct option updates the score properly after moving to the next question.

    // ✅ EXPECTED OUTCOME:
    // - Score increases by 10
    // - Moves to next question (index 1)
    // - selectedOptionIndex resets to null
    // - Quiz is not finished yet (returns false)

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - Question 1's correct answer is index 1
    // - Total questions: 2

    quizController.selectOption(1); // correct
    final isFinished = quizController.nextQuestion();

    expect(quizController.score, 10);
    expect(quizController.currentQuestionIndex, 1);
    expect(quizController.selectedOptionIndex, isNull);
    expect(isFinished, isFalse);
  });

  test('❌ Selecting incorrect option should NOT increase score', () {
    // 📌 PURPOSE:
    // Ensure that selecting a wrong answer does not increase the score.

    // ✅ EXPECTED OUTCOME:
    // - Score remains at 0
    // - Index advances to next question

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - Question 1's correct answer is index 1
    // - User selects index 0 (incorrect)

    quizController.selectOption(0); // incorrect
    quizController.nextQuestion();

    expect(quizController.score, 0);
    expect(quizController.currentQuestionIndex, 1);
  });

  test('✅ Final question triggers quiz completion', () {
    // 📌 PURPOSE:
    // Verify that after answering the last question, `nextQuestion()` returns true to indicate quiz is finished.

    // ✅ EXPECTED OUTCOME:
    // - Score should be 20 (2 correct answers)
    // - `nextQuestion()` should return true at the end

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - Both questions answered correctly

    // Question 1
    quizController.selectOption(1); // correct
    quizController.nextQuestion();

    // Question 2
    quizController.selectOption(1); // correct
    final isFinished = quizController.nextQuestion();

    expect(isFinished, isTrue);
    expect(quizController.score, 20);
  });

  test('🧪 Can handle mixed correct and incorrect answers', () {
    // 📌 PURPOSE:
    // Confirm quizController can track a mix of correct and incorrect answers across multiple questions.

    // ✅ EXPECTED OUTCOME:
    // - First question is wrong, second is correct
    // - Final score = 10

    // 🧱 ASSUMPTIONS / PREREQUISITES:
    // - First question: user selects index 0 (wrong)
    // - Second question: user selects index 1 (correct)

    // Question 1
    quizController.selectOption(0); // incorrect
    quizController.nextQuestion();

    // Question 2
    quizController.selectOption(1); // correct
    quizController.nextQuestion();

    expect(quizController.score, 10);
  });
}
