import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/profile_mock_data.dart';
import '../../data/profile_models.dart';

class ProfileActivityCalendar extends StatelessWidget {
  const ProfileActivityCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    const weekDays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
    const days = [12, 13, 14, 15, 16, 17, 18];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profileActivityMonthLabel,
            style: GoogleFonts.bebasNeue(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final day in weekDays)
                Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final day in days)
                Expanded(
                  child: Center(
                    child: Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: day == profileActivitySelectedDay
                            ? AppColors.red
                            : Colors.transparent,
                      ),
                      child: Text(
                        '$day',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: day == profileActivitySelectedDay
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileActivityList extends StatelessWidget {
  const ProfileActivityList({required this.events, super.key});

  final List<ProfileActivityEvent> events;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HEUTIGE AKTIVITÄT',
            style: GoogleFonts.bebasNeue(
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < events.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconForActivityType(events[i].type),
                  color: AppColors.red,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        events[i].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '+${events[i].xpDelta} XP',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  events[i].timeLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            if (i < events.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class ProfileTodayXpFooter extends StatelessWidget {
  const ProfileTodayXpFooter({required this.totalXp, super.key});

  final int totalXp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.star_rounded, color: AppColors.yellow, size: 22),
        const SizedBox(width: 8),
        Text(
          'HEUTE GESAMMELT: $totalXp XP',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
