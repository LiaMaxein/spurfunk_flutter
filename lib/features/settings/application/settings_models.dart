import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

enum AppThemeMode {
  light('light', 'Hell'),
  dark('dark', 'Dunkel'),
  system('system', 'System');

  const AppThemeMode(this.id, this.label);

  final String id;
  final String label;

  ThemeMode get themeMode => switch (this) {
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };

  static AppThemeMode fromId(String? id) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.id == id,
      orElse: () => AppThemeMode.dark,
    );
  }
}

enum AppAccentColor {
  red('red', 'Rot', AppColors.red),
  blue('blue', 'Blau', AppColors.blue),
  green('green', 'Grün', AppColors.green),
  orange('orange', 'Orange', AppColors.orange);

  const AppAccentColor(this.id, this.label, this.color);

  final String id;
  final String label;
  final Color color;

  static AppAccentColor fromId(String? id) {
    return AppAccentColor.values.firstWhere(
      (accent) => accent.id == id,
      orElse: () => AppAccentColor.red,
    );
  }
}

enum AppFontSizeLevel {
  small('small', 'Klein', 0.9),
  normal('normal', 'Normal', 1.0),
  large('large', 'Groß', 1.15);

  const AppFontSizeLevel(this.id, this.label, this.scale);

  final String id;
  final String label;
  final double scale;

  static AppFontSizeLevel fromId(String? id) {
    return AppFontSizeLevel.values.firstWhere(
      (level) => level.id == id,
      orElse: () => AppFontSizeLevel.normal,
    );
  }
}

enum AppChatDensity {
  compact('compact', 'Kompakt'),
  comfortable('comfortable', 'Komfortabel');

  const AppChatDensity(this.id, this.label);

  final String id;
  final String label;

  static AppChatDensity fromId(String? id) {
    return AppChatDensity.values.firstWhere(
      (density) => density.id == id,
      orElse: () => AppChatDensity.comfortable,
    );
  }
}

enum NotificationPreference {
  liveStart('notify_live_start', 'Live-Beginn'),
  news('notify_news', 'Polizeifunk-News'),
  newsletter('notify_newsletter', 'Newsletter'),
  weeklySummary('notify_weekly_summary', 'Wochenzusammenfassung');

  const NotificationPreference(this.key, this.label);

  final String key;
  final String label;
}
