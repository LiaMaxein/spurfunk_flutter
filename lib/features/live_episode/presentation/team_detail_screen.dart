import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/persistence/shared_preferences_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/investigator_portrait.dart';
import '../../../shared/models/models.dart';
import '../../facts/data/facts_mock_data.dart';
import '../../facts/data/facts_models.dart';
import '../data/live_case_mock_data.dart';

class TeamDetailScreen extends ConsumerStatefulWidget {
  const TeamDetailScreen({required this.teamId, super.key});

  final String teamId;

  @override
  ConsumerState<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends ConsumerState<TeamDetailScreen> {
  late bool _isFavorite;

  InvestigatorTeamSummary? get _team => teamById(widget.teamId);

  String get _prefKey => 'favorite_team_${widget.teamId}';

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(sharedPreferencesProvider);
    _isFavorite = prefs.getBool(_prefKey) ?? false;
  }

  Future<void> _toggleFavorite() async {
    final next = !_isFavorite;
    setState(() => _isFavorite = next);
    await ref.read(sharedPreferencesProvider).setBool(_prefKey, next);
  }

  @override
  Widget build(BuildContext context) {
    final team = _team;
    if (team == null) {
      return AppScaffold(
        header: _buildHeader(context),
        child: const EmptyState(
          title: 'Team nicht gefunden',
          subtitle: 'Dieses Ermittlerteam ist in den Mock-Daten nicht hinterlegt.',
          icon: Icons.groups_outlined,
        ),
      );
    }

    final leadInvestigator = investigatorById(team.leadInvestigatorId);
    final episodeCount = team.members
        .where((member) => member.investigatorId != null)
        .map((member) => investigatorById(member.investigatorId!).episodeCount)
        .fold<int>(
          leadInvestigator.episodeCount,
          (max, count) => count > max ? count : max,
        );

    return AppScaffold(
      header: _buildHeader(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InvestigatorPortrait(
                assetPath: team.thumbnailAssetPath,
                size: 88,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.teamLabel.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${team.city} · seit ${team.sinceYear}',
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
          const SizedBox(height: 20),
          Text(
            'HAUPTFIGUREN',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < team.members.length; i++) ...[
            _TeamMemberRow(
              member: team.members[i],
              onTap: team.members[i].investigatorId == null
                  ? null
                  : () => context.push(
                      '/live/team/${team.members[i].investigatorId}',
                    ),
            ),
            if (i < team.members.length - 1) const SizedBox(height: 10),
          ],
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ÜBER ${team.teamLabel.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  team.teamBio ??
                      'Das Team aus ${team.city} ist Teil der Tatort-Reihe.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  label: 'ERMITTLER:INNEN',
                  trailing: '${team.members.length}',
                ),
                const Divider(color: AppColors.divider),
                _InfoRow(
                  label: 'FOLGEN',
                  trailing: '$episodeCount',
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
                for (var i = 0; i < leadInvestigator.popularEpisodes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          i == leadInvestigator.popularEpisodes.length - 1
                              ? 0
                              : 12,
                    ),
                    child: _PopularEpisodeRow(
                      rank: i + 1,
                      episode: leadInvestigator.popularEpisodes[i],
                    ),
                  ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Mehr über das Team',
                  onPressed: () => context.go(AppRoutes.facts.path),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Expanded(
          child: Text(
            'TEAM-DETAIL',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  const _TeamMemberRow({
    required this.member,
    this.onTap,
  });

  final TeamMemberSummary member;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          InvestigatorPortrait(
            assetPath: member.portraitAssetPath,
            size: 64,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.role,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
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
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
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
            child: episode.thumbnailAssetPath != null
                ? Image.asset(episode.thumbnailAssetPath!, fit: BoxFit.cover)
                : const ColoredBox(color: AppColors.surfaceHigh),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
