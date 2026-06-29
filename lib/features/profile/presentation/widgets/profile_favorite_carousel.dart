import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/investigator_portrait.dart';
import '../../data/profile_models.dart';

class ProfileFavoriteCarousel extends StatelessWidget {
  const ProfileFavoriteCarousel({required this.favorites, super.key});

  final List<FavoriteInvestigatorItem> favorites;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LIEBLINGS-ERMITTLER',
          style: GoogleFonts.bebasNeue(
            fontSize: 20,
            color: AppColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = favorites[index];
              return GestureDetector(
                onTap: () => context.push(item.routePath),
                child: SizedBox(
                  width: 84,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InvestigatorPortrait(
                            assetPath: item.portraitAssetPath,
                            size: 64,
                          ),
                          const Positioned(
                            right: -2,
                            top: -2,
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.red,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        item.city,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
