/// Noir memory card motifs. Replace any image in [assetFolder] to swap a pair.
abstract final class MemoryMotifAssets {
  static const folder = 'assets/photos/memory';

  static String pathFor(String fileBase) => '$folder/$fileBase.png';
}

/// Fifty unique motifs — max [pairCount] for hard mode is 18.
enum MemoryMotif {
  fingerabdruck('Fingerabdruck', 'memory_01_fingerabdruck'),
  absperrband('Polizei-Absperrband', 'memory_02_absperrband'),
  lupe('Lupe', 'memory_03_lupe'),
  polizeimarke('Polizeimarke', 'memory_04_polizeimarke'),
  reagenzglas('Reagenzglas', 'memory_05_reagenzglas'),
  handschellen('Handschellen', 'memory_06_handschellen'),
  messer('Tatwaffe', 'memory_07_messer'),
  polaroid('Beweisfoto', 'memory_08_polaroid'),
  schluessel('Schlüssel', 'memory_09_schluessel'),
  dna('DNA-Spur', 'memory_10_dna'),
  handschuh('Handschuh', 'memory_11_handschuh'),
  taschenlampe('Taschenlampe', 'memory_12_taschenlampe'),
  kamera('Überwachung', 'memory_13_kamera'),
  akte('Akte', 'memory_14_akte'),
  kaffee('Ermittler-Kaffee', 'memory_15_kaffee'),
  regen('Nachtregen', 'memory_16_regen'),
  stadtplan('Stadtplan', 'memory_17_stadtplan'),
  notiz('Vernehmung', 'memory_18_notiz'),
  mikrofon('Verhör', 'memory_19_mikrofon'),
  asservat('Asservat', 'memory_20_asservat'),
  blitz('Blitzlicht', 'memory_21_blitz'),
  nebel('Nebel', 'memory_22_nebel'),
  handschrift('Handschrift', 'memory_23_handschrift'),
  maske('Verkleidung', 'memory_24_maske'),
  mikroskop('Mikroskop', 'memory_25_mikroskop'),
  fallakten('Fallakte', 'memory_26_fallakten'),
  stern('Top-Ermittler', 'memory_27_stern'),
  puzzle('Rätsel', 'memory_28_puzzle'),
  fussabdruck('Fußspur', 'memory_29_fussabdruck'),
  fernglas('Fernglas', 'memory_30_fernglas'),
  tresor('Tresor', 'memory_31_tresor'),
  glas('Glassplitter', 'memory_32_glas'),
  kompass('Kompass', 'memory_33_kompass'),
  uhr('Zeugen-Uhr', 'memory_34_uhr'),
  telefon('Forensik-Call', 'memory_35_telefon'),
  streifenwagen('Einsatzfahrzeug', 'memory_36_streifenwagen'),
  hafenlaterne('Hafenlaterne', 'memory_37_hafenlaterne'),
  kugelschreiber('Kugelschreiber', 'memory_38_kugelschreiber'),
  zigarette('Noir-Detail', 'memory_39_zigarette'),
  regenschirm('Regenschirm', 'memory_40_regenschirm'),
  siegel('Beweissiegel', 'memory_41_siegel'),
  zielscheibe('Zielscheibe', 'memory_42_zielscheibe'),
  funkgeraet('Funkgerät', 'memory_43_funkgeraet'),
  blutspur('Spur', 'memory_44_blutspur'),
  kreideumriss('Tatort-Markierung', 'memory_45_kreideumriss'),
  handschuhspur('Handschuhspur', 'memory_46_handschuhspur'),
  strassenlaterne('Straßenlaterne', 'memory_47_strassenlaterne'),
  schneespur('Schneespur', 'memory_48_schneespur'),
  spurfunkBogen('Spurfunk', 'memory_49_spurfunk_bogen'),
  stillerGast('Stiller Gast', 'memory_50_stiller_gast');

  const MemoryMotif(this.label, this.assetFileName);

  final String label;
  final String assetFileName;

  String get assetPath => MemoryMotifAssets.pathFor(assetFileName);
}
