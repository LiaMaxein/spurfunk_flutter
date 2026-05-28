import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Community',
      subtitle:
          'A premium fan space for theories, reactions, and shared episode moments.',
      icon: Icons.forum_rounded,
      primaryAction:
          'Community feeds and discussion modules will be composed here.',
    );
  }
}
