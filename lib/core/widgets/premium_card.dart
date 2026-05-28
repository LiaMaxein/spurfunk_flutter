import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Ink(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
