import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/investigator_portrait.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../shared/models/models.dart';
import '../../data/live_case_mock_data.dart';

class LiveCurrentCaseTab extends StatelessWidget {
  const LiveCurrentCaseTab({required this.episode, super.key});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final investigators = investigatorsForEpisode(episode);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: 232,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (episode.imageAssetPath != null)
                    Image.asset(episode.imageAssetPath!, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.6),
                          Colors.black.withValues(alpha: 0.92),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            episode.sender,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          episode.title.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontSize: 30),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          liveCaseSpoilerWarningTitle,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            liveCaseSynopsis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 18),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ERMITTLER:INNEN',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final investigator in investigators)
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: GestureDetector(
                            onTap: () => context.go('/live/team/${investigator.id}'),
                            child: SizedBox(
                              width: 94,
                              child: Column(
                                children: [
                                  InvestigatorPortrait(
                                    assetPath: investigator.portraitAssetPath,
                                    size: 72,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    investigator.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    investigator.role,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FOLGE AUF EINEN BLICK',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.7,
                  children: [
                    _MetaItem(
                      icon: Icons.location_on_outlined,
                      label: 'Ort',
                      value: episode.location,
                    ),
                    _MetaItem(
                      icon: Icons.calendar_month_outlined,
                      label: 'Datum',
                      value: DateFormat('dd.MM.yyyy').format(episode.startsAt),
                    ),
                    _MetaItem(
                      icon: Icons.schedule_outlined,
                      label: 'Zeit',
                      value: '${DateFormat.Hm().format(episode.startsAt)} Uhr',
                    ),
                    _MetaItem(
                      icon: Icons.live_tv_outlined,
                      label: 'Sender',
                      value: episode.sender,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.red, size: 18),
          const Spacer(),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
