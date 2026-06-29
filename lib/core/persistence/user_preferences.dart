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
  static const _reducedMotion = 'reduced_motion';
  static const _highContrast = 'high_contrast';
  static const _largeText = 'large_text';

  bool get onboardingCompleted =>
      _prefs.getBool(_onboardingCompleted) ?? false;

  String? get avatarId => _prefs.getString(_avatarId);

  String? get gender => _prefs.getString(_gender);

  String get username => _prefs.getString(_username) ?? '';

  bool get anonymousMode => _prefs.getBool(_anonymousMode) ?? true;
  bool get notificationsEnabled => _prefs.getBool(_notificationsEnabled) ?? true;
  bool get darkModeEnabled => _prefs.getBool(_darkModeEnabled) ?? true;
  bool get reducedMotion => _prefs.getBool(_reducedMotion) ?? false;
  bool get highContrast => _prefs.getBool(_highContrast) ?? false;
  bool get largeText => _prefs.getBool(_largeText) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_onboardingCompleted, value);

  Future<void> setAvatarId(String id) => _prefs.setString(_avatarId, id);

  Future<void> setGender(String id) => _prefs.setString(_gender, id);

  Future<void> setUsername(String value) => _prefs.setString(_username, value);

  Future<void> setAnonymousMode(bool value) =>
      _prefs.setBool(_anonymousMode, value);

  Future<void> setNotificationsEnabled(bool value) =>
      _prefs.setBool(_notificationsEnabled, value);

  Future<void> setDarkModeEnabled(bool value) =>
      _prefs.setBool(_darkModeEnabled, value);

  Future<void> setReducedMotion(bool value) =>
      _prefs.setBool(_reducedMotion, value);

  Future<void> setHighContrast(bool value) =>
      _prefs.setBool(_highContrast, value);

  Future<void> setLargeText(bool value) => _prefs.setBool(_largeText, value);
}

final userPreferencesProvider = Provider<UserPreferences>((ref) {
  return UserPreferences(ref.watch(sharedPreferencesProvider));
});
