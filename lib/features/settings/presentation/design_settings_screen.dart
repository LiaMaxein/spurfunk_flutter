import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../application/settings_models.dart';
import '../application/settings_state.dart';
import 'widgets/settings_widgets.dart';

class DesignSettingsScreen extends ConsumerWidget {
  const DesignSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeSettingProvider);
    final accent = ref.watch(accentColorProvider);
    final fontSize = ref.watch(fontSizeLevelProvider);
    final chatDensity = ref.watch(chatDensityProvider);

    return SettingsScaffold(
      title: 'APP-DESIGN',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Erscheinungsbild', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          SettingsChoiceChips<AppThemeMode>(
            labels: AppThemeMode.values.map((m) => m.label).toList(),
            values: AppThemeMode.values,
            selected: themeMode,
            onSelected: (value) =>
                ref.read(themeModeSettingProvider.notifier).setValue(value),
          ),
          const SizedBox(height: 20),
          Text('Akzentfarbe', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              for (final option in AppAccentColor.values)
                GestureDetector(
                  onTap: () =>
                      ref.read(accentColorProvider.notifier).setValue(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: option.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accent == option
                            ? AppColors.textPrimary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Schriftgröße', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          SettingsChoiceChips<AppFontSizeLevel>(
            labels: AppFontSizeLevel.values.map((l) => l.label).toList(),
            values: AppFontSizeLevel.values,
            selected: fontSize,
            onSelected: (value) =>
                ref.read(fontSizeLevelProvider.notifier).setValue(value),
          ),
          const SizedBox(height: 20),
          Text('Chat-Dichte', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          SettingsChoiceChips<AppChatDensity>(
            labels: AppChatDensity.values.map((d) => d.label).toList(),
            values: AppChatDensity.values,
            selected: chatDensity,
            onSelected: (value) =>
                ref.read(chatDensityProvider.notifier).setValue(value),
          ),
        ],
      ),
    );
  }
}
