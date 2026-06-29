import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/gamification_models.dart';
import '../../data/memory_mock_data.dart';
import '../../data/quiz_mock_data.dart';

/// `null` = Alle Kategorien, [QuizCategory] = gewählte Kategorie.
/// Dialog abgebrochen → Rückgabe bleibt `null` und [cancelled] ist `true`.
class QuizReplaySelection {
  const QuizReplaySelection({this.category, this.cancelled = false});

  final QuizCategory? category;
  final bool cancelled;

  bool get isAll => !cancelled && category == null;
}

class MemoryReplaySelection {
  const MemoryReplaySelection({this.difficulty, this.cancelled = false});

  final MemoryDifficulty? difficulty;
  final bool cancelled;
}

String quizPlayPath({QuizCategory? category, int? session}) {
  final sessionId = session ?? DateTime.now().millisecondsSinceEpoch;
  final params = <String, String>{'session': '$sessionId'};
  if (category != null) params['category'] = category.name;
  final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
  return '/community/quiz/play?$query';
}

String memoryPlayPath(MemoryDifficulty difficulty, {int? session}) {
  final sessionId = session ?? DateTime.now().millisecondsSinceEpoch;
  return '/community/memory/play?id=${difficulty.id}&session=$sessionId';
}

Future<QuizReplaySelection> showQuizReplayDialog(
  BuildContext context, {
  QuizCategory? initialCategory,
}) async {
  final result = await showDialog<QuizReplaySelection>(
    context: context,
    builder: (context) => _QuizReplayDialog(initialCategory: initialCategory),
  );
  return result ?? const QuizReplaySelection(cancelled: true);
}

Future<MemoryReplaySelection> showMemoryReplayDialog(
  BuildContext context, {
  MemoryDifficulty? initialDifficulty,
}) async {
  final result = await showDialog<MemoryReplaySelection>(
    context: context,
    builder: (context) => _MemoryReplayDialog(
      initialDifficulty: initialDifficulty ?? memoryDifficulties.first,
    ),
  );
  return result ?? const MemoryReplaySelection(cancelled: true);
}

class _QuizReplayDialog extends StatefulWidget {
  const _QuizReplayDialog({this.initialCategory});

  final QuizCategory? initialCategory;

  @override
  State<_QuizReplayDialog> createState() => _QuizReplayDialogState();
}

class _QuizReplayDialogState extends State<_QuizReplayDialog> {
  late QuizCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('Nochmal spielen'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wähle eine Kategorie für die nächste Runde.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CategoryChip(
                  label: 'Alle',
                  selected: _selectedCategory == null,
                  onTap: () => setState(() => _selectedCategory = null),
                ),
                for (final category in quizSelectableCategories)
                  _CategoryChip(
                    label: category.label,
                    selected: _selectedCategory == category,
                    onTap: () => setState(() => _selectedCategory = category),
                  ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            const QuizReplaySelection(cancelled: true),
          ),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            QuizReplaySelection(category: _selectedCategory),
          ),
          child: const Text('Quiz starten'),
        ),
      ],
    );
  }
}

class _MemoryReplayDialog extends StatefulWidget {
  const _MemoryReplayDialog({required this.initialDifficulty});

  final MemoryDifficulty initialDifficulty;

  @override
  State<_MemoryReplayDialog> createState() => _MemoryReplayDialogState();
}

class _MemoryReplayDialogState extends State<_MemoryReplayDialog> {
  late MemoryDifficulty _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDifficulty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('Nochmal spielen'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Wähle den Schwierigkeitsgrad für die nächste Runde.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            for (final difficulty in memoryDifficulties) ...[
              _DifficultyOption(
                difficulty: difficulty,
                selected: _selected.id == difficulty.id,
                onTap: () => setState(() => _selected = difficulty),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            const MemoryReplaySelection(cancelled: true),
          ),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            MemoryReplaySelection(difficulty: _selected),
          ),
          child: const Text('Memory starten'),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.red.withValues(alpha: 0.2),
      checkmarkColor: AppColors.red,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 11,
        color: selected ? AppColors.textPrimary : AppColors.textMuted,
      ),
      side: BorderSide(
        color: selected ? AppColors.red : AppColors.divider,
      ),
    );
  }
}

class _DifficultyOption extends StatelessWidget {
  const _DifficultyOption({
    required this.difficulty,
    required this.selected,
    required this.onTap,
  });

  final MemoryDifficulty difficulty;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.red.withValues(alpha: 0.12)
                : AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.red : AppColors.divider,
            ),
          ),
          child: Row(
            children: [
              Text(
                difficulty.gridLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      difficulty.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${difficulty.pairCount} Paare',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: AppColors.red, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
