import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../voting/application/voting_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voting = ref.watch(votingProvider);

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTopBar(
            title: 'Tatort-Liebe',
            showBack: false,
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ),
          const SizedBox(height: 18),
          const _HeroEpisodeCard(),
          const SizedBox(height: 18),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wie findest du den aktuellen Tatort?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  voting.userHasVoted
                      ? 'Danke – deine Stimme zählt in der Live-Auswertung.'
                      : 'Stimme jetzt ab – anonym und in Echtzeit!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  child: Text(
                    key: ValueKey(voting.totalVotes),
                    '${_formatVotes(voting.totalVotes)} Stimmen bereits abgegeben',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => context.go(AppRoutes.voting.path),
                  child: Text(
                    voting.userHasVoted
                        ? 'Ergebnisse ansehen'
                        : 'Jetzt abstimmen',
                  ),
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

class _HeroEpisodeCard extends StatelessWidget {
  const _HeroEpisodeCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.mockupIntro,
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.12),
                    AppColors.black.withValues(alpha: 0.38),
                    AppColors.black.withValues(alpha: 0.92),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const RedPill(
                    label: 'LIVE',
                    icon: Icons.circle,
                    selected: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Borowski und das Haupt der Medusa',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'ARD',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.public_rounded, size: 17),
                      const SizedBox(width: 14),
                      Text(
                        'Noch 32 Min.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
