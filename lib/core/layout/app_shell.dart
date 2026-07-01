import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/spurfunk_navigation.dart';
import '../router/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/app_components.dart';
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
      backgroundColor: AppColors.black,
      body: Row(
        children: [
          if (useRail)
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _goToIndex(context, index),
              labelType: NavigationRailLabelType.all,
              backgroundColor: AppColors.black,
              selectedIconTheme: const IconThemeData(color: AppColors.red),
              unselectedIconTheme: const IconThemeData(color: AppColors.textMuted),
              destinations: [
                for (final route in AppRoutes.navigationRoutes)
                  NavigationRailDestination(
                    icon: Icon(route.icon),
                    label: Text(route.label),
                  ),
              ],
            ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                child,
                if (_showBackButton(context))
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SafeArea(
                      bottom: false,
                      right: false,
                      child: Material(
                        color: Colors.transparent,
                        child: SpurfunkBackButton(
                          onPressed: () => spurfunkGoBack(context),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: useRail ? null : _SpurfunkTabBar(selectedIndex: selectedIndex),
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = AppRoutes.navigationRoutes.indexWhere((route) {
      if (route.path == '/') return location == '/';
      return location.startsWith(route.path);
    });
    return index < 0 ? 0 : index;
  }

  void _goToIndex(BuildContext context, int index) {
    context.go(AppRoutes.navigationRoutes[index].path);
  }

  bool _showBackButton(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return !isSpurfunkMainTabRoute(location);
  }
}

class _SpurfunkTabBar extends StatelessWidget {
  const _SpurfunkTabBar({required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (var i = 0; i < AppRoutes.navigationRoutes.length; i++)
                Expanded(
                  child: _TabItem(
                    route: AppRoutes.navigationRoutes[i],
                    selected: i == selectedIndex,
                    onTap: () =>
                        context.go(AppRoutes.navigationRoutes[i].path),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.route,
    required this.selected,
    required this.onTap,
  });

  final AppRouteData route;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: route.label,
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              route.icon,
              color: selected ? AppColors.red : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color: selected ? AppColors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    super.key,
    this.header,
  });

  final Widget child;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null) Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: header!,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
