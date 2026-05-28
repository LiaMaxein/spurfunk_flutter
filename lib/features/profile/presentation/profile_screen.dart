import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Profile',
      subtitle:
          'Personal watch identity, saved choices, badges, and preferences.',
      icon: Icons.person_rounded,
      primaryAction:
          'Profile summary and personal engagement modules will live here.',
    );
  }
}
