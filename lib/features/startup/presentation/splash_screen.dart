import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../../core/widgets/spurfunk_loader.dart';

/// Shown while [appBootstrapProvider] hydrates local preferences (min. 5s).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.sizeOf(context).height * 0.42,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.splashNoirCouple,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.black,
                        AppColors.black.withValues(alpha: 0.85),
                        Colors.transparent,
                      ],
                      stops: const [0, 0.35, 0.7],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 48),
                const SpurfunkLogo(
                  variant: SpurfunkLogoVariant.withClaim,
                  height: 132,
                ),
                const SizedBox(height: 28),
                Text(
                  'Gemeinsam schauen.\nGemeinsam rätseln.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    height: 1.45,
                  ),
                ),
                const Spacer(),
                const SpurfunkArcLoader(),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
