import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/persistence/shared_preferences_provider.dart';

const _profileHeroIndexKey = 'profile_hero_index';

final profileHeroBackgroundProvider = Provider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  var index = prefs.getInt(_profileHeroIndexKey);
  if (index == null) {
    index = Random().nextInt(AppAssets.profileHeroBackgrounds.length);
    Future.microtask(() => prefs.setInt(_profileHeroIndexKey, index!));
  }
  return AppAssets.profileHeroBackgrounds[index];
});
