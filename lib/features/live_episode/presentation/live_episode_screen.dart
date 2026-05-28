import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class LiveEpisodeScreen extends StatelessWidget {
  const LiveEpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Live Episode',
      subtitle:
          'A synchronized second-screen experience for the current episode.',
      icon: Icons.live_tv_rounded,
      primaryAction: 'Live timeline and episode moments will live here.',
    );
  }
}
