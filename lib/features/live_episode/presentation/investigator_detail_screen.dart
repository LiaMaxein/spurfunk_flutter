import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/persistence/shared_preferences_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/investigator_portrait.dart';
import '../../../core/widgets/app_components.dart';
import '../../../shared/models/models.dart';
import '../../facts/data/facts_mock_data.dart';
import '../data/live_case_mock_data.dart';

class InvestigatorDetailScreen extends ConsumerStatefulWidget {
  const InvestigatorDetailScreen({required this.investigatorId, super.key});

  final String investigatorId;

  @override
  ConsumerState<InvestigatorDetailScreen> createState() =>
      _InvestigatorDetailScreenState();
}

class _InvestigatorDetailScreenState
    extends ConsumerState<InvestigatorDetailScreen> {
  late bool _isFavorite;

  String get _prefKey => 'favorite_investigator_${widget.investigatorId}';

  @override
  void initState() {
    super.initState();
    final investigator = investigatorById(widget.investigatorId);
    final prefs = ref.read(sharedPreferencesProvider);
    _isFavorite = prefs.getBool(_prefKey) ?? investigator.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    final next = !_isFavorite;
    setState(() => _isFavorite = next);
    await ref.read(sharedPreferencesProvider).setBool(_prefKey, next);
  }

  @override
  Widget build(BuildContext context) {
    final investigator = investigatorById(widget.investigatorId);
    final team = teamByInvestigatorId(widget.investigatorId);

    return AppScaffold(
      header: Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Text(
              'TEAM-DETAIL',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvestigatorPortrait(
                  assetPath: investigator.portraitAssetPath,
                  size: 88,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        investigator.name.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        investigator.role,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: 'Als Favorit markieren',
                  child: IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                    ),
                    color: AppColors.red,
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
                  'ÜBER ${investigator.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  investigator.bio,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  label: 'ERMITTLER:INNEN',
                  trailing: '${investigator.teamMemberCount}',
                ),
                const Divider(color: AppColors.divider),
                _InfoRow(
                  label: 'FOLGEN',
                  trailing: '${investigator.episodeCount}',
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
                  'BELIEBTESTE FOLGEN',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < investigator.popularEpisodes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i == investigator.popularEpisodes.length - 1 ? 0 : 12,
                    ),
                    child: _PopularEpisodeRow(
                      rank: i + 1,
                      episode: investigator.popularEpisodes[i],
                    ),
                  ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Mehr über das Team',
                  onPressed: team == null
                      ? () => context.go(AppRoutes.facts.path)
                      : () => context.pushReplacement(
                          '/live/team-detail/${team.id}',
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    this.trailing,
  });

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
        if (trailing != null)
          Text(trailing!, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _PopularEpisodeRow extends StatelessWidget {
  const _PopularEpisodeRow({required this.rank, required this.episode});

  final int rank;
  final PopularEpisode episode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Text(
            '$rank',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: rank == 1 ? AppColors.yellow : AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 56,
            height: 56,
            child:
                episode.thumbnailAssetPath != null
                    ? Image.asset(episode.thumbnailAssetPath!, fit: BoxFit.cover)
                    : const ColoredBox(color: AppColors.surfaceHigh),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(episode.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(
                DateFormat('dd.MM.yyyy').format(episode.airedAt),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Text(
          episode.rating.toStringAsFixed(1).replaceAll('.', ','),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 6),
        const Icon(Icons.star_rounded, color: AppColors.red, size: 18),
      ],
    );
  }
}
