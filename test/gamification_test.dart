import 'package:flutter_test/flutter_test.dart';
import 'package:spurfunk_flutter/features/community/data/memory_mock_data.dart';
import 'package:spurfunk_flutter/features/community/data/quiz_mock_data.dart';
import 'package:spurfunk_flutter/shared/models/gamification_models.dart';

void main() {
  test('buildQuizSession returns up to 15 questions', () {
    final session = buildQuizSession();
    expect(session.length, quizStandardQuestionCount);
    expect(session.first.question, isNotEmpty);
  });

  test('buildQuizSession filters by category', () {
    final session = buildQuizSession(category: QuizCategory.teams);
    expect(session, isNotEmpty);
    expect(session.every((q) => q.category == QuizCategory.teams), isTrue);
  });

  test('calculateQuizXp rewards perfect score', () {
    final perfect = calculateQuizXp(15, 15);
    final partial = calculateQuizXp(8, 15);
    expect(perfect, greaterThan(partial));
  });

  test('memory difficulties are phone-friendly grids', () {
    expect(memoryDifficulties.length, 3);
    expect(memoryDifficulties[0].gridLabel, '4×4');
    expect(memoryDifficulties[1].gridLabel, '5×5');
    expect(memoryDifficulties[2].gridLabel, '7×7');
  });

  test('selectable quiz categories have 15 questions each', () {
    for (final category in quizSelectableCategories) {
      final count = mockQuizQuestions
          .where((question) => question.category == category)
          .length;
      expect(count, greaterThanOrEqualTo(quizStandardQuestionCount));
    }
  });

  test('buildQuizSession returns 15 for category', () {
    final session = buildQuizSession(category: QuizCategory.teams);
    expect(session.length, quizStandardQuestionCount);
    expect(session.every((q) => q.category == QuizCategory.teams), isTrue);
  });

  test('motifsForDifficulty returns enough unique motifs', () {
    final easy = memoryDifficulties.first;
    final motifs = motifsForDifficulty(easy);
    expect(motifs.length, easy.pairCount);
    expect(motifs.toSet().length, easy.pairCount);
  });

  test('calculateMemoryScore prefers fewer moves', () {
    final difficulty = memoryDifficulties.first;
    final better = calculateMemoryScore(
      difficulty: difficulty,
      moves: 12,
      duration: const Duration(seconds: 90),
    );
    final worse = calculateMemoryScore(
      difficulty: difficulty,
      moves: 40,
      duration: const Duration(seconds: 90),
    );
    expect(better, greaterThan(worse));
  });
}
