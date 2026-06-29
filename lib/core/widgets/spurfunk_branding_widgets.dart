import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets/app_assets.dart';
import '../theme/app_colors.dart';

enum SpurfunkLogoVariant { horizontal, withClaim }

class SpurfunkLogo extends StatelessWidget {
  const SpurfunkLogo({
    super.key,
    this.variant = SpurfunkLogoVariant.withClaim,
    this.height = 80,
    this.fit = BoxFit.contain,
  });

  final SpurfunkLogoVariant variant;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final asset = switch (variant) {
      SpurfunkLogoVariant.horizontal => AppAssets.logoNameIcon,
      SpurfunkLogoVariant.withClaim => AppAssets.logoNameClaim,
    };

    return SvgPicture.asset(
      asset,
      height: height,
      fit: fit,
    );
  }
}

class SpurfunkAvatar extends StatelessWidget {
  const SpurfunkAvatar({
    required this.assetPath,
    super.key,
    this.size = 58,
    this.padding = 6,
  });

  final String assetPath;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
