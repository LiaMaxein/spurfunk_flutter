import 'package:flutter/material.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'News & Live-Ticker'),
          const SizedBox(height: 14),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                RedPill(label: 'Alle'),
                SizedBox(width: 10),
                RedPill(label: 'News', selected: false),
                SizedBox(width: 10),
                RedPill(label: 'Termine', selected: false),
                SizedBox(width: 10),
                RedPill(label: 'Interviews', selected: false),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _NewsCard(
            icon: Icons.calendar_month_rounded,
            eyebrow: 'Nächster Tatort',
            title: 'Sonntag, 08.06.2024',
            subtitle: '20:15 Uhr – Das Mädchen am Strand',
            color: AppColors.redSoft,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.favorite_border_rounded,
            eyebrow: 'Ergebnis letzte Woche',
            title: 'Borowski und das Haupt der Medusa',
            subtitle: '12.458 Stimmen',
            color: AppColors.red,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.mic_none_rounded,
            eyebrow: 'Interview',
            title: 'Live-Interview mit ChrisTine Urspruch',
            subtitle: 'Dienstag, 04.06.2024 – 19:00 Uhr',
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.emoji_events_rounded,
            eyebrow: 'Community-Meilenstein',
            title: '100.000 Gesamtreaktionen',
            subtitle: 'Geknackt um 20:42 Uhr',
            color: AppColors.yellow,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.people_rounded,
            eyebrow: 'Zuschauerrekord',
            title: '24.810 gleichzeitige User live',
            subtitle: 'Neuer Rekord für diese Staffel',
            color: AppColors.greenSoft,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.trending_up_rounded,
            eyebrow: 'Top-Abstimmung',
            title: 'Mega führt mit 42 %',
            subtitle: 'Gut 31 %, Okay 18 %, Nicht gut 9 %',
            color: AppColors.green,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.quiz_rounded,
            eyebrow: 'Theorien-Update',
            title: 'Der Nachbar ist der Favorit',
            subtitle: '34 % der Community tippt auf Kessler',
            color: AppColors.orange,
          ),
          const SizedBox(height: 12),
          const _NewsCard(
            icon: Icons.podcasts_rounded,
            eyebrow: 'Podcast',
            title: 'Tatort-Cast – Jetzt Folge 42 hören',
            subtitle: 'Exklusiv für die Community',
            color: AppColors.red,
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppAssets.heroEpisode,
                    width: 72,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'News',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Neuer Tatort aus Hamburg: Drehstart im Juli',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text('Community-Statistiken', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _StatRow(label: 'Gesamte Nutzer', value: '5.420'),
          const SizedBox(height: 8),
          _StatRow(label: 'Kommentare heute', value: '847'),
          const SizedBox(height: 8),
          _StatRow(label: 'Aktive Diskussionen', value: '23'),
          const SizedBox(height: 8),
          _StatRow(label: 'Durchschnittsbewertung', value: '4.2 ★'),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      radius: 14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(value, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({
    required this.icon,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 4),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
