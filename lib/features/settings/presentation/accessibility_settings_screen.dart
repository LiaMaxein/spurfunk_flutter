import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_state.dart';
import 'widgets/settings_widgets.dart';

class AccessibilitySettingsScreen extends ConsumerWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final largeText = ref.watch(largeTextProvider);
    final highContrast = ref.watch(highContrastProvider);
    final reducedMotion = ref.watch(reducedMotionProvider);
    final voiceAssist = ref.watch(voiceAssistProvider);
    final haptics = ref.watch(hapticsEnabledProvider);
    final largeTouch = ref.watch(largeTouchTargetsProvider);

    return SettingsScaffold(
      title: 'BARRIEREFREIHEIT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsSwitchRow(
            icon: Icons.text_fields_outlined,
            title: 'Größere Schrift',
            subtitle: 'Erhöht die Textgröße in der gesamten App',
            value: largeText,
            onChanged: (value) =>
                ref.read(largeTextProvider.notifier).setValue(value),
          ),
          SettingsSwitchRow(
            icon: Icons.contrast_outlined,
            title: 'Erhöhter Kontrast',
            value: highContrast,
            onChanged: (value) =>
                ref.read(highContrastProvider.notifier).setValue(value),
          ),
          SettingsSwitchRow(
            icon: Icons.animation_outlined,
            title: 'Animationen reduzieren',
            value: reducedMotion,
            onChanged: (value) =>
                ref.read(reducedMotionProvider.notifier).setValue(value),
          ),
          SettingsSwitchRow(
            icon: Icons.record_voice_over_outlined,
            title: 'Sprachunterstützung',
            subtitle: 'Vorbereitet für Screenreader-Hinweise',
            value: voiceAssist,
            onChanged: (value) =>
                ref.read(voiceAssistProvider.notifier).setValue(value),
          ),
          SettingsSwitchRow(
            icon: Icons.vibration_outlined,
            title: 'Haptik',
            value: haptics,
            onChanged: (value) =>
                ref.read(hapticsEnabledProvider.notifier).setValue(value),
          ),
          SettingsSwitchRow(
            icon: Icons.touch_app_outlined,
            title: 'Vergrößerte Touchflächen',
            value: largeTouch,
            onChanged: (value) =>
                ref.read(largeTouchTargetsProvider.notifier).setValue(value),
          ),
        ],
      ),
    );
  }
}
