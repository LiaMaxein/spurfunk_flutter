import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

/// Local key-value storage for onboarding and profile demo data.
class UserPreferences {
  UserPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _onboardingCompleted = 'onboarding_completed';
  static const _avatarId = 'avatar_id';
  static const _username = 'username';
  static const _anonymousMode = 'anonymous_mode';

  bool get onboardingCompleted =>
      _prefs.getBool(_onboardingCompleted) ?? false;

  String? get avatarId => _prefs.getString(_avatarId);

  String get username => _prefs.getString(_username) ?? '';

  bool get anonymousMode => _prefs.getBool(_anonymousMode) ?? true;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_onboardingCompleted, value);

  Future<void> setAvatarId(String id) => _prefs.setString(_avatarId, id);

  Future<void> setUsername(String value) => _prefs.setString(_username, value);

  Future<void> setAnonymousMode(bool value) =>
      _prefs.setBool(_anonymousMode, value);
}

final userPreferencesProvider = Provider<UserPreferences>((ref) {
  return UserPreferences(ref.watch(sharedPreferencesProvider));
});
