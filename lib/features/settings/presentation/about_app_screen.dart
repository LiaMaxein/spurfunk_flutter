import 'package:flutter/material.dart';

import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/cinematic_widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Über Spurfunk'),
          const SizedBox(height: 18),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spurfunk', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  'Inoffizielles Fan-Projekt. Diese Anwendung steht in keinerlei '
                  'rechtlicher oder geschäftlicher Verbindung zur ARD oder '
                  'angeschlossenen Rundfunkanstalten.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'Second-Screen-Begleiter für Live-Abstimmungen, Community-Chat '
                  'und Krimi-Noir-Atmosphäre.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
