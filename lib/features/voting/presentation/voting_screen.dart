import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Voting',
      subtitle:
          'Interactive choices for couples, suspects, clues, and episode outcomes.',
      icon: Icons.how_to_vote_rounded,
      primaryAction: 'Voting cards and result states will be added here.',
    );
  }
}
