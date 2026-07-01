import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/voting_widgets.dart';
import '../../../../shared/models/models.dart';

class EpisodeStatsCard extends StatelessWidget {
  const EpisodeStatsCard({
    required this.item,
    required this.onTap,
    super.key,
    this.featured = false,
    this.showLiveBadge = false,
    this.showThumbnail = true,
    this.thumbnailWidth = 88,
    this.thumbnailHeight = 88,
  });

  final PastEpisodeStats item;
  final VoidCallback onTap;
  final bool featured;
  final bool showLiveBadge;
  final bool showThumbnail;
  final double thumbnailWidth;
  final double thumbnailHeight;

  @override
  Widget build(BuildContext context) {
    final episode = item.episode;
    final date = DateFormat('dd.MM.yyyy').format(episode.startsAt);
    final time = DateFormat.Hm().format(episode.startsAt);
    final meta = featured
        ? '$date • $time Uhr • ${episode.sender}'
        : date;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showThumbnail && episode.imageAssetPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    episode.imageAssetPath!,
                    width: thumbnailWidth,
                    height: thumbnailHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              if (showThumbnail && episode.imageAssetPath != null)
                const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            episode.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        if (showLiveBadge) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'LIVE',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meta,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            featured
                                ? AppColors.textMuted
                                : AppColors.textSecondary,
                      ),
                    ),
                    if (!featured)
                      Text(
                        'Ø ${item.averageLabel}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              if (!featured)
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
          if (featured) ...[
            const SizedBox(height: 14),
            VoteSegmentBar(aggregate: item.aggregate),
            const SizedBox(height: 8),
            for (final value in VoteValue.values.reversed)
              StatBar(
                label: value.label,
                emoji: value.emoji,
                fraction: item.aggregate.fractionFor(value),
                color: value.color,
                count: item.aggregate.countFor(value),
              ),
            const SizedBox(height: 4),
            Text(
              'Gesamt: ${_formatTotal(item.aggregate.total)} Stimmen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            VoteSegmentBar(aggregate: item.aggregate),
            const SizedBox(height: 6),
            Text(
              '${item.aggregate.total} Stimmen · Details ansehen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTotal(int total) {
    return NumberFormat.decimalPattern('de_DE').format(total);
  }
}

/// Maps live episode ids to the matching community stats entry.
String communityStatsEpisodeIdFor(String episodeId) {
  switch (episodeId) {
    case 'ep-live-demo':
    case 'ep-live':
      return 'ep-past-3';
    default:
      return episodeId;
  }
}

void openEpisodeStatsDetail(BuildContext context, String episodeId) {
  context.push('/community/stats/$episodeId');
}
