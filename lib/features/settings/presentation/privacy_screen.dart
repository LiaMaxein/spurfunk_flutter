import 'package:flutter/material.dart';

import '../../../core/widgets/cinematic_widgets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Datenschutz'),
          const SizedBox(height: 18),
          GlassCard(
            child: Text(
              'Alle Daten bleiben lokal auf deinem Gerät. '
              'Keine Anmeldung, kein Tracking, keine Serverübertragung.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
