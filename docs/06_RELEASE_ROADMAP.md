# 06 – Release Roadmap

## MVP / Version 1.0 – Kernfunktionalität

Ziel: Erster Live-Betrieb mit Second-Screen-Kernnutzen.

### Enthalten

#### Nutzerkonto

- Lokale Registrierung/Login-Struktur.
- Profilverwaltung als „Akte“.
- Anonyme Avatar-Auswahl.
- Keine Klarnamen oder Echtfotos.

#### Live-Bereich

- Anzeige der aktuellen oder nächsten Folge.
- Live-Abstimmung.
- Echtzeit-Ergebnisvisualisierung.
- Live-Zustand / Nicht-Live-Zustand.

#### Community / Verhörraum

- Mitwisser-Chat.
- Kommentare parallel zur Ausstrahlung.
- Emoji-Schnellreaktionen.

#### Polizeifunk

- News anzeigen.
- neue Folgen ankündigen.
- Community-News und Hintergrundinformationen.

#### Statistiken

- einfache Aggregationsübersichten.
- Filter nach Region, Alterskohorte und Geschlecht.

## Version 1.5 – Inhaltliche Erweiterung

Ziel: Mehr Informationswert und Komfort.

### Enthalten

- Ermittlerdatenbank.
- aktuelle und ehemalige Ermittlerteams.
- Teamübersichten.
- Historienbereich.
- Geschichte der Serie.
- Produktionsfakten.
- Rekorde und Statistiken.
- Push-Benachrichtigungen.

## Version 2.0 – Gamification & Engagement

Ziel: Bindung, Spaß und regelmäßige Nutzung erhöhen.

### Enthalten

- Quiz mit Fragenpool.
- Quiz-Kategorien.
- Memory mit mehreren Schwierigkeitsgraden.
- KI-generierte, stilisierte Vektorgrafiken.
- Mitwisser-XP-System.
- Badges.
- Ranglisten.

## Version 3.0 – Community-Ausbau & Monetarisierung

Ziel: Lokale Events, Monetarisierung und automatisierte Inhalte.

### Enthalten

- Tatort-Lokale.
- QR-Code-Einstiege für lokale Live-Events.
- Standortübersicht.
- Premium-Modell.
- unbegrenzte Quizze.
- unbegrenztes Memory.
- automatisierter Datenimport aus zulässigen Quellen.

## Kano-Einordnung

| Kategorie | Funktionen |
|---|---|
| Basismerkmale | Registrierung, Profil, Live-Abstimmung, Echtzeit-Ergebnisse, Chat, Emoji-Reaktionen |
| Leistungsmerkmale | Polizeifunk, Statistiken, Ermittlerdatenbank, Historienbereich, Push-Benachrichtigungen |
| Begeisterungsmerkmale | Quiz, Memory, XP-System, Badges, QR-Code-Einstieg, Premium-Modell |

## Implementierungsregel

MVP-Funktionen haben Vorrang bei neuen Änderungen. Spätere Versionen dürfen vorbereitet, aber nicht als Kernabhängigkeit für den Kernbetrieb vorausgesetzt werden.

## Aktueller Stand (Prototyp)

Der Flutter-Prototyp hat den ursprünglichen MVP-1.0-Umfang weitgehend umgesetzt und darüber hinaus erweitert:

| Bereich | Status |
|---|---|
| Onboarding (5 Schritte) | umgesetzt |
| Home (Live / Kein-Live) | umgesetzt |
| Live (Chat, Voting, Aktueller Fall) | umgesetzt |
| Community (Statistiken, Quiz, Memory) | umgesetzt |
| Polizeifunk auf Home | umgesetzt |
| Fakten (4 Tabs: Fakten, Teams, Geschichte, Städte) | umgesetzt |
| Profil (XP, Badges, Aktivität, Einstellungen) | umgesetzt |
| Rangliste | Coming-soon-Stub |
| Hinter den Kulissen (Fakten) | geplant, nicht umgesetzt |
| Supabase-Backend | geplant |
| Push-Benachrichtigungen (echt) | geplant |
| Premium / QR-Code-Lokale | geplant |
