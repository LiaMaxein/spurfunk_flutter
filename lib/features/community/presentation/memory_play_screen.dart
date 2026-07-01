import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../shared/models/gamification_models.dart';
import '../data/memory_mock_data.dart';
import 'widgets/gamification_replay_dialogs.dart';

const _communityMemoryPath = '/community?tab=memory';

class MemoryPlayScreen extends StatefulWidget {
  const MemoryPlayScreen({required this.difficulty, super.key});

  final MemoryDifficulty difficulty;

  @override
  State<MemoryPlayScreen> createState() => _MemoryPlayScreenState();
}

class _MemoryPlayScreenState extends State<MemoryPlayScreen> {
  late final List<_MemoryCard> _cards;
  late final DateTime _startedAt;
  late final Timer _timer;

  int? _firstIndex;
  int _moves = 0;
  bool _busy = false;
  MemorySessionResult? _result;

  @override
  void initState() {
    super.initState();
    _cards = _buildDeck(widget.difficulty);
    _startedAt = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _result == null) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<_MemoryCard> _buildDeck(MemoryDifficulty difficulty) {
    final motifs = motifsForDifficulty(difficulty);
    final pairs = <_MemoryCard>[];
    for (var i = 0; i < motifs.length; i++) {
      pairs.add(_MemoryCard(motif: motifs[i], pairId: i));
      pairs.add(_MemoryCard(motif: motifs[i], pairId: i));
    }
    pairs.shuffle();

    final blankIndex = difficulty.blankSlotIndex;
    if (blankIndex == null) return pairs;

    final slots = List<_MemoryCard>.filled(
      difficulty.totalSlots,
      _MemoryCard.blank(),
    );
    var pairIndex = 0;
    for (var slot = 0; slot < difficulty.totalSlots; slot++) {
      if (slot == blankIndex) continue;
      slots[slot] = pairs[pairIndex++];
    }
    return slots;
  }

  int get _matchedPairs =>
      _cards.where((card) => card.isMatched).length ~/ 2;

  Duration get _elapsed => DateTime.now().difference(_startedAt);

  Future<void> _onCardTap(int index) async {
    if (_busy || _result != null) return;
    final card = _cards[index];
    if (card.isBlank || card.isMatched || card.isFaceUp) return;

    setState(() => card.isFaceUp = true);

    if (_firstIndex == null) {
      setState(() => _firstIndex = index);
      return;
    }

    if (_firstIndex == index) return;

    setState(() {
      _moves++;
      _busy = true;
    });

    final first = _cards[_firstIndex!];
    final second = _cards[index];
    final isMatch = first.pairId == second.pairId;

    await Future<void>.delayed(const Duration(milliseconds: 650));

    if (!mounted) return;

    if (isMatch) {
      setState(() {
        first.isMatched = true;
        second.isMatched = true;
        _firstIndex = null;
        _busy = false;
      });
      if (_matchedPairs == widget.difficulty.pairCount) {
        await _completeGame();
      }
    } else {
      setState(() {
        first.isFaceUp = false;
        second.isFaceUp = false;
        _firstIndex = null;
        _busy = false;
      });
    }
  }

  Future<void> _completeGame() async {
    final duration = _elapsed;
    final score = calculateMemoryScore(
      difficulty: widget.difficulty,
      moves: _moves,
      duration: duration,
    );
    final xp = calculateMemoryXp(score);
    final prefs = await SharedPreferences.getInstance();
    final key = 'memory_best_${widget.difficulty.id}';
    final previousBest = prefs.getInt(key) ?? 0;
    final isBest = score > previousBest;
    if (isBest) {
      await prefs.setInt(key, score);
    }

    setState(() {
      _result = MemorySessionResult(
        difficulty: widget.difficulty,
        moves: _moves,
        duration: duration,
        xpEarned: xp,
        score: score,
        isPersonalBest: isBest,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _result != null,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _confirmExit(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: _result != null ? _buildResult(context) : _buildGame(context),
        ),
      ),
    );
  }

  Widget _buildGame(BuildContext context) {
    final difficulty = widget.difficulty;
    final totalCells = difficulty.columns * difficulty.rows;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Text(
                  'MEMORY · ${difficulty.label.toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          Row(
            children: [
              _StatPill(
                icon: Icons.touch_app_outlined,
                label: 'Züge',
                value: '$_moves',
              ),
              const SizedBox(width: 8),
              _StatPill(
                icon: Icons.timer_outlined,
                label: 'Zeit',
                value: _formatDuration(_elapsed),
              ),
              const SizedBox(width: 8),
              _StatPill(
                icon: Icons.grid_view_rounded,
                label: 'Paare',
                value: '$_matchedPairs/${difficulty.pairCount}',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final spacing = switch (difficulty.columns) {
                  >= 6 => 4.0,
                  >= 5 => 5.0,
                  _ => 6.0,
                };
                final cellWidth =
                    (constraints.maxWidth - spacing * (difficulty.columns - 1)) /
                    difficulty.columns;
                final imageInset = memoryImageInsetForCell(cellWidth);
                final gridHeight =
                    cellWidth * difficulty.rows +
                    spacing * (difficulty.rows - 1);

                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: gridHeight.clamp(0, constraints.maxHeight),
                    width: constraints.maxWidth,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: difficulty.columns,
                        crossAxisSpacing: spacing,
                        mainAxisSpacing: spacing,
                        childAspectRatio: 1,
                      ),
                      itemCount: totalCells,
                      itemBuilder: (context, index) {
                        final card = _cards[index];
                        return _MemoryTile(
                          card: card,
                          imageInset: imageInset,
                          onTap: () => _onCardTap(index),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    final result = _result!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Text(
                  'ERGEBNIS',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const Spacer(),
          if (result.isPersonalBest)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.green.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'NEUE BESTLEISTUNG',
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            '${result.score}',
            style: GoogleFonts.bebasNeue(
              fontSize: 72,
              color: AppColors.red,
              height: 1,
            ),
          ),
          Text(
            'Punkte',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                _ResultRow(label: 'Schwierigkeit', value: result.difficulty.label),
                const Divider(height: 20, color: AppColors.divider),
                _ResultRow(label: 'Züge', value: '${result.moves}'),
                const Divider(height: 20, color: AppColors.divider),
                _ResultRow(label: 'Zeit', value: _formatDuration(result.duration)),
                const Divider(height: 20, color: AppColors.divider),
                _ResultRow(label: 'XP', value: '+${result.xpEarned}'),
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Nochmal spielen',
            onPressed: () async {
              final choice = await showMemoryReplayDialog(
                context,
                initialDifficulty: result.difficulty,
              );
              if (!context.mounted || choice.cancelled || choice.difficulty == null) {
                return;
              }
              context.replace(memoryPlayPath(choice.difficulty!));
            },
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'Zurück zur Community',
            onPressed: () => context.go(_communityMemoryPath),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Memory beenden?'),
        content: const Text('Dein aktueller Spielstand geht verloren.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Weiterspielen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) context.go(_communityMemoryPath);
  }

  String _formatDuration(Duration duration) {
    final m = duration.inMinutes;
    final s = duration.inSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

class _MemoryCard {
  _MemoryCard({required this.motif, required this.pairId}) : isBlank = false;

  _MemoryCard.blank()
      : motif = MemoryMotif.fingerabdruck,
        pairId = -1,
        isBlank = true;

  final MemoryMotif motif;
  final int pairId;
  final bool isBlank;
  bool isFaceUp = false;
  bool isMatched = false;
}

class _MemoryTile extends StatelessWidget {
  const _MemoryTile({
    required this.card,
    required this.imageInset,
    required this.onTap,
  });

  final _MemoryCard card;
  final double imageInset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (card.isBlank) {
      return const SizedBox.shrink();
    }

    final faceUp = card.isFaceUp || card.isMatched;
    final motif = card.motif;

    return Semantics(
      label: faceUp ? motif.label : 'Verdeckte Memory-Karte',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: faceUp ? AppColors.surfaceHigh : AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: card.isMatched
                    ? AppColors.green.withValues(alpha: 0.6)
                    : faceUp
                    ? AppColors.red.withValues(alpha: 0.5)
                    : AppColors.divider,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: faceUp
                ? Padding(
                    padding: EdgeInsets.all(imageInset),
                    child: SizedBox.expand(
                      child: Image.asset(
                        motif.assetPath,
                        fit: BoxFit.cover,
                        semanticLabel: motif.label,
                        gaplessPlayback: true,
                        errorBuilder: (_, _, _) => Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.textMuted,
                          size: 24 + imageInset,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.fingerprint,
                      color: AppColors.textMuted.withValues(alpha: 0.5),
                      size: 20 + imageInset,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.red),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 9,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
