import 'package:flutter/material.dart';

import '../../../core/layout/responsive_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/premium_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/status_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Tatort Liebe',
            subtitle:
                'Your premium companion for live episodes, voting, community signals, and story statistics.',
          ),
          const SizedBox(height: 24),
          PremiumCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StatusChip(
                  label: 'Tonight · 20:15',
                  icon: Icons.live_tv_rounded,
                ),
                const SizedBox(height: 28),
                Text(
                  'Love, suspicion, and one impossible choice.',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'A cinematic dashboard placeholder for the featured episode area. Backend data will be connected later.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Enter live experience'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _HomeMetric(label: 'Couples tracked', value: '12'),
              _HomeMetric(label: 'Votes prepared', value: '4'),
              _HomeMetric(label: 'Community pulse', value: 'Hot'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeMetric extends StatelessWidget {
  const _HomeMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: PremiumCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColors.redSoft),
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
