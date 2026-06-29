import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum LiveTab { chat, caseInfo }

class LiveSubTabBar extends StatelessWidget {
  const LiveSubTabBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final LiveTab selected;
  final ValueChanged<LiveTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            label: 'Mitwisser-Chat',
            selected: selected == LiveTab.chat,
            onTap: () => onChanged(LiveTab.chat),
          ),
        ),
        Expanded(
          child: _TabButton(
            label: 'Aktueller Fall',
            selected: selected == LiveTab.caseInfo,
            onTap: () => onChanged(LiveTab.caseInfo),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: selected ? AppColors.red : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 3,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
