import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../theme/app_colors.dart';
import 'responsive_breakpoints.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final selectedIndex = _selectedIndex(context);
    final useRail = width >= ResponsiveBreakpoints.compact;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.surface, AppColors.black, AppColors.black],
          ),
        ),
        child: Row(
          children: [
            if (useRail)
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) => _goToIndex(context, index),
                labelType: NavigationRailLabelType.all,
                leading: const Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 24),
                  child: _BrandMark(),
                ),
                destinations: [
                  for (final route in AppRoutes.navigationRoutes)
                    NavigationRailDestination(
                      icon: Icon(route.icon),
                      label: Text(route.label),
                    ),
                ],
              ),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: useRail
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _goToIndex(context, index),
              destinations: [
                for (final route in AppRoutes.navigationRoutes)
                  NavigationDestination(
                    icon: Icon(route.icon),
                    label: route.label,
                  ),
              ],
            ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = AppRoutes.navigationRoutes.indexWhere((route) {
      // Keep correct tab selected for nested routes, e.g. /profile/settings.
      if (route.path == '/') return location == '/';
      return location.startsWith(route.path);
    });

    return index < 0 ? 0 : index;
  }

  void _goToIndex(BuildContext context, int index) {
    context.go(AppRoutes.navigationRoutes[index].path);
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.red, AppColors.redDark],
        ),
      ),
      child: const Icon(Icons.favorite_rounded, color: Colors.white),
    );
  }
}
