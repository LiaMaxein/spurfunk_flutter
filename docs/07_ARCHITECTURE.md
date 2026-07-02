# 07 – Architecture

## Zielarchitektur

Spurfunk wird als Cross-Plattform-App mit Flutter umgesetzt. Der aktuelle Prototyp arbeitet lokal mit Mock-Daten und SharedPreferences. In späteren Phasen wird Supabase als Backend-as-a-Service angebunden.

## Technologie-Stack

| Komponente | Technologie |
|---|---|
| Frontend | Flutter / Dart |
| State Management | Riverpod |
| Routing | GoRouter |
| Lokale Speicherung | SharedPreferences, für sensible Daten Flutter Secure Storage |
| Responsive Design | LayoutBuilder, MediaQuery, Breakpoints |
| Prototyp-Datenbasis | Mock-Daten und lokale JSON-Strukturen |
| Ziel-Backend | Supabase |
| Ziel-Datenbank | PostgreSQL mit Row Level Security |
| Realtime | Supabase Realtime / WebSockets |
| Auth | Supabase Auth / JWT |

## Architekturprinzipien

### 1. Cross-Plattform zuerst

Eine Codebasis für iOS, Android und Web.

### 2. UI und Businesslogik trennen

Widgets enthalten keine komplexe Businesslogik. Logik liegt in Services, Repositories oder Riverpod-Notifiers.

### 3. Mock-first, Backend-ready

Alle Features sollen zunächst mit Mock-Daten laufen können. Die Datenzugriffsschicht muss später gegen Supabase austauschbar sein.

### 4. Realtime-ready

Live-Voting und Chat werden so modelliert, dass sie später per WebSocket/Realtime-Stream aktualisiert werden können.

### 5. Privacy by Design

Minimale Datenerhebung, keine Klarnamenpflicht, keine Echtfotos.

## Empfohlene Flutter-Projektstruktur (Ist-Stand)

```text
lib/
  main.dart
  app/
    spurfunk_app.dart
  core/
    assets/
    config/
    layout/
    persistence/
    router/
    startup/
    theme/
    utils/
    widgets/
  features/
    startup/
      presentation/
    onboarding/
      application/
      presentation/
    home/
      application/
      presentation/
    live_episode/
      application/
      data/
      presentation/
    community/
      application/
      data/
      presentation/
    facts/
      data/
      presentation/
    profile/
      application/
      data/
      presentation/
    settings/
      application/
      presentation/
  shared/
    models/
    repositories/
    mock_data/
```

Jedes Feature nutzt typischerweise `data/`, `application/` (Riverpod-Notifier) und `presentation/`. Ein separater `domain/`-Layer ist im Prototyp nicht vorhanden.

## Datenfluss

```mermaid
flowchart LR
  UI[Flutter UI] --> Provider[Riverpod Provider]
  Provider --> Repository[Repository]
  Repository --> Local[Local Storage / Mock JSON]
  Repository --> Supabase[Supabase später]
  Supabase --> DB[PostgreSQL]
  Supabase --> Realtime[Realtime Channels]
```

## Systemkontext

```mermaid
flowchart LR
  User["Nutzer:in"] --> Flutter["Flutter Frontend iOS / Android / Web"]
  Admin["Administrator:in"] --> Flutter
  Flutter --> Local["Lokale Speicherung"]
  Flutter --> Supabase["Supabase Backend"]
  Supabase --> DB["PostgreSQL"]
  Supabase --> RT["Realtime Service"]
  Supabase --> Auth["Authentifizierung"]
  Sources["Externe zulässige Datenquellen"] --> Supabase
```

## Kritische technische Herausforderungen

### Peak Times

Sonntag 20:15 bis 21:45 Uhr kann hohe Last verursachen. Chat, Voting und Ergebnisupdates müssen effizient sein.

### Client-Ressourcen

WebSockets, Animationen und Chat dürfen CPU und Akku nicht unnötig belasten. Provider und Streams müssen sauber disposed werden.

### Realtime-Latenz

Ziel: Chat- und Voting-Updates unter 2 Sekunden.
