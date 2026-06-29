import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../shared/models/gamification_models.dart';
import '../data/quiz_mock_data.dart';
import 'widgets/gamification_replay_dialogs.dart';

const _communityQuizPath = '/community?tab=quiz';

class QuizPlayScreen extends StatefulWidget {
  const QuizPlayScreen({this.category, super.key});

  final QuizCategory? category;

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  late final List<QuizQuestion> _questions;
  late final DateTime _startedAt;
  late final Timer _timer;

  int _index = 0;
  int? _selectedIndex;
  int _correctCount = 0;
  bool _showFeedback = false;
  QuizSessionResult? _result;

  @override
  void initState() {
    super.initState();
    _questions = buildQuizSession(category: widget.category);
    _startedAt = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _result == null) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _selectAnswer(int optionIndex) {
    if (_showFeedback || _result != null) return;
    final question = _questions[_index];
    final isCorrect = optionIndex == question.correctIndex;

    setState(() {
      _selectedIndex = optionIndex;
      _showFeedback = true;
      if (isCorrect) _correctCount++;
    });
  }

  void _nextQuestion() {
    if (_index >= _questions.length - 1) {
      _finishQuiz();
      return;
    }
    setState(() {
      _index++;
      _selectedIndex = null;
      _showFeedback = false;
    });
  }

  void _finishQuiz() {
    final duration = DateTime.now().difference(_startedAt);
    setState(() {
      _result = QuizSessionResult(
        totalQuestions: _questions.length,
        correctCount: _correctCount,
        xpEarned: calculateQuizXp(_correctCount, _questions.length),
        duration: duration,
        category: widget.category,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: _result != null ? _buildResult(context) : _buildQuestion(context),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    final question = _questions[_index];
    final progress = (_index + 1) / _questions.length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => _confirmExit(context),
                icon: const Icon(Icons.close_rounded),
              ),
              Expanded(
                child: Text(
                  'QUIZ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Text(
                '${_index + 1}/${_questions.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.divider,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            question.category.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (var i = 0; i < question.options.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _AnswerButton(
                        label: question.options[i],
                        state: _optionState(i, question.correctIndex),
                        onTap: () => _selectAnswer(i),
                      ),
                    ),
                  if (_showFeedback && question.explanation != null) ...[
                    const SizedBox(height: 8),
                    AppCard(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        question.explanation!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                  if (_showFeedback) ...[
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: _index >= _questions.length - 1
                          ? 'Auswertung'
                          : 'Weiter',
                      onPressed: _nextQuestion,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _AnswerState _optionState(int index, int correctIndex) {
    if (!_showFeedback) return _AnswerState.idle;
    if (index == correctIndex) return _AnswerState.correct;
    if (index == _selectedIndex) return _AnswerState.wrong;
    return _AnswerState.idle;
  }

  Widget _buildResult(BuildContext context) {
    final result = _result!;
    final percent = (result.accuracy * 100).round();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.go(_communityQuizPath),
                icon: const Icon(Icons.close_rounded),
              ),
              Expanded(
                child: Text(
                  'ERGEBNIS',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const Spacer(),
          Text(
            '$percent%',
            style: GoogleFonts.bebasNeue(
              fontSize: 72,
              color: AppColors.red,
              height: 1,
            ),
          ),
          Text(
            '${result.correctCount} von ${result.totalQuestions} richtig',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                _ResultRow(
                  icon: Icons.star_outline,
                  label: 'XP verdient',
                  value: '+${result.xpEarned}',
                ),
                const Divider(height: 20, color: AppColors.divider),
                _ResultRow(
                  icon: Icons.timer_outlined,
                  label: 'Dauer',
                  value: _formatDuration(result.duration),
                ),
                if (result.category != null) ...[
                  const Divider(height: 20, color: AppColors.divider),
                  _ResultRow(
                    icon: Icons.category_outlined,
                    label: 'Kategorie',
                    value: result.category!.label,
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Nochmal spielen',
            onPressed: () async {
              final choice = await showQuizReplayDialog(
                context,
                initialCategory: widget.category,
              );
              if (!context.mounted || choice.cancelled) return;
              context.replace(quizPlayPath(category: choice.category));
            },
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'Zurück zur Community',
            onPressed: () => context.go(_communityQuizPath),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz beenden?'),
        content: const Text('Dein Fortschritt in dieser Runde geht verloren.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Weiterspielen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) context.go(_communityQuizPath);
  }

  String _formatDuration(Duration duration) {
    final m = duration.inMinutes;
    final s = duration.inSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')} Min.';
  }
}

enum _AnswerState { idle, correct, wrong }

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.state,
    required this.onTap,
  });

  final String label;
  final _AnswerState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color border = AppColors.divider;
    Color background = AppColors.surface;
    if (state == _AnswerState.correct) {
      border = AppColors.green;
      background = AppColors.green.withValues(alpha: 0.12);
    } else if (state == _AnswerState.wrong) {
      border = AppColors.red;
      background = AppColors.red.withValues(alpha: 0.12);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.red, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
