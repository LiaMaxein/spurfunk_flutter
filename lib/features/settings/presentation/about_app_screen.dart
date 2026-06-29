import 'package:flutter/material.dart';

import '../../../core/widgets/app_components.dart';
import 'widgets/settings_widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'ÜBER SPURFUNK',
      child: AppCard(
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
    );
  }
}
