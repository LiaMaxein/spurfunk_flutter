import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/facts_models.dart';
import 'facts_city_bottom_sheet.dart';

class FactsCityMap extends StatelessWidget {
  const FactsCityMap({required this.cities, super.key});

  final List<TatortCity> cities;

  static const _initialCenter = LatLng(50.5, 10.5);
  static const _initialZoom = 5.5;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: _initialCenter,
          initialZoom: _initialZoom,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
            subdomains: const ['a', 'b', 'c', 'd'],
            retinaMode: RetinaMode.isHighDensity(context),
          ),
          MarkerLayer(
            markers: [
              for (final city in cities)
                Marker(
                  point: LatLng(city.latitude, city.longitude),
                  width: 36,
                  height: 36,
                  child: GestureDetector(
                    onTap: () => FactsCityBottomSheet.show(context, city),
                    child: Icon(
                      Icons.location_on,
                      size: 36,
                      color: city.isActive ? AppColors.red : AppColors.textMuted,
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
