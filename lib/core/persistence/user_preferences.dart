import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

/// Local key-value storage for onboarding and profile demo data.
class UserPreferences {
  UserPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _onboardingCompleted = 'onboarding_completed';
  static const _avatarId = 'avatar_id';
  static const _gender = 'gender';
  static const _username = 'username';
  static const _anonymousMode = 'anonymous_mode';
  static const _notificationsEnabled = 'notifications_enabled';
  static const _darkModeEnabled = 'dark_mode_enabled';
  static const _themeMode = 'theme_mode';
  static const _accentColor = 'accent_color';
  static const _fontSizeLevel = 'font_size_level';
  static const _chatDensity = 'chat_density';
  static const _reducedMotion = 'reduced_motion';
  static const _highContrast = 'high_contrast';
  static const _largeText = 'large_text';
  static const _voiceAssist = 'voice_assist';
  static const _haptics = 'haptics_enabled';
  static const _largeTouchTargets = 'large_touch_targets';
  static const _forceLiveDemo = 'force_live_demo';

  bool get onboardingCompleted =>
      _prefs.getBool(_onboardingCompleted) ?? false;

  String? get avatarId => _prefs.getString(_avatarId);

  String? get gender => _prefs.getString(_gender);

  String get username => _prefs.getString(_username) ?? '';

  bool get anonymousMode => _prefs.getBool(_anonymousMode) ?? true;
  bool get notificationsEnabled => _prefs.getBool(_notificationsEnabled) ?? true;
  bool get darkModeEnabled => _prefs.getBool(_darkModeEnabled) ?? true;
  String? get themeMode => _prefs.getString(_themeMode);
  String? get accentColor => _prefs.getString(_accentColor);
  String? get fontSizeLevel => _prefs.getString(_fontSizeLevel);
  String? get chatDensity => _prefs.getString(_chatDensity);
  bool get reducedMotion => _prefs.getBool(_reducedMotion) ?? false;
  bool get highContrast => _prefs.getBool(_highContrast) ?? false;
  bool get largeText => _prefs.getBool(_largeText) ?? false;
  bool get voiceAssist => _prefs.getBool(_voiceAssist) ?? false;
  bool get hapticsEnabled => _prefs.getBool(_haptics) ?? true;
  bool get largeTouchTargets => _prefs.getBool(_largeTouchTargets) ?? false;
  bool get forceLiveDemo => _prefs.getBool(_forceLiveDemo) ?? false;

  bool notificationEnabledFor(String key) =>
      _prefs.getBool(key) ?? notificationsEnabled;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_onboardingCompleted, value);

  Future<void> setAvatarId(String id) => _prefs.setString(_avatarId, id);

  Future<void> setGender(String id) => _prefs.setString(_gender, id);

  Future<void> setUsername(String value) => _prefs.setString(_username, value);

  Future<void> setAnonymousMode(bool value) =>
      _prefs.setBool(_anonymousMode, value);

  Future<void> setNotificationsEnabled(bool value) =>
      _prefs.setBool(_notificationsEnabled, value);

  Future<void> setNotificationPreference(String key, bool value) =>
      _prefs.setBool(key, value);

  Future<void> setDarkModeEnabled(bool value) =>
      _prefs.setBool(_darkModeEnabled, value);

  Future<void> setThemeMode(String value) => _prefs.setString(_themeMode, value);

  Future<void> setAccentColor(String value) =>
      _prefs.setString(_accentColor, value);

  Future<void> setFontSizeLevel(String value) =>
      _prefs.setString(_fontSizeLevel, value);

  Future<void> setChatDensity(String value) =>
      _prefs.setString(_chatDensity, value);

  Future<void> setReducedMotion(bool value) =>
      _prefs.setBool(_reducedMotion, value);

  Future<void> setHighContrast(bool value) =>
      _prefs.setBool(_highContrast, value);

  Future<void> setLargeText(bool value) => _prefs.setBool(_largeText, value);

  Future<void> setVoiceAssist(bool value) => _prefs.setBool(_voiceAssist, value);

  Future<void> setHapticsEnabled(bool value) => _prefs.setBool(_haptics, value);

  Future<void> setLargeTouchTargets(bool value) =>
      _prefs.setBool(_largeTouchTargets, value);

  Future<void> setForceLiveDemo(bool value) =>
      _prefs.setBool(_forceLiveDemo, value);

  Future<void> clearProfileData() async {
    await _prefs.remove(_avatarId);
    await _prefs.remove(_gender);
    await _prefs.remove(_username);
    await _prefs.remove(_anonymousMode);
    final keys = _prefs.getKeys().where(
      (key) =>
          key.startsWith('favorite_investigator_') ||
          key.startsWith('favorite_team_'),
    );
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }

  Future<void> clearAllData() => _prefs.clear();
}

final userPreferencesProvider = Provider<UserPreferences>((ref) {
  return UserPreferences(ref.watch(sharedPreferencesProvider));
});
