import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import 'widgets/settings_widgets.dart';

class HelpSettingsScreen extends StatelessWidget {
  const HelpSettingsScreen({super.key});

  static const _faqs = [
    (
      'Was ist Spurfunk?',
      'Spurfunk ist ein inoffizieller Second-Screen-Begleiter für Tatort-Fans. '
          'Du kannst live abstimmen, chatten und Statistiken verfolgen.',
    ),
    (
      'Werden meine Daten gespeichert?',
      'Im Prototyp bleiben alle Daten lokal auf deinem Gerät. '
          'Es gibt keine Server-Anmeldung.',
    ),
    (
      'Wie ändere ich meinen Avatar?',
      'Öffne „Meine Akte“ und tippe auf dein Profilbild mit dem Stift-Symbol '
          'oder gehe zu Einstellungen → Profil & Identität.',
    ),
    (
      'Wo finde ich Quiz und Memory?',
      'Im Community-Bereich unter den Tabs „Quiz“ und „Memory“. '
          'Die Rangliste folgt in einer späteren Ausbaustufe.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'HILFE & FAQ',
      child: Column(
        children: [
          for (final faq in _faqs) ...[
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq.$1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    faq.$2,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
