import 'dart:math';

import '../../../shared/models/gamification_models.dart';

const memoryDifficulties = [
  MemoryDifficulty(
    id: 'easy',
    label: 'Leicht',
    columns: 4,
    rows: 4,
    xpMultiplier: 1.0,
  ),
  MemoryDifficulty(
    id: 'medium',
    label: 'Mittel',
    columns: 5,
    rows: 5,
    xpMultiplier: 1.6,
    blankSlotIndex: 12,
  ),
  MemoryDifficulty(
    id: 'hard',
    label: 'Schwer',
    columns: 6,
    rows: 6,
    xpMultiplier: 2.4,
  ),
];

List<MemoryMotif> motifsForDifficulty(MemoryDifficulty difficulty) {
  final motifs = List<MemoryMotif>.from(MemoryMotif.values);
  motifs.shuffle(Random());
  return motifs.take(difficulty.pairCount).toList();
}

int calculateMemoryScore({
  required MemoryDifficulty difficulty,
  required int moves,
  required Duration duration,
}) {
  final parMoves = difficulty.pairCount * 2;
  final moveScore = max(0, (parMoves * 3) - moves) * 4;
  final timeScore = max(0, 300 - duration.inSeconds);
  return ((moveScore + timeScore) * difficulty.xpMultiplier).round();
}

int calculateMemoryXp(int score) => max(15, score ~/ 3);

/// Inset around motif image inside a memory cell.
double memoryImageInsetForCell(double cellSize) =>
    (cellSize * 0.08).clamp(3.0, 8.0);
