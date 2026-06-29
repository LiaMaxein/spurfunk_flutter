import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum FactsCitiesView { map, list }

class FactsCitiesSegment extends StatelessWidget {
  const FactsCitiesSegment({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final FactsCitiesView selected;
  final ValueChanged<FactsCitiesView> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          _SegmentButton(
            label: 'Karte',
            selected: selected == FactsCitiesView.map,
            onTap: () => onChanged(FactsCitiesView.map),
          ),
          _SegmentButton(
            label: 'Liste',
            selected: selected == FactsCitiesView.list,
            onTap: () => onChanged(FactsCitiesView.list),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.red : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.5,
              color: selected ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
