import 'package:flutter/material.dart';

import 'widgets/settings_widgets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'DATENSCHUTZ',
      child: Text(
        'Alle Daten bleiben lokal auf deinem Gerät. '
        'Keine Anmeldung, kein Tracking, keine Serverübertragung im Prototyp. '
        'Nach einer späteren Backend-Anbindung informieren wir dich transparent '
        'über gespeicherte Daten und deine Rechte.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
