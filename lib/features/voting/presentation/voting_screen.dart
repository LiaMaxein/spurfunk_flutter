import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../application/voting_state.dart';

class VotingScreen extends ConsumerWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voting = ref.watch(votingProvider);
    final shares = voting.shareValues.reversed.toList();
    final colors = voting.shareColors.reversed.toList();
    final ratings = VoteRating.values.reversed.toList();

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Ergebnisse'),
          const SizedBox(height: 14),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                RedPill(label: 'Gesamt'),
                SizedBox(width: 10),
                RedPill(label: 'Nach Region', selected: false),
                SizedBox(width: 10),
                RedPill(label: 'Nach Alter', selected: false),
                SizedBox(width: 10),
                RedPill(label: 'Geschlecht', selected: false),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (!voting.userHasVoted) ...[
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deine Stimme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final rating in VoteRating.values)
                        EmojiVoteButton(
                          emoji: rating.emoji,
                          label: rating.label,
                          color: rating.color,
                          selected: voting.selected == rating,
                          onTap: () => ref
                              .read(votingProvider.notifier)
                              .selectVote(rating),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
          GlassCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Gesamtergebnis',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      child: Text(
                        key: ValueKey(voting.totalVotes),
                        '${_formatVotes(voting.totalVotes)} Stimmen',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    DonutChart(values: shares, colors: colors),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Column(
                        children: [
                          for (final rating in ratings)
                            _LegendRow(
                              label: rating.label,
                              value: voting.percentLabel(rating),
                              color: rating.color,
                              highlighted: voting.selected == rating,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (final rating in ratings)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ResultBar(
                      label: rating.label,
                      value: (voting.counts[rating] ?? 0) / voting.totalVotes,
                      color: rating.color,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verlauf der Abstimmung',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 14),
                const Sparkline(color: AppColors.greenSoft),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['20:15', '20:30', '20:45', '21:00', '21:15']
                      .map(
                        (time) => Text(
                          time,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatVotes(int count) {
    final text = count.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final fromEnd = text.length - i;
      buffer.write(text[i]);
      if (fromEnd > 1 && fromEnd % 3 == 1) buffer.write('.');
    }
    return buffer.toString();
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.label,
    required this.value,
    required this.color,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final Color color;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
              boxShadow: highlighted
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.55),
                        blurRadius: 8,
                      ),
                    ]
                  : kEmptyBoxShadow,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: highlighted ? AppColors.textPrimary : null,
                fontWeight: highlighted ? FontWeight.w600 : null,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            child: Text(
              key: ValueKey(value),
              value,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
