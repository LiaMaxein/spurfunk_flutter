import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../shared/models/gamification_models.dart';
import '../../data/quiz_mock_data.dart';
import 'gamification_replay_dialogs.dart';

class CommunityQuizTab extends StatefulWidget {
  const CommunityQuizTab({super.key});

  @override
  State<CommunityQuizTab> createState() => _CommunityQuizTabState();
}

class _CommunityQuizTabState extends State<CommunityQuizTab> {
  QuizCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TATORT-QUIZ',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(
          '$quizStandardQuestionCount Fragen · Krimi-Wissen testen · XP sammeln',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategorie wählen',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Optional – ohne Auswahl kommen gemischte Fragen.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Quiz starten',
                icon: Icons.play_arrow_rounded,
                onPressed: () {
                  context.push(quizPlayPath(category: _selectedCategory));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.emoji_events_outlined, color: AppColors.red),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'So funktioniert\'s',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Beantworte $quizStandardQuestionCount Fragen. '
                      'Richtige Antworten bringen XP – ein perfektes Quiz gibt Bonuspunkte.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
