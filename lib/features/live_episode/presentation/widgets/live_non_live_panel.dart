import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/episode_countdown.dart';
import '../../../../core/widgets/voting_widgets.dart';
import '../../../../shared/models/models.dart';

class LiveNonLivePanel extends StatelessWidget {
  const LiveNonLivePanel({
    required this.nextEpisode,
    required this.lastEpisodeStats,
    required this.now,
    super.key,
  });

  final Episode? nextEpisode;
  final PastEpisodeStats? lastEpisodeStats;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    if (nextEpisode == null) {
      return const EmptyState(
        title: 'Keine Sendung geplant',
        subtitle: 'Momentan liegen keine Infos zur naechsten Folge vor.',
        icon: Icons.live_tv_outlined,
      );
    }

    final remaining = nextEpisode!.startsAt.difference(now);
    final formattedDate = DateFormat(
      'EEEE, dd.MM.yyyy • HH:mm',
      'de_DE',
    ).format(nextEpisode!.startsAt);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'HEUTE IST KEIN TATORT LIVE',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'NÄCHSTER TATORT IN',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                EpisodeCountdown(remaining: remaining, showSeconds: true),
                const SizedBox(height: 16),
                Text(
                  formattedDate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (lastEpisodeStats != null)
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LETZTE ABSTIMMUNG',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 96,
                          height: 72,
                          child:
                              lastEpisodeStats!.episode.imageAssetPath != null
                                  ? Image.asset(
                                    lastEpisodeStats!.episode.imageAssetPath!,
                                    fit: BoxFit.cover,
                                  )
                                  : ColoredBox(
                                    color: AppColors.surfaceHigh,
                                    child: const Icon(
                                      Icons.movie_outlined,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tatort: ${lastEpisodeStats!.episode.title}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat(
                                'dd.MM.yyyy',
                              ).format(lastEpisodeStats!.episode.startsAt),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  VoteSegmentBar(aggregate: lastEpisodeStats!.aggregate),
                  const SizedBox(height: 8),
                  for (final value in VoteValue.values.reversed)
                    StatBar(
                      label: value.label,
                      emoji: value.emoji,
                      fraction: lastEpisodeStats!.aggregate.fractionFor(value),
                      color: value.color,
                      count: lastEpisodeStats!.aggregate.countFor(value),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          () => context.go('${AppRoutes.community.path}?tab=stats'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.red,
                        side: const BorderSide(color: AppColors.red),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('ALLE STATISTIKEN ANSEHEN'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
