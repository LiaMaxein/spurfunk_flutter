import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../../core/widgets/spurfunk_branding_widgets.dart';
import '../application/onboarding_state.dart';
import 'widgets/onboarding_widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  final _usernameController = TextEditingController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    final savedUsername = ref.read(usernameProvider);
    if (savedUsername.isNotEmpty) {
      _usernameController.text = savedUsername;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 460),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => _page = value),
              children: [
                _IntroStep(onContinue: _next),
                _AvatarStep(onContinue: _next),
                _GenderStep(onContinue: _next),
                _UsernameStep(
                  controller: _usernameController,
                  onContinue: _next,
                ),
                _CompletionStep(
                  onEnterApp: () => _finishOnboarding(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          OnboardingStepDots(index: _page),
        ],
      ),
    );
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      await ref.read(usernameProvider.notifier).update(username);
    }
    await ref.read(onboardingCompletedProvider.notifier).complete();
    if (!context.mounted) return;
    context.go(AppRoutes.home.path);
  }
}

class _IntroStep extends StatelessWidget {
  const _IntroStep({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageBody(
      child: AnimatedOnboardingStep(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OnboardingBrand(large: true),
            const SizedBox(height: 28),
            Text(
              'Gemeinsam schauen.\nGemeinsam rätseln.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              'Deine App für den Sonntagabend-Kultkrimi: Sei live dabei, rede und rätsel mit.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 34),
            GlassCard(
              child: Row(
                children: [
                  const Icon(Icons.visibility_rounded, color: AppColors.redSoft),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Wähle eine Ermittler-Identität und bleibe dabei so anonym, wie du möchtest.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            NoirButton(label: 'Los geht’s', onPressed: onContinue),
          ],
        ),
      ),
    );
  }
}

class _AvatarStep extends ConsumerWidget {
  const _AvatarStep({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedAvatarIdProvider);

    return AnimatedOnboardingStep(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingBrand(),
          const SizedBox(height: 24),
          Text(
            'Wähle deine Tatort-Identität',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Stilisierte Avatare im Noir-Look – anonym, verspielt und bereit für den Live-Fall.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 22),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: avatarPresets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: AvatarCaseCard.gridAspectRatio,
              ),
              itemBuilder: (context, index) {
                final avatar = avatarPresets[index];
                return AvatarCaseCard(
                  avatar: avatar,
                  selected: avatar.id == selectedId,
                  onTap: () => ref
                      .read(selectedAvatarIdProvider.notifier)
                      .select(avatar.id),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          NoirButton(label: 'Weiter', onPressed: onContinue),
        ],
      ),
    );
  }
}

class _GenderStep extends ConsumerWidget {
  const _GenderStep({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(profileGenderProvider);

    return OnboardingPageBody(
      child: AnimatedOnboardingStep(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OnboardingBrand(),
            const SizedBox(height: 28),
            Text(
              'Wie möchtest du angegeben werden?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Diese Angabe hilft uns bei Statistiken und personalisierten Inhalten. Du kannst sie später ändern.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            for (final gender in ProfileGender.values) ...[
              GenderOptionCard(
                gender: gender,
                selected: selected == gender,
                onTap: () =>
                    ref.read(profileGenderProvider.notifier).select(gender),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 20),
            NoirButton(
              label: 'Weiter',
              onPressed: selected == null ? null : onContinue,
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameStep extends ConsumerWidget {
  const _UsernameStep({required this.controller, required this.onContinue});

  final TextEditingController controller;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anonymous = ref.watch(anonymousModeProvider);

    return OnboardingPageBody(
      child: AnimatedOnboardingStep(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OnboardingBrand(),
            const SizedBox(height: 28),
            Text(
              'Wie sollen wir dich nennen?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Du kannst mit einem Alias auftreten oder vollständig anonym an Abstimmungen und Kommentaren teilnehmen.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 26),
            TextField(
              controller: controller,
              enabled: !anonymous,
              onChanged: (value) =>
                  ref.read(usernameProvider.notifier).update(value),
              decoration: InputDecoration(
                hintText: 'z. B. KrimiFan83',
                filled: true,
                fillColor: AppColors.surfaceHigh.withValues(alpha: 0.78),
                prefixIcon: const Icon(Icons.badge_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.redSoft,
                    width: 1.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SwitchListTile.adaptive(
                value: anonymous,
                onChanged: (value) => ref
                    .read(anonymousModeProvider.notifier)
                    .setEnabled(value: value),
                contentPadding: EdgeInsets.zero,
                activeThumbColor: AppColors.redSoft,
                title: Text(
                  'Anonym teilnehmen',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Wir zeigen dich als TatortFan_22.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 28),
            NoirButton(label: 'Weiter', onPressed: onContinue),
          ],
        ),
      ),
    );
  }
}

class _CompletionStep extends ConsumerStatefulWidget {
  const _CompletionStep({required this.onEnterApp});

  final Future<void> Function() onEnterApp;

  @override
  ConsumerState<_CompletionStep> createState() => _CompletionStepState();
}

class _CompletionStepState extends ConsumerState<_CompletionStep> {
  bool _isLoading = false;

  Future<void> _enterApp() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 380));
    await widget.onEnterApp();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(selectedAvatarProvider);
    final displayName = ref.watch(displayNameProvider);

    return OnboardingPageBody(
      child: AnimatedOnboardingStep(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.92, end: 1),
              duration: const Duration(milliseconds: 520),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: SpurfunkAvatar(
                assetPath: avatar.assetPath,
                size: 136,
                padding: 16,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Willkommen, $displayName',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Deine Identität „${avatar.name}“ ist bereit. Der nächste Fall wartet bereits im Live-Erlebnis.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            GlassCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.local_police_outlined,
                    color: AppColors.redSoft,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Deine Einstellungen werden lokal gespeichert – Backend-Anbindung folgt später.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            NoirButton(
              label: _isLoading ? 'Wird gestartet …' : 'Spurfunk starten!',
              icon: _isLoading ? null : Icons.play_arrow_rounded,
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _enterApp,
            ),
          ],
        ),
      ),
    );
  }
}
