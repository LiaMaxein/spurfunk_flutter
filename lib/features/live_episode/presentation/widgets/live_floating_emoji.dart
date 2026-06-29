import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LiveFloatingEmoji extends StatefulWidget {
  const LiveFloatingEmoji({
    required this.emoji,
    required this.index,
    super.key,
  });

  final String emoji;
  final int index;

  @override
  State<LiveFloatingEmoji> createState() => _LiveFloatingEmojiState();
}

class _LiveFloatingEmojiState extends State<LiveFloatingEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Positioned(
          right: 14 + (widget.index % 3) * 14.0,
          bottom: 144 + t * (media.height * 0.35),
          child: Opacity(
            opacity: 1 - t,
            child: widget.emoji == '❤️'
                ? const Icon(
                    Icons.favorite,
                    color: AppColors.red,
                    size: 28,
                  )
                : Text(widget.emoji, style: const TextStyle(fontSize: 28)),
          ),
        );
      },
    );
  }
}
