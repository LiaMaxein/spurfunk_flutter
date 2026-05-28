import 'package:flutter/material.dart';

import '../../../core/widgets/cinematic_widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Über die App'),
          const SizedBox(height: 18),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tatort Liebe', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  'Ein interaktiver Second-Screen-Prototyp für Live-Krimis. '
                  'Der Fokus liegt auf Community, Reaktionen und Echtzeitgefühl.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
