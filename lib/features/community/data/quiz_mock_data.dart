import '../../../shared/models/gamification_models.dart';

const quizStandardQuestionCount = 15;

/// In der UI wählbare Kategorien (je 15 Fragen).
const quizSelectableCategories = [
  QuizCategory.teams,
  QuizCategory.kriminalistik,
  QuizCategory.geschichte,
];

const mockQuizQuestions = [
  QuizQuestion(
    id: 'q-01',
    category: QuizCategory.geschichte,
    question: 'Seit welchem Jahr läuft der Tatort im Ersten?',
    options: ['1965', '1970', '1975', '1980'],
    correctIndex: 1,
    explanation: 'Der erste Tatort wurde am 29. November 1970 ausgestrahlt.',
  ),
  QuizQuestion(
    id: 'q-02',
    category: QuizCategory.folgen,
    question: 'Wie lange dauert eine typische Tatort-Folge?',
    options: ['60 Minuten', '75 Minuten', '90 Minuten', '120 Minuten'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 'q-03',
    category: QuizCategory.teams,
    question: 'In welcher Stadt ermittelt Klaus Borowski?',
    options: ['Hamburg', 'Kiel', 'Münster', 'Wien'],
    correctIndex: 1,
  ),
  QuizQuestion(
    id: 'q-04',
    category: QuizCategory.teams,
    question: 'Wer gehört zum Kieler Borowski-Team?',
    options: ['Mila Sahin', 'Frank Thiel', 'Ivo Batic', 'Bibi Fellner'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-05',
    category: QuizCategory.drehorte,
    question: 'Welche Stadt ist KEIN klassischer Tatort-Drehort?',
    options: ['Köln', 'München', 'Berlin', 'Tokio'],
    correctIndex: 3,
  ),
  QuizQuestion(
    id: 'q-06',
    category: QuizCategory.drehorte,
    question: 'Das Team „Thiel & Boerne“ ermittelt in welcher Stadt?',
    options: ['Kiel', 'Lübeck', 'Münster', 'Bremen'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 'q-07',
    category: QuizCategory.schauspieler,
    question: 'Wer spielt Klaus Borowski?',
    options: ['Axel Milberg', 'Axel Prahl', 'Götz George', 'Ulrich Tukur'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-08',
    category: QuizCategory.schauspieler,
    question: 'Wer verkörpert Prof. Karl-Friedrich Boerne in Münster?',
    options: ['Jan Josef Liefers', 'Axel Prahl', 'Til Schweiger', 'Benno Fürmann'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-09',
    category: QuizCategory.kriminalistik,
    question: 'Was sichert die Spurensicherung typischerweise zuerst?',
    options: [
      'Den Tatort und potenzielle Beweise',
      'Nur die Leiche',
      'Aussagen der Presse',
      'Social-Media-Posts',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-10',
    category: QuizCategory.kriminalistik,
    question: 'Fingerabdrücke werden in der Forensik vor allem genutzt, um …',
    options: [
      'Personen zu identifizieren',
      'Das Wetter zu bestimmen',
      'Die Sendezeit zu ändern',
      'Musik zu analysieren',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-11',
    category: QuizCategory.allgemein,
    question: 'Auf welchem Sender läuft der Tatort primär?',
    options: ['Das Erste', 'ZDF', 'RTL', 'ProSieben'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-12',
    category: QuizCategory.allgemein,
    question: 'Wann startet der Tatort traditionell?',
    options: [
      'Sonntag, 20:15 Uhr',
      'Samstag, 22:00 Uhr',
      'Freitag, 21:45 Uhr',
      'Montag, 19:30 Uhr',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-13',
    category: QuizCategory.folgen,
    question: 'Was kennzeichnet viele Tatort-Folgen stilistisch?',
    options: [
      'Regionale Atmosphäre und lokale Milieus',
      'Nur Science-Fiction-Elemente',
      'Ausschließlich Animationsfilm',
      'Reine Dokumentation ohne Dialog',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-14',
    category: QuizCategory.geschichte,
    question: 'Wie viele Folgen wurden seit 1970 ungefähr produziert?',
    options: ['Über 500', 'Über 800', 'Über 1.200', 'Über 2.500'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 'q-15',
    category: QuizCategory.teams,
    question: 'Welches Team ermittelt in Wien?',
    options: [
      'Eisner & Fellner',
      'Ballauf & Schenk',
      'Borowski & Sahin',
      'Thiel & Boerne',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-16',
    category: QuizCategory.drehorte,
    question: 'Der Tatort wird auch in welchem Nachbarland gedreht?',
    options: ['Österreich', 'Frankreich', 'Spanien', 'Polen'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-17',
    category: QuizCategory.kriminalistik,
    question: 'DNA-Analysen helfen vor allem bei …',
    options: [
      'der biologischen Zuordnung von Spuren',
      'der Wettervorhersage',
      'der Buchhaltung',
      'der Kameraführung',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-18',
    category: QuizCategory.schauspieler,
    question: 'Götz George wurde als welcher Ermittler weltberühmt?',
    options: ['Horst Schimanski', 'Klaus Borowski', 'Thiel', 'Ballauf'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-19',
    category: QuizCategory.folgen,
    question: 'Was ist bei Spurfunk während einer Live-Folge besonders?',
    options: [
      'Gemeinsames Mitraten und Abstimmen',
      'Nur passive Wiedergabe ohne Interaktion',
      'Ausschließlich Werbung',
      'Kein Community-Bezug',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-20',
    category: QuizCategory.allgemein,
    question: 'Wie nennt Spurfunk die Community während einer Sendung?',
    options: ['Mitwisser:innen', 'Zuschauer:innen Plus', 'Krimi-Club', 'Detektiv-Union'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-21',
    category: QuizCategory.geschichte,
    question: 'Der Tatort gilt als eines der wichtigsten deutschen …',
    options: ['Krimiformate', 'Kochshows', 'Reality-Formate', 'Sportmagazine'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-22',
    category: QuizCategory.teams,
    question: 'Ballauf und Schenk ermitteln in …',
    options: ['Köln', 'Stuttgart', 'Frankfurt', 'Leipzig'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-23',
    category: QuizCategory.kriminalistik,
    question: 'Eine Spurenkette beschreibt …',
    options: [
      'die logische Abfolge gesicherter Beweise',
      'die Reihenfolge der Schauspieler:innen',
      'die Playlist der Folge',
      'die Drehpause',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-24',
    category: QuizCategory.drehorte,
    question: 'Welche Stadt hat ein Team mit dem Namen „Lannert & Bootz“?',
    options: ['Stuttgart', 'Kiel', 'Zürich', 'Graz'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q-25',
    category: QuizCategory.allgemein,
    question: 'Nach einer Live-Abstimmung bei Spurfunk siehst du …',
    options: [
      'aggregierte Community-Ergebnisse',
      'nur deine eigene Stimme ohne Kontext',
      'keine Statistiken',
      'ausschließlich Werbung',
    ],
    correctIndex: 0,
  ),
  // —— Geschichte (15) ——
  QuizQuestion(
    id: 'g-04',
    category: QuizCategory.geschichte,
    question: 'Wer entwickelte den Tatort ursprünglich als Sonntagskrimi?',
    options: ['Günter Peter Straschek', 'Tom Cruise', 'Agatha Christie', 'RTL'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-05',
    category: QuizCategory.geschichte,
    question: 'In welchem Jahrzehnt startete der Tatort?',
    options: ['1960er', '1980er', '1990er', '2000er'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-06',
    category: QuizCategory.geschichte,
    question: 'Der Tatort gilt als Pionier für …',
    options: [
      'regionale Krimireihen im öffentlich-rechtlichen Fernsehen',
      'reine Comedy-Sendungen',
      'Tageschatshows',
      'Sportübertragungen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-07',
    category: QuizCategory.geschichte,
    question: 'Wie heißt die längste laufende deutsche Krimireihe im Ersten?',
    options: ['Tatort', 'Derrick', 'Der Alte', 'Hubert ohne Staller'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-08',
    category: QuizCategory.geschichte,
    question: 'Wann wurde der erste Tatort ausgestrahlt?',
    options: ['29. November 1970', '1. Januar 1960', '15. August 1985', '3. März 1999'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-09',
    category: QuizCategory.geschichte,
    question: 'Welches Motto passt zur langen Geschichte des Tatort?',
    options: [
      'Viele Städte, viele Teams, ein Sonntagabend',
      'Nur eine Stadt, ein Team',
      'Nur internationale Produktionen',
      'Keine Wiederholungen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-10',
    category: QuizCategory.geschichte,
    question: 'Der Tatort wurde über die Jahrzehnte vor allem durch … bekannt.',
    options: [
      'wechselnde regionale Teams und Ermittler:innen',
      'ein einziges festes Studio-Set',
      'ausschließlich Animation',
      'reine Dokumentation',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-11',
    category: QuizCategory.geschichte,
    question: 'Horst Schimanski aus Duisburg wurde in den 1980ern zu …',
    options: [
      'einer der bekanntesten Tatort-Figuren',
      'einem Science-Fiction-Held',
      'einem Kochshow-Moderator',
      'einem Wetterbericht-Team',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-12',
    category: QuizCategory.geschichte,
    question: 'Der Tatort wird heute in wie vielen Ländern gedreht?',
    options: ['3 (D, A, CH)', '1', '10', '20'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-13',
    category: QuizCategory.geschichte,
    question: 'Was macht den Tatort historisch besonders in Deutschland?',
    options: [
      'Er prägte das Sonntagsfernsehen über Generationen',
      'Er war die erste Reality-Show',
      'Er lief nur einmal',
      'Er hatte keine Ermittler:innen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-14',
    category: QuizCategory.geschichte,
    question: 'Welche Aussage zur Produktionsgeschichte stimmt?',
    options: [
      'Jedes Team hat oft eine eigene regionale Identität',
      'Alle Folgen spielen in Berlin',
      'Es gibt nur ein Drehteam weltweit',
      'Es gibt keine Wiederholungen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'g-15',
    category: QuizCategory.geschichte,
    question: 'Der Tatort ist ein Gemeinschaftsprojekt von …',
    options: [
      'ARD-Mitgliedssendern',
      'nur einem Privatsender',
      'nur Streaming-Diensten',
      'nur internationalen Studios',
    ],
    correctIndex: 0,
  ),
  // —— Teams (15) ——
  QuizQuestion(
    id: 't-05',
    category: QuizCategory.teams,
    question: 'Wer gehört zum Team Münster?',
    options: ['Thiel & Boerne', 'Borowski & Brandt', 'Falke & Grosz', 'Eisner & Fellner'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-06',
    category: QuizCategory.teams,
    question: 'In welcher Stadt ermitteln Thiel und Boerne?',
    options: ['Hamburg', 'Kiel', 'Münster', 'Wien'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 't-07',
    category: QuizCategory.teams,
    question: 'Welches Team ist mit Köln verbunden?',
    options: ['Ballauf & Schenk', 'Borowski & Sahin', 'Lannert & Bootz', 'Fellner & Nowak'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-08',
    category: QuizCategory.teams,
    question: 'Borowskis Kollege Sahin ist Teil des Teams in …',
    options: ['Kiel', 'München', 'Stuttgart', 'Graz'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-09',
    category: QuizCategory.teams,
    question: 'Eisner und Fellner ermitteln in …',
    options: ['Wien', 'Hamburg', 'Köln', 'Lübeck'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-10',
    category: QuizCategory.teams,
    question: 'Lannert und Bootz sind ein Team aus …',
    options: ['Stuttgart', 'Kiel', 'Zürich', 'Berlin'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-11',
    category: QuizCategory.teams,
    question: 'Welches Team ist typisch für Schleswig-Holstein?',
    options: ['Borowski-Team Kiel', 'Ballauf-Team Köln', 'Moser-Team München', 'Stiel-Team Berlin'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-12',
    category: QuizCategory.teams,
    question: 'Prof. Boerne arbeitet als …',
    options: ['Pathologe', 'Feuerwehrmann', 'Koch', 'Pilot'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-13',
    category: QuizCategory.teams,
    question: 'Welche Kombination passt?',
    options: [
      'Team Hamburg – Falke & Grosz',
      'Team Hamburg – Borowski & Sahin',
      'Team Kiel – Ballauf & Schenk',
      'Team Wien – Thiel & Boerne',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-14',
    category: QuizCategory.teams,
    question: 'Tatort-Teams sind meist an … gebunden.',
    options: ['eine Stadt oder Region', 'ein einziges Hotel', 'ein Land ohne Orte', 'nur das Studio'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-15',
    category: QuizCategory.teams,
    question: 'Borowski ist bekannt für Ermittlungen in …',
    options: ['Kiel und Umgebung', 'nur Wien', 'nur Zürich', 'nur München'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 't-16',
    category: QuizCategory.teams,
    question: 'Welches Team ist nicht aus Deutschland?',
    options: ['Eisner & Fellner (Wien)', 'Ballauf & Schenk', 'Borowski & Brandt', 'Thiel & Boerne'],
    correctIndex: 0,
  ),
  // —— Kriminalistik (15) ——
  QuizQuestion(
    id: 'k-05',
    category: QuizCategory.kriminalistik,
    question: 'Was ist ein Asservat?',
    options: [
      'Sicher gestellter Beweisgegenstand',
      'Ein Filmvertrag',
      'Ein Wetterbericht',
      'Ein Rezept',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-06',
    category: QuizCategory.kriminalistik,
    question: 'Wozu dient eine forensische Autopsie?',
    options: [
      'Todesursache und Spuren am Körper klären',
      'Sendezeit festlegen',
      'Drehbuch schreiben',
      'Musik auswählen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-07',
    category: QuizCategory.kriminalistik,
    question: 'Blutspuren am Tatort werden oft …',
    options: [
      'dokumentiert und forensisch gesichert',
      'sofort entfernt',
      'ignoriert',
      'nur fotografiert ohne Protokoll',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-08',
    category: QuizCategory.kriminalistik,
    question: 'Ein Täterprofil hilft dabei …',
    options: [
      'Verhalten und Hintergrund einzugrenzen',
      'das Wetter vorherzusagen',
      'Musik zu komponieren',
      'Schauspieler zu casten',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-09',
    category: QuizCategory.kriminalistik,
    question: 'Was bedeutet „Spurensicherung“?',
    options: [
      'Beweise systematisch sichern und dokumentieren',
      'Nur Zeugen befragen',
      'Nur Presse informieren',
      'Tatort sofort räumen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-10',
    category: QuizCategory.kriminalistik,
    question: 'Faser- und Haarspuren können …',
    options: [
      'Hinweise auf Kontakt oder Herkunft geben',
      'nur die Uhrzeit zeigen',
      'keine Rolle spielen',
      'nur Farben bestimmen',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-11',
    category: QuizCategory.kriminalistik,
    question: 'Eine Vernehmung ist …',
    options: [
      'das strukturierte Befragen von Zeugen oder Verdächtigen',
      'ein Filmdreh',
      'ein Wettercheck',
      'ein Autokauf',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-12',
    category: QuizCategory.kriminalistik,
    question: 'Digitale Forensik untersucht vor allem …',
    options: [
      'Handys, Computer und elektronische Spuren',
      'nur Papierbriefe',
      'nur Tierfutter',
      'nur Baumaterial',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-13',
    category: QuizCategory.kriminalistik,
    question: 'Ein Protokoll am Tatort dient …',
    options: [
      'der lückenlosen Dokumentation für die Ermittlung',
      'nur der Unterhaltung',
      'der Werbung',
      'dem Verkauf von Tickets',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-14',
    category: QuizCategory.kriminalistik,
    question: 'Ballistische Untersuchungen betreffen oft …',
    options: ['Schusswaffen und Projektile', 'Kochrezepte', 'Musik', 'Wetter'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'k-15',
    category: QuizCategory.kriminalistik,
    question: 'Warum wird ein Tatort oft abgesperrt?',
    options: [
      'Um Beweise zu schützen und Kontamination zu vermeiden',
      'Um Touristen anzulocken',
      'Um zu feiern',
      'Um zu drehen ohne Genehmigung',
    ],
    correctIndex: 0,
  ),
];

List<QuizQuestion> buildQuizSession({QuizCategory? category}) {
  if (category == null) {
    final pool = List<QuizQuestion>.from(mockQuizQuestions)..shuffle();
    return pool.take(quizStandardQuestionCount).toList();
  }

  final pool =
      mockQuizQuestions.where((question) => question.category == category).toList()
        ..shuffle();
  return pool.take(quizStandardQuestionCount).toList();
}

int calculateQuizXp(int correctCount, int totalQuestions) {
  final base = correctCount * 12;
  final bonus = correctCount == totalQuestions ? 40 : 0;
  final streakBonus = correctCount >= (totalQuestions * 0.8).ceil() ? 20 : 0;
  return base + bonus + streakBonus;
}
