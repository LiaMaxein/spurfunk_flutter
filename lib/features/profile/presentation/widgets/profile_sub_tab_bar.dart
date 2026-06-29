import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/profile_models.dart';

class ProfileStatsTabBar extends StatelessWidget {
  const ProfileStatsTabBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ProfileStatsTab selected;
  final ValueChanged<ProfileStatsTab> onChanged;

  static const labels = ['Überblick', 'Live', 'Quiz', 'Memory'];

  @override
  Widget build(BuildContext context) {
    final tabs = ProfileStatsTab.values;
    return Row(
      children: [
        for (var i = 0; i < tabs.length; i++)
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(tabs[i]),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Text(
                      labels[i].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected == tabs[i]
                            ? AppColors.red
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 3,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selected == tabs[i]
                            ? AppColors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfileBadgeTabBar extends StatelessWidget {
  const ProfileBadgeTabBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ProfileBadgeFilter selected;
  final ValueChanged<ProfileBadgeFilter> onChanged;

  static const labels = ['Alle', 'Freigeschaltet', 'Gesperrt'];

  @override
  Widget build(BuildContext context) {
    final tabs = ProfileBadgeFilter.values;
    return Row(
      children: [
        for (var i = 0; i < tabs.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == tabs.length - 1 ? 0 : 8),
              child: GestureDetector(
                onTap: () => onChanged(tabs[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected == tabs[i]
                        ? AppColors.red
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selected == tabs[i]
                          ? AppColors.red
                          : AppColors.divider,
                    ),
                  ),
                  child: Text(
                    labels[i].toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: selected == tabs[i]
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
