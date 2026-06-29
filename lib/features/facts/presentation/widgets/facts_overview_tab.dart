import 'package:flutter/material.dart';

import '../../../../core/widgets/app_components.dart';
import '../../data/facts_mock_data.dart';
import 'facts_fun_fact_carousel.dart';
import 'facts_page_hero.dart';
import 'facts_tatort_stats_card.dart';

class FactsOverviewTab extends StatelessWidget {
  const FactsOverviewTab({required this.onExploreCities, super.key});

  final VoidCallback onExploreCities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FactsPageHero(),
        const SizedBox(height: 20),
        const FactsFunFactCarousel(items: factsFunFactCarousel),
        const SizedBox(height: 20),
        const FactsTatortStatsCard(statistics: factsTatortStatistics2024),
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'MEHR FAKTEN ENTDECKEN',
          icon: Icons.map_outlined,
          onPressed: onExploreCities,
        ),
      ],
    );
  }
}
