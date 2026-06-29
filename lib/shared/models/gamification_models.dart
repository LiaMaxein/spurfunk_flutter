enum QuizCategory {
  folgen('Folgen'),
  teams('Teams & Ermittler'),
  drehorte('Drehorte'),
  schauspieler('Schauspieler:innen'),
  kriminalistik('Kriminalistik'),
  geschichte('Geschichte'),
  allgemein('Allgemeinwissen');

  const QuizCategory(this.label);

  final String label;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });

  final String id;
  final QuizCategory category;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
}

class QuizSessionResult {
  const QuizSessionResult({
    required this.totalQuestions,
    required this.correctCount,
    required this.xpEarned,
    required this.duration,
    this.category,
  });

  final int totalQuestions;
  final int correctCount;
  final int xpEarned;
  final Duration duration;
  final QuizCategory? category;

  double get accuracy =>
      totalQuestions == 0 ? 0 : correctCount / totalQuestions;
}

enum MemoryMotif {
  fingerprint('Fingerabdruck', '👆'),
  tatort('Tatort', '🏙️'),
  ermittler('Ermittler:in', '👮'),
  marke('Polizeimarke', '🪪'),
  spuren('Spurensicherung', '🔍'),
  beweis('Beweismittel', '🧪'),
  team('Team', '👥'),
  akte('Akte', '📁'),
  kamera('Überwachung', '📹'),
  dna('DNA-Spur', '🧬'),
  handschuh('Handschuh', '🧤'),
  messer('Tatwaffe', '🔪'),
  uhr('Zeugen-Uhr', '⌚'),
  telefon('Forensik-Call', '📞'),
  schluessel('Schlüssel', '🔑'),
  foto('Beweisfoto', '📸'),
  auto('Einsatzfahrzeug', '🚓'),
  kaffee('Ermittler-Kaffee', '☕'),
  regen('Nachtregen', '🌧️'),
  lampe('Beweislicht', '🔦'),
  karte('Stadtplan', '🗺️'),
  notiz('Vernehmung', '📝'),
  siegel('Beweissiegel', '🔒'),
  mikro('Verhör', '🎙️'),
  tasche('Asservat', '💼'),
  blitz('Blitzlicht', '⚡'),
  rauch('Nebel', '🌫️'),
  hand('Handschriften', '✍️'),
  ziel('Zielscheibe', '🎯'),
  maske('Verkleidung', '🎭'),
  glas('Labor-Glas', '🔬'),
  buch('Fallakte', '📚'),
  stern('Top-Ermittler', '⭐'),
  warnung('Spoiler-Warnung', '⚠️'),
  puzzle('Rätsel', '🧩'),
  funke('Spur-Funke', '✨');

  const MemoryMotif(this.label, this.emoji);

  final String label;
  final String emoji;
}

class MemoryDifficulty {
  const MemoryDifficulty({
    required this.id,
    required this.label,
    required this.columns,
    required this.rows,
    required this.xpMultiplier,
    this.blankSlotIndex,
  });

  final String id;
  final String label;
  final int columns;
  final int rows;
  final double xpMultiplier;
  /// Leeres Feld bei ungerader Rastergröße (z. B. 5×5, 7×7).
  final int? blankSlotIndex;

  int get totalSlots => columns * rows;

  int get pairCount {
    final playable = blankSlotIndex == null ? totalSlots : totalSlots - 1;
    return playable ~/ 2;
  }

  String get gridLabel => '$columns×$rows';
}

class MemorySessionResult {
  const MemorySessionResult({
    required this.difficulty,
    required this.moves,
    required this.duration,
    required this.xpEarned,
    required this.score,
    this.isPersonalBest = false,
  });

  final MemoryDifficulty difficulty;
  final int moves;
  final Duration duration;
  final int xpEarned;
  final int score;
  final bool isPersonalBest;
}
