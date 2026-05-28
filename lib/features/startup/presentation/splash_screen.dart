import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../onboarding/presentation/widgets/onboarding_widgets.dart';

/// Shown while [appBootstrapProvider] hydrates local preferences.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const Positioned.fill(child: CinematicBackdrop()),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.85, end: 1),
              duration: const Duration(milliseconds: 680),
              curve: Curves.easeOutCubic,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingBrand(large: true),
                  SizedBox(height: 36),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.redSoft,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Fall wird vorbereitet …',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
