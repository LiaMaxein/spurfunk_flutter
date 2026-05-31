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
          const SizedBox(height: 18),
          Text('Demografische Aufschlüsselung', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            radius: 14,
            child: _DemographicRow(
              label: 'Alter 18–29',
              percent: 38,
              color: AppColors.redSoft,
            ),
          ),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            radius: 14,
            child: _DemographicRow(
              label: 'Alter 30–44',
              percent: 42,
              color: AppColors.orange,
            ),
          ),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            radius: 14,
            child: _DemographicRow(
              label: 'Alter 45+',
              percent: 20,
              color: AppColors.greenSoft,
            ),
          ),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            radius: 14,
            child: _DemographicRow(
              label: 'Aus dem Norden (Kiel/Umland)',
              percent: 34,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 18),
          Text('Top-Community-Theorien', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _TheoryCard(
            author: 'Nordlicht_09',
            text: 'Das Opfer kannte den Täter aus der Galerie.',
            votes: 342,
          ),
          const SizedBox(height: 8),
          _TheoryCard(
            author: 'CaseClosed?',
            text: 'Kessler wusste zu viel über den Ablauf – er war es.',
            votes: 289,
          ),
          const SizedBox(height: 8),
          _TheoryCard(
            author: 'Spurensucher',
            text: 'Die Uhrzeit im Protokoll passt nicht zur Szene – ein Vertuschungsversuch.',
            votes: 156,
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

class _DemographicRow extends StatelessWidget {
  const _DemographicRow({
    required this.label,
    required this.percent,
    required this.color,
  });

  final String label;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
        const Spacer(),
        Text(
          '$percent%',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _TheoryCard extends StatelessWidget {
  const _TheoryCard({
    required this.author,
    required this.text,
    required this.votes,
  });

  final String author;
  final String text;
  final int votes;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 14,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarBubble(color: _colorForAuthor(author), icon: Icons.psychology_alt_outlined, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(text, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text('$votes', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForAuthor(String name) {
    final colors = [AppColors.redSoft, AppColors.orange, AppColors.greenSoft, AppColors.red, AppColors.yellow];
    return colors[name.hashCode.abs() % colors.length];
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
