import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../onboarding/application/onboarding_state.dart';
import '../../../onboarding/presentation/widgets/onboarding_widgets.dart';

Future<void> showProfileAvatarPicker({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.45,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Consumer(
            builder: (context, ref, _) {
              final selectedId = ref.watch(selectedAvatarIdProvider);

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'IDENTITÄT WECHSELN',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          fontSize: 22,
                          color: AppColors.textPrimary,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Wähle ein neues Tatort-Avatar-Motiv.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          clipBehavior: Clip.none,
                          itemCount: avatarPresets.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 14,
                            childAspectRatio: AvatarCaseCard.gridAspectRatio,
                          ),
                          itemBuilder: (context, index) {
                            final avatar = avatarPresets[index];
                            return Padding(
                              padding: const EdgeInsets.all(2),
                              child: AvatarCaseCard(
                                avatar: avatar,
                                selected: avatar.id == selectedId,
                                onTap: () async {
                                  await ref
                                      .read(selectedAvatarIdProvider.notifier)
                                      .select(avatar.id);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
