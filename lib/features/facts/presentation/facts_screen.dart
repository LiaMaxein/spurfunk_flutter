import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/widgets/app_components.dart';

class FactsScreen extends ConsumerWidget {
  const FactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      header: const SpurfunkHeader(title: 'FAKTEN'),
      child: EmptyState(
        title: 'Bald verfügbar',
        subtitle:
            'Ermittler-Teams, Geschichte und Fun Facts kommen in Version 1.5. '
            'Inoffizielles Fan-Projekt – keine Verbindung zur ARD.',
        icon: Icons.folder_outlined,
        action: AppCard(
          child: Text(
            'Spurfunk sammelt Wissen rund um Krimi-Kultur – '
            'bleib dran für die nächste Ausbaustufe.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
