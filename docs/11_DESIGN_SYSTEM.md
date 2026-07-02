# 11 – Design System

## Designphilosophie

Spurfunk verbindet moderne Mobile-UX mit klassischer Krimi-/Noir-Atmosphäre. Die App soll spannend, dunkel, emotional und trotzdem ruhig wirken. Sie darf nicht überladen sein, weil sie neben dem Fernsehen genutzt wird.

## Ziele

- hohe Wiedererkennbarkeit,
- intuitive Bedienbarkeit,
- möglichst wenige Klicks,
- gute Lesbarkeit bei dunkler Umgebung,
- emotionale Bindung,
- keine Ablenkung vom TV-Erlebnis.

## Farben

### Primärfarbe

| Name | Hex | Verwendung |
|---|---|---|
| Spurfunk Rot | `#E30613` | Live, CTA, aktive Tabs, Warn-/Spannungsakzent |

### Basisfarben

| Name | Hex | Verwendung |
|---|---|---|
| Schwarz | `#0A0A0A` | App-Hintergrund |
| Dunkelgrau | `#1A1A1A` | Cards, Panels, Eingabefelder |
| Hellgrau | `#B3B3B3` | Sekundärtext, inaktive Icons |
| Weiß | `#FFFFFF` | Primärtext |

### Voting-Farben

| Wertung | Emoji | Farbe |
|---|---|---|
| Schlecht | 😡 | Rot |
| Langweilig | 🙁 | Orange |
| Okay | 😐 | Gelb |
| Gut | 🙂 | Blau |
| Mega | 😍 | Grün |

## Typografie

| Bereich | Schrift |
|---|---|
| Headlines | Bebas Neue |
| große Zahlen | Bebas Neue |
| Zwischenüberschriften | Inter SemiBold |
| Fließtext | Inter Regular |
| Buttons | Inter SemiBold |
| Kommentare | Inter Regular |

## Icons

- Orientierung an Apple Human Interface Guidelines.
- Minimalistisch.
- Einfarbig.
- Inaktiv hellgrau.
- Aktiv rot.
- Linienstärke ca. 2 px.
- Keine ausgefüllten Icons.

## Cards

Cards sind das wichtigste Layout-Element.

**Eigenschaften**

- Hintergrund `#1A1A1A`.
- Radius 18 px.
- Innenabstand 16 px.
- Sehr dezenter Schatten.
- Klare Gruppierung.

## Buttons

### Primärbutton

- Rot.
- Weißer Text.
- Radius 16 px.
- Mindesthöhe 48 px.
- Für Hauptaktionen.

### Sekundärbutton

- Dunkelgrau.
- Weißer Text.
- Für alternative Aktionen.

### Textbutton

- Kein Hintergrund.
- Roter oder grauer Text.
- Für weniger wichtige Aktionen.

## Animationen

Animationen werden sparsam eingesetzt.

**Erlaubt**

- sanftes Einblenden,
- Slide-In,
- Pulsieren bei Live,
- schwebende Emojis,
- sanfte Screen-Transitions.

**Dauer**

- ca. 250–300 ms.

## Barrierefreiheit

Pflicht:

- hoher Farbkontrast,
- ausreichend große Buttons,
- Dynamic Type / skalierbare Schrift,
- Screenreader-Labels,
- alternative Texte,
- keine Information ausschließlich über Farbe,
- reduzierbare Animationen.

## Feedback

Jede Nutzeraktion erzeugt unmittelbares Feedback.

**Beispiele**

- Abstimmung erfolgreich.
- Kommentar gesendet.
- Emoji verschickt.
- Quiz beantwortet.
- Badge freigeschaltet.

**Formen**

- Toast,
- Haptik,
- kleine Animation.

## Ladezustände

Keine leeren Bildschirme. Stattdessen:

- Skeleton Loader,
- Ladeanimation,
- Fortschrittsindikator.

## Fehlerzustände

| Fehler | Darstellung |
|---|---|
| Kein Internet | Illustration + „Verbindung verloren“ |
| Keine Live-Sendung | Countdown |
| Keine Kommentare | „Sei der Erste.“ |
| Keine News | „Momentan keine Neuigkeiten.“ |

## Empty States

- Keine Favoriten: „Jetzt entdecken“.
- Keine Punkte: „Starte dein erstes Quiz“.
- Keine Badges: „Mitmachen lohnt sich.“

## Responsive Design

| Gerät | Layout |
|---|---|
| Smartphone | eine Spalte |
| Tablet | zwei Spalten |
| Desktop/Web | mehrspaltiges Dashboard |

## Nielsen-Prinzipien

- Systemstatus sichtbar machen: Countdown, Live-Badge, Loader, Fortschritt.
- Reale Welt abbilden: Begriffe wie Spuren, Ermittler, Mitwisser, Akte.
- Konsistenz: Farben, Buttons, Icons und Cards verhalten sich überall gleich.
- Fehlervermeidung: deaktivierte Buttons, klare Hinweise, Bestätigungen.
- Wiedererkennung statt Erinnerung: Navigation und Symbole dauerhaft sichtbar.
