import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';

/// True for the five main tab roots (`/`, `/community`, `/live`, `/facts`, `/profile`).
bool isSpurfunkMainTabRoute(String location) {
  final path = Uri.tryParse(location)?.path ?? location;
  if (path == '/' || path.isEmpty) return true;
  for (final route in AppRoutes.navigationRoutes) {
    if (route.path != '/' && path == route.path) return true;
  }
  return false;
}

/// Navigates to the previous screen when possible, otherwise to a sensible parent.
void spurfunkGoBack(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }

  final path = GoRouterState.of(context).uri.path;
  if (path.startsWith('${AppRoutes.profile.path}/settings/')) {
    context.go(AppRoutes.profileSettingsPath);
    return;
  }
  if (path.startsWith('${AppRoutes.profile.path}/')) {
    context.go(AppRoutes.profile.path);
    return;
  }
  if (path.startsWith('${AppRoutes.community.path}/')) {
    context.go(AppRoutes.community.path);
    return;
  }
  if (path.startsWith('${AppRoutes.liveEpisode.path}/')) {
    context.go(AppRoutes.liveEpisode.path);
    return;
  }
  if (path.startsWith(AppRoutes.facts.path)) {
    context.go(AppRoutes.home.path);
    return;
  }

  context.go(AppRoutes.home.path);
}
