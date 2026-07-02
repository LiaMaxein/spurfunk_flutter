# 18 – Cursor Implementation Plan

## Ziel

Diese Datei beschreibt eine sinnvolle Reihenfolge, in der Cursor die App implementieren soll.

## Schritt 1 – Projektgrundlage

- Flutter-Projekt prüfen.
- Theme anlegen.
- Farben und Typografie definieren.
- Basis-Routing mit GoRouter anlegen.
- Riverpod einrichten.
- Ordnerstruktur gemäß Architektur vorbereiten.

## Schritt 2 – Designsystem-Komponenten

Implementieren:

- AppScaffold.
- SpurfunkHeader.
- BottomTabBar.
- AppCard.
- PrimaryButton.
- SecondaryButton.
- EmptyState.
- ErrorState.
- LoadingSkeleton.
- VoteOptionButton.
- StatBar.
- AvatarCard.

## Schritt 3 – Mock-Daten und Models

Implementieren:

- UserProfile.
- Avatar.
- Episode.
- Vote.
- ChatMessage.
- NewsItem.
- InvestigatorTeam.
- QuizQuestion.
- Badge.

Mock-Repositories:

- MockAuthRepository.
- MockEpisodeRepository.
- MockVoteRepository.
- MockChatRepository.
- MockNewsRepository.
- MockFactsRepository.
- MockGamificationRepository.

## Schritt 4 – Onboarding

Screens:

1. Splash.
2. Willkommen.
3. Identität wählen.
4. Alias wählen.
5. Bestätigung.

Persistenz:

- SharedPreferences für Onboarding abgeschlossen.
- Avatar und Alias lokal speichern.

## Schritt 5 – Home

Implementieren:

- Kein-Live-Zustand.
- Live-Zustand.
- Countdown.
- letzte Abstimmung.
- Polizeifunk-Karten.
- Schnellzugriffe.

## Schritt 6 – Live-Bereich

Implementieren:

- Live-Modus.
- Nicht-Live-Modus.
- Mitwisser-Chat mit Mock-Stream.
- Emoji-Reaktionen mit Animation.
- Aktueller-Fall-Tab.

## Schritt 7 – Community

Implementieren:

- Tabs: Statistiken, Quiz, Memory, Rangliste.
- Voting-Ergebnisdetails.
- Filter UI.
- Quiz-Basisversion.
- Memory-Basisversion.
- Rangliste mit Mock-Daten.

## Schritt 8 – Fakten

Implementieren:

- Fakten-Tab.
- Ermittler-Teams.
- Team-Detailseite.
- Geschichte / Zeitleiste.
- Städte.
- Hinter den Kulissen.

## Schritt 9 – Profil

Implementieren:

- Akte.
- XP und Level.
- persönliche Statistiken.
- Aktivitätstracker.
- Badge-Sammlung.
- Favoriten.

## Schritt 10 – Einstellungen

Implementieren:

- Benachrichtigungen.
- App-Design.
- Datenschutz.
- Barrierefreiheit.
- Hilfe & FAQ.
- Über Spurfunk.
- Abmelden.

## Schritt 11 – Backend-Vorbereitung

- Repository Interfaces stabilisieren.
- Supabase Client vorbereiten.
- RLS-Konzept übertragen.
- Realtime Channels vorbereiten.

## Schritt 12 – Tests

- Unit Tests.
- Widget Tests.
- Navigation Tests.
- Mock Stream Tests.
- Accessibility Checks.

## Prompt-Vorlagen für Cursor

### Designsystem

```text
Implementiere das Spurfunk Designsystem gemäß docs/11_DESIGN_SYSTEM.md und .cursor/rules/design.mdc. Nutze Flutter ThemeData, zentrale Konstanten und wiederverwendbare Widgets. Keine Businesslogik in UI-Komponenten.
```

### Screen

```text
Implementiere den Screen [NAME] gemäß docs/13_SCREENS.md. Nutze vorhandene Komponenten aus core/widgets, Riverpod für State und GoRouter für Navigation. Berücksichtige Loading, Empty und Error States.
```

### Feature

```text
Implementiere Feature [NAME] gemäß docs/04_REQUIREMENTS.md und docs/05_FEATURES.md. Arbeite mock-first, aber backend-ready über Repository Interfaces.
```
