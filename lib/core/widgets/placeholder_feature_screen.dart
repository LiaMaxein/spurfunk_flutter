import 'package:flutter/material.dart';

import '../layout/responsive_page.dart';
import '../theme/app_colors.dart';
import 'premium_card.dart';
import 'section_header.dart';
import 'status_chip.dart';

class PlaceholderFeatureScreen extends StatelessWidget {
  const PlaceholderFeatureScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryAction,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String primaryAction;

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, subtitle: subtitle),
          const SizedBox(height: 24),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusChip(label: 'Foundation ready', icon: icon),
                const SizedBox(height: 28),
                Icon(icon, size: 52, color: AppColors.redSoft),
                const SizedBox(height: 18),
                Text(
                  primaryAction,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'This placeholder defines spacing, hierarchy, surfaces, and navigation behavior before product data is connected.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Preview interaction'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
