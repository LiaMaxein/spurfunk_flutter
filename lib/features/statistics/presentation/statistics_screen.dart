import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Statistics',
      subtitle:
          'Visual insights for votes, relationships, community pulse, and episode trends.',
      icon: Icons.analytics_rounded,
      primaryAction:
          'Charts and metric cards will be connected once data exists.',
    );
  }
}
