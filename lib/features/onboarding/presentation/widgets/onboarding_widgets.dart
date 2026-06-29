import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cinematic_widgets.dart';
import '../../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../../../shared/mock_data/mock_data.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: CinematicBackdrop()),
          const Positioned.fill(child: _AnimatedEvidenceGrid()),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingBrand extends StatelessWidget {
  const OnboardingBrand({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) {
    return SpurfunkLogo(
      variant: large
          ? SpurfunkLogoVariant.withClaim
          : SpurfunkLogoVariant.horizontal,
      height: large ? 120 : 48,
    );
  }
}

/// Scrollable onboarding page body that avoids RenderFlex overflow on small screens.
class OnboardingPageBody extends StatelessWidget {
  const OnboardingPageBody({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        );
      },
    );
  }
}

class OnboardingStepDots extends StatelessWidget {
  const OnboardingStepDots({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (dotIndex) {
        final selected = dotIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: selected ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.redSoft
                : AppColors.textMuted.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

class AvatarCaseCard extends StatefulWidget {
  const AvatarCaseCard({
    required this.avatar,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final RoleAvatarPreset avatar;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<AvatarCaseCard> createState() => _AvatarCaseCardState();
}

class _AvatarCaseCardState extends State<AvatarCaseCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: selected ? 1.035 : (_pressed ? 0.97 : 1),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh.withValues(
              alpha: selected ? 0.92 : 0.7,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: selected
                  ? AppColors.redSoft
                  : Colors.white.withValues(alpha: 0.06),
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.red.withValues(alpha: 0.28),
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : kEmptyBoxShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 48,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      child: SpurfunkAvatar(
                        assetPath: widget.avatar.assetPath,
                        size: 46,
                        padding: 5,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        opacity: selected ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.redSoft,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.avatar.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.avatar.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 10,
                      height: 1.25,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedOnboardingStep extends StatelessWidget {
  const AnimatedOnboardingStep({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class NoirButton extends StatefulWidget {
  const NoirButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  State<NoirButton> createState() => _NoirButtonState();
}

class _NoirButtonState extends State<NoirButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            icon: widget.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(widget.icon ?? Icons.arrow_forward_rounded),
            label: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _AnimatedEvidenceGrid extends StatefulWidget {
  const _AnimatedEvidenceGrid();

  @override
  State<_AnimatedEvidenceGrid> createState() => _AnimatedEvidenceGridState();
}

class _AnimatedEvidenceGridState extends State<_AnimatedEvidenceGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _EvidenceGridPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _EvidenceGridPainter extends CustomPainter {
  const _EvidenceGridPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 1;

    final offset = progress * 42;
    for (var x = -42.0 + offset; x < size.width; x += 42) {
      canvas.drawLine(Offset(x, 0), Offset(x - 26, size.height), paint);
    }

    final redPaint = Paint()
      ..color = AppColors.red.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final center = Offset(size.width * 0.82, size.height * 0.18);
    canvas.drawCircle(
      center,
      54 + math.sin(progress * math.pi * 2) * 6,
      redPaint,
    );
    canvas.drawLine(
      center.translate(-70, 0),
      center.translate(70, 0),
      redPaint,
    );
    canvas.drawLine(
      center.translate(0, -70),
      center.translate(0, 70),
      redPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _EvidenceGridPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
