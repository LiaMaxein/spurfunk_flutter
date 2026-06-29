import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/persistence/user_preferences.dart';
import '../../../core/router/app_routes.dart';
import '../../onboarding/application/onboarding_state.dart';
import 'settings_models.dart';

final notificationsEnabledProvider =
    NotifierProvider<NotificationsEnabledNotifier, bool>(
      NotificationsEnabledNotifier.new,
    );

final notificationPreferencesProvider =
    NotifierProvider<NotificationPreferencesNotifier, Map<String, bool>>(
      NotificationPreferencesNotifier.new,
    );

final themeModeSettingProvider =
    NotifierProvider<ThemeModeSettingNotifier, AppThemeMode>(
      ThemeModeSettingNotifier.new,
    );

final accentColorProvider = NotifierProvider<AccentColorNotifier, AppAccentColor>(
  AccentColorNotifier.new,
);

final fontSizeLevelProvider =
    NotifierProvider<FontSizeLevelNotifier, AppFontSizeLevel>(
      FontSizeLevelNotifier.new,
    );

final chatDensityProvider =
    NotifierProvider<ChatDensityNotifier, AppChatDensity>(
      ChatDensityNotifier.new,
    );

final reducedMotionProvider = NotifierProvider<ReducedMotionNotifier, bool>(
  ReducedMotionNotifier.new,
);

final highContrastProvider = NotifierProvider<HighContrastNotifier, bool>(
  HighContrastNotifier.new,
);

final largeTextProvider = NotifierProvider<LargeTextNotifier, bool>(
  LargeTextNotifier.new,
);

final voiceAssistProvider = NotifierProvider<VoiceAssistNotifier, bool>(
  VoiceAssistNotifier.new,
);

final hapticsEnabledProvider = NotifierProvider<HapticsEnabledNotifier, bool>(
  HapticsEnabledNotifier.new,
);

final largeTouchTargetsProvider =
    NotifierProvider<LargeTouchTargetsNotifier, bool>(
      LargeTouchTargetsNotifier.new,
    );

/// Combined text scale from font size level and large-text toggle.
final effectiveTextScaleProvider = Provider<double>((ref) {
  final level = ref.watch(fontSizeLevelProvider);
  final largeText = ref.watch(largeTextProvider);
  var scale = level.scale;
  if (largeText) scale += 0.1;
  return scale;
});

@Deprecated('Use themeModeSettingProvider')
final darkModeEnabledProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeModeSettingProvider);
  return mode != AppThemeMode.light;
});

class NotificationsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).notificationsEnabled;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setNotificationsEnabled(value);
    if (!value) {
      for (final pref in NotificationPreference.values) {
        await ref
            .read(userPreferencesProvider)
            .setNotificationPreference(pref.key, false);
      }
      ref.invalidate(notificationPreferencesProvider);
    }
  }
}

class NotificationPreferencesNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() {
    final prefs = ref.watch(userPreferencesProvider);
    return {
      for (final pref in NotificationPreference.values)
        pref.key: prefs.notificationEnabledFor(pref.key),
    };
  }

  Future<void> setValue(String key, bool value) async {
    state = {...state, key: value};
    await ref.read(userPreferencesProvider).setNotificationPreference(key, value);
    if (value && !ref.read(userPreferencesProvider).notificationsEnabled) {
      await ref.read(notificationsEnabledProvider.notifier).setValue(true);
    }
  }
}

class ThemeModeSettingNotifier extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    final prefs = ref.watch(userPreferencesProvider);
    final stored = prefs.themeMode;
    if (stored != null) return AppThemeMode.fromId(stored);
    return prefs.darkModeEnabled ? AppThemeMode.dark : AppThemeMode.light;
  }

  Future<void> setValue(AppThemeMode value) async {
    state = value;
    final prefs = ref.read(userPreferencesProvider);
    await prefs.setThemeMode(value.id);
    await prefs.setDarkModeEnabled(value != AppThemeMode.light);
  }
}

class AccentColorNotifier extends Notifier<AppAccentColor> {
  @override
  AppAccentColor build() {
    return AppAccentColor.fromId(
      ref.watch(userPreferencesProvider).accentColor,
    );
  }

  Future<void> setValue(AppAccentColor value) async {
    state = value;
    await ref.read(userPreferencesProvider).setAccentColor(value.id);
  }
}

class FontSizeLevelNotifier extends Notifier<AppFontSizeLevel> {
  @override
  AppFontSizeLevel build() {
    return AppFontSizeLevel.fromId(
      ref.watch(userPreferencesProvider).fontSizeLevel,
    );
  }

  Future<void> setValue(AppFontSizeLevel value) async {
    state = value;
    await ref.read(userPreferencesProvider).setFontSizeLevel(value.id);
  }
}

class ChatDensityNotifier extends Notifier<AppChatDensity> {
  @override
  AppChatDensity build() {
    return AppChatDensity.fromId(
      ref.watch(userPreferencesProvider).chatDensity,
    );
  }

  Future<void> setValue(AppChatDensity value) async {
    state = value;
    await ref.read(userPreferencesProvider).setChatDensity(value.id);
  }
}

class ReducedMotionNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).reducedMotion;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setReducedMotion(value);
  }
}

class HighContrastNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).highContrast;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setHighContrast(value);
  }
}

class LargeTextNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).largeText;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setLargeText(value);
  }
}

class VoiceAssistNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).voiceAssist;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setVoiceAssist(value);
  }
}

class HapticsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).hapticsEnabled;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setHapticsEnabled(value);
  }
}

class LargeTouchTargetsNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).largeTouchTargets;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setLargeTouchTargets(value);
  }
}

Future<void> logoutUser(WidgetRef ref, GoRouter router) async {
  await ref.read(userPreferencesProvider).clearProfileData();
  await ref.read(onboardingCompletedProvider.notifier).reset();
  router.go(AppRoutes.onboardingPath);
}

Future<void> clearAllLocalData(WidgetRef ref, GoRouter router) async {
  await ref.read(userPreferencesProvider).clearAllData();
  ref.invalidate(onboardingCompletedProvider);
  ref.invalidate(selectedAvatarIdProvider);
  ref.invalidate(usernameProvider);
  ref.invalidate(anonymousModeProvider);
  ref.invalidate(profileGenderProvider);
  router.go(AppRoutes.onboardingPath);
}

Future<void> clearCache(WidgetRef ref) async {
  // Prototype: no separate image cache layer yet.
  await Future<void>.delayed(const Duration(milliseconds: 300));
}
