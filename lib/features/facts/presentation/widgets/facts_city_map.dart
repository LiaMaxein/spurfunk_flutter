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
      child: Stack(
        children: [
          FlutterMap(
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
                          color:
                              city.isActive ? AppColors.red : AppColors.textMuted,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: _MapLegend(),
          ),
        ],
      ),
    );
  }
}

class _MapLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _LegendItem(
              color: AppColors.red,
              label: 'Aktive Teams',
            ),
            const SizedBox(height: 8),
            _LegendItem(
              color: AppColors.textMuted,
              label: 'Ehemalige Teams',
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
