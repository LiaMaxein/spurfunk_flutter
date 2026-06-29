import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/facts_mock_data.dart';
import 'facts_cities_segment.dart';
import 'facts_city_list.dart';
import 'facts_city_map.dart';

class FactsCitiesTab extends StatefulWidget {
  const FactsCitiesTab({super.key});

  @override
  State<FactsCitiesTab> createState() => _FactsCitiesTabState();
}

class _FactsCitiesTabState extends State<FactsCitiesTab> {
  FactsCitiesView _view = FactsCitiesView.map;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'STÄDTE',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: AppColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tatort-Drehstädte in Deutschland, Österreich und der Schweiz.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 14),
        FactsCitiesSegment(
          selected: _view,
          onChanged: (view) => setState(() => _view = view),
        ),
        const SizedBox(height: 14),
        if (_view == FactsCitiesView.map)
          Expanded(child: FactsCityMap(cities: factsTatortCities))
        else
          Expanded(child: FactsCityList(cities: factsTatortCities)),
      ],
    );
  }
}
