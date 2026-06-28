# 12 – UI Components

## Header

### Verwendung

- Home,
- Community,
- Fakten,
- Profil,
- Tablet-Dashboard.

### Inhalte

- Spurfunk-Logo oder Screen-Titel.
- Optional Benachrichtigungsglocke.
- Optional Suche.
- Optional Avatar/Profilzugang.

## Tab-Bar

### Verhalten

- Fünf Icons ohne Schriftzug.
- Bleibt auf Hauptscreens sichtbar.
- Aktiver Tab rot.
- Roter Indikator am unteren Rand.

### Tabs

- Home.
- Community.
- Live.
- Fakten.
- Profil.

## Avatar-Karte

### Zweck

Symbolische Identität ohne echtes Profilfoto.

### Darstellung

- Runde Form.
- Dunkle, matte Farbpalette.
- Dezenter Rahmen.
- Keine identifizierbaren Gesichter.
- Selected State: roter Rahmen + Check.

## Voting-Komponente

### Elemente

- Frage: z. B. „Wie findest du den heutigen Fall?“
- Fünf Emoji-Optionen.
- Label unter jedem Emoji.
- Anzeige der Stimmenanzahl.
- Balkendiagramm mit Prozentwerten.

### Optionen

- 😡 Schlecht
- 🙁 Langweilig
- 😐 Okay
- 🙂 Gut
- 😍 Mega

## Live-Badge

### Darstellung

- Rote Pill / Badge.
- Text „LIVE“.
- Optional pulsierende Animation.
- Nie länger als nötig animieren.

## Countdown-Karte

### Verwendung

- Home Kein Live.
- Live Nicht-Live-Modus.
- Tablet-Dashboard.

### Inhalte

- Titel der nächsten Folge.
- Sender.
- Datum und Uhrzeit.
- Tage / Stunden / Minuten / Sekunden.

## Chat Message Bubble

### Inhalte

- Avatar.
- Alias.
- Uhrzeit.
- Nachricht.

### Regeln

- Chronologisch.
- Gute Lesbarkeit.
- Keine übergroßen Bubbles.
- Moderierte/gelöschte Inhalte klar kennzeichnen.

## Emoji Reaction Overlay

### Verhalten

- Emojis steigen rechts im Chat nach oben.
- Reaktion ist flüchtig.
- Animation ca. 250–300 ms Einstieg, danach sanftes Aufsteigen/Faden.
- Muss bei reduzierten Animationen deaktivierbar sein.

## News Card

### Inhalte

- Kategorie.
- Titel.
- Teaser.
- Datum.
- Optional Bild.

## Statistik-Balken

### Inhalte

- Emoji + Label.
- Prozentwert.
- Stimmenanzahl.
- farbiger Balken.

## Quiz Card

### Inhalte

- Kategorie.
- Frage.
- Antwortoptionen.
- Fortschritt 1/15.
- Feedback nach Antwort.

## Memory Card

### Zustände

- verdeckt.
- aufgedeckt.
- korrektes Paar.
- falsches Paar.
- disabled während Auflösung.

## Badge Card

### Inhalte

- Icon.
- Name.
- Beschreibung.
- Status: freigeschaltet / gesperrt.
- Fortschritt.

## Team Card

### Inhalte

- Vorschaubild.
- Teamname.
- Stadt.
- Ermittler:innen.
- erstes Jahr.
- Favoriten-Stern.

## Settings Row

### Inhalte

- Icon.
- Titel.
- Beschreibung optional.
- Toggle, Chevron oder Status.

## Global States

Jede Komponente braucht:

- Loading State,
- Error State,
- Empty State,
- Disabled State,
- Accessibility Label.
