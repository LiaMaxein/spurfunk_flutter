import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/community_stats_notifier.dart';

class CommunityLiveVotingHeader extends ConsumerStatefulWidget {
  const CommunityLiveVotingHeader({
    required this.filtersExpanded,
    required this.onFilterToggle,
    super.key,
  });

  final bool filtersExpanded;
  final VoidCallback onFilterToggle;

  @override
  ConsumerState<CommunityLiveVotingHeader> createState() =>
      _CommunityLiveVotingHeaderState();
}

class _CommunityLiveVotingHeaderState
    extends ConsumerState<CommunityLiveVotingHeader> {
  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(communityStatsProvider);
    final notifier = ref.read(communityStatsProvider.notifier);
    final hasFilters =
        stats.filter.region != null ||
        stats.filter.ageCohort != null ||
        stats.filter.gender != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'LIVE-VOTING ERGEBNISSE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: widget.onFilterToggle,
              icon: Icon(
                widget.filtersExpanded
                    ? Icons.expand_less_rounded
                    : Icons.tune_rounded,
                size: 16,
              ),
              label: Text(hasFilters ? 'Filter · aktiv' : 'Filter'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(
                  color:
                      hasFilters || widget.filtersExpanded
                          ? AppColors.red
                          : AppColors.divider,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                textStyle: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (widget.filtersExpanded) ...[
          const SizedBox(height: 10),
          _CompactFilterSection(
            title: 'Region',
            options: CommunityStatsState.regions,
            selected: stats.filter.region,
            onSelected: notifier.setRegion,
          ),
          const SizedBox(height: 8),
          _CompactFilterSection(
            title: 'Alterskohorte',
            options: CommunityStatsState.ageCohorts,
            selected: stats.filter.ageCohort,
            onSelected: notifier.setAgeCohort,
          ),
          const SizedBox(height: 8),
          _CompactFilterSection(
            title: 'Geschlecht',
            options: CommunityStatsState.genders,
            selected: stats.filter.gender,
            onSelected: notifier.setGender,
          ),
          if (hasFilters) ...[
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: notifier.clearFilters,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textMuted,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Filter zurücksetzen'),
              ),
            ),
          ],
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _CompactFilterSection extends StatelessWidget {
  const _CompactFilterSection({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final option in options)
              FilterChip(
                label: Text(option),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                labelStyle: const TextStyle(fontSize: 12),
                selected: selected == option,
                onSelected: (v) => onSelected(v ? option : null),
                selectedColor: AppColors.red.withValues(alpha: 0.24),
                checkmarkColor: AppColors.red,
                side: BorderSide(
                  color:
                      selected == option ? AppColors.red : AppColors.divider,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class CommunitySectionHeading extends StatelessWidget {
  const CommunitySectionHeading({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 22,
        color: AppColors.textPrimary,
      ),
    );
  }
}
