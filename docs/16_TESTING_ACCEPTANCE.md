# 16 – Testing & Acceptance

## Ziel

Die App muss stabil, responsiv, barrierearm und live-tauglich sein.

## Definition of Done

Ein Feature gilt als fertig, wenn:

- es auf iOS, Android und Web grundsätzlich lauffähig ist,
- UI im Dark Theme korrekt dargestellt wird,
- Light/Dark-Umschaltung keine Fehler erzeugt,
- Layout auf Smartphone und Tablet funktioniert,
- keine Textüberlappungen auftreten,
- Loading, Empty und Error States vorhanden sind,
- Accessibility berücksichtigt ist,
- Businesslogik getestet ist,
- Realtime-/Mock-Streams sauber disposed werden.

## Technische Abnahmekriterien

### Echtzeitübertragung

Live-Votings aktualisieren sich ohne Reload innerhalb des Latenzfensters.

### Plattformkompatibilität

App startet fehlerfrei auf:

- iOS-Simulator,
- Android-Emulator,
- Chrome,
- Safari,
- Firefox.

### Robuste Anonymität

Teilnahme an Chat und Voting ist ohne Klarnamen und Echtfoto möglich.

### Gamification

Quiz und Memory haben einen fehlerfreien Spielzyklus.

### Responsivität

Keine UI-Glitches oder Textüberlappungen auf Smartphone, Tablet und Desktop.

### Anzeige- und Filtersystem

Stimmen werden korrekt nach Region, Alterskohorte und Geschlecht gefiltert.

### Visualisierung

Light und Dark Mode funktionieren systemweit.

## Testpyramide

### Phase 1 – Automatisierte Tests

- Static Code Analysis / Linting.
- Unit Tests für Businesslogik.
- Unit Tests für Voting-Aggregation.
- Unit Tests für JSON-Parsing.
- Riverpod-Notifier-Tests.
- Widget Tests für UI-Komponenten.
- Accessibility-relevante Widget Tests.

### Phase 2 – Integration Tests

- Flutter Frontend + Mock Repository.
- Flutter Frontend + Supabase später.
- Chat-Stream.
- Voting-Stream.
- Navigation.
- Onboarding Flow.

### Phase 3 – Load Tests

Simulation des Sonntags-Peaks.

Tools möglich:

- Locust.
- Artillery.

Szenarien:

- viele gleichzeitige Chat-Nachrichten,
- viele gleichzeitige Votes,
- viele WebSocket-Verbindungen,
- Rate-Limit-Prüfung.

### Phase 4 – Staging / Beta

- iOS TestFlight.
- Android Closed Testing.
- Web-Staging.

### Phase 5 – Production Release

- Staged Rollout.
- Crashlytics oder Sentry.
- Rollout stoppen bei erhöhter Fehlerrate.
- Hotfix-Prozess.

## Testregel

Bei neuen Features sollen passende Tests oder mindestens Test-Szenarien mitgeliefert werden.
