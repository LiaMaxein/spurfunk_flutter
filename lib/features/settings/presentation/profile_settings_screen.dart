import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding/application/onboarding_state.dart';
import '../../profile/presentation/widgets/profile_avatar_picker_sheet.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/spurfunk_branding_widgets.dart';
import 'widgets/settings_widgets.dart';

class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: ref.read(usernameProvider),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(selectedAvatarProvider);
    final anonymous = ref.watch(anonymousModeProvider);
    final gender = ref.watch(profileGenderProvider);

    return SettingsScaffold(
      title: 'PROFIL & IDENTITÄT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => showProfileAvatarPicker(
                    context: context,
                    ref: ref,
                  ),
                  child: SpurfunkAvatar(
                    assetPath: avatar.assetPath,
                    size: 72,
                    padding: 8,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        avatar.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        avatar.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tippe auf das Bild, um die Identität zu wechseln.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _usernameController,
            enabled: !anonymous,
            onChanged: (value) =>
                ref.read(usernameProvider.notifier).update(value),
            decoration: const InputDecoration(
              labelText: 'Alias',
              hintText: 'z. B. KrimiFan83',
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: anonymous,
                onChanged: (value) => ref
                    .read(anonymousModeProvider.notifier)
                    .setEnabled(value: value),
                title: const Text('Anonym teilnehmen'),
                subtitle: const Text('Zeigt dich als Mitwisser.'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Geschlecht', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          for (final option in ProfileGender.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                onTap: () =>
                    ref.read(profileGenderProvider.notifier).select(option),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(option.icon, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Expanded(child: Text(option.label)),
                    if (gender == option)
                      Icon(Icons.check_circle, color: AppColors.red),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
