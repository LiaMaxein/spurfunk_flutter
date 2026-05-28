import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Settings',
      subtitle:
          'App preferences, notifications, accessibility, and privacy controls.',
      icon: Icons.settings_rounded,
      primaryAction: 'Settings groups and toggles will be introduced here.',
    );
  }
}
