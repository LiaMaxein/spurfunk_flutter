import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/navigation/spurfunk_navigation.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/facts_cities_tab.dart';
import 'widgets/facts_history_tab.dart';
import 'widgets/facts_main_tab_bar.dart';
import 'widgets/facts_overview_tab.dart';
import 'widgets/facts_teams_tab.dart';

class FactsScreen extends ConsumerStatefulWidget {
  const FactsScreen({this.initialTab, super.key});

  final String? initialTab;

  @override
  ConsumerState<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends ConsumerState<FactsScreen> {
  late int _tab;

  static const _tabQueryValues = ['facts', 'teams', 'history', 'cities'];

  @override
  void initState() {
    super.initState();
    _tab = _indexForTab(widget.initialTab);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = GoRouter.maybeOf(context);
    if (router == null) return;
    final tabParam = router.state.uri.queryParameters['tab'];
    if (tabParam == null) return;
    final next = _indexForTab(tabParam);
    if (next != _tab) {
      setState(() => _tab = next);
    }
  }

  int _indexForTab(String? value) {
    final index = _tabQueryValues.indexOf(value ?? 'facts');
    return index < 0 ? 0 : index;
  }

  void _onTabChanged(int index) {
    setState(() => _tab = index);
    final router = GoRouter.maybeOf(context);
    if (router == null) return;
    final query = _tabQueryValues[index];
    router.go(
      Uri(
        path: AppRoutes.facts.path,
        queryParameters: query == 'facts' ? null : {'tab': query},
      ).toString(),
    );
  }

  void _handleBack(BuildContext context) => spurfunkGoBack(context);

  @override
  Widget build(BuildContext context) {
    final isCitiesMapTab = _tab == 3;

    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: _FactsHeader(onBack: () => _handleBack(context)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: FactsMainTabBar(
                selectedIndex: _tab,
                onChanged: _onTabChanged,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isCitiesMapTab
                    ? const FactsCitiesTab()
                    : SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildTabContent(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return switch (_tab) {
      0 => FactsOverviewTab(
        onExploreCities: () => _onTabChanged(3),
      ),
      1 => const FactsTeamsTab(),
      2 => const FactsHistoryTab(),
      _ => const SizedBox.shrink(),
    };
  }
}

class _FactsHeader extends StatelessWidget {
  const _FactsHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          tooltip: 'Zurück',
        ),
        Expanded(
          child: Text(
            'FAKTEN',
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(
              fontSize: 28,
              color: AppColors.textPrimary,
              letterSpacing: 1,
            ),
          ),
        ),
        IconButton(
          onPressed: () => context.go(AppRoutes.community.path),
          icon: const Icon(Icons.groups_outlined),
          color: AppColors.textPrimary,
          tooltip: 'Community',
        ),
      ],
    );
  }
}
