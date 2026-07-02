# 18 – Implementation Plan

## Ziel

Diese Datei beschreibt die sinnvolle Reihenfolge für die App-Implementierung und den aktuellen Umsetzungsstand.

## Schritt 1 – Projektgrundlage ✅

- Flutter-Projekt prüfen.
- Theme anlegen.
- Farben und Typografie definieren.
- Basis-Routing mit GoRouter anlegen.
- Riverpod einrichten.
- Ordnerstruktur gemäß Architektur vorbereiten.

## Schritt 2 – Designsystem-Komponenten ✅

Implementiert:

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

## Schritt 3 – Mock-Daten und Models ✅

Implementiert:

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

## Schritt 4 – Onboarding ✅

Screens (PageView unter `/onboarding`):

1. Splash (außerhalb GoRouter).
2. Willkommen.
3. Identität wählen.
4. Geschlecht wählen.
5. Alias wählen.
6. Bestätigung.

Persistenz:

- SharedPreferences für Onboarding abgeschlossen.
- Avatar, Alias und Geschlecht lokal speichern.

## Schritt 5 – Home ✅

Implementiert:

- Kein-Live-Zustand.
- Live-Zustand.
- Countdown.
- letzte Abstimmung.
- Polizeifunk-Karten.
- Schnellzugriffe.

## Schritt 6 – Live-Bereich ✅

Implementiert:

- Live-Modus.
- Nicht-Live-Modus.
- Mitwisser-Chat mit Mock-Stream.
- Emoji-Reaktionen mit Animation.
- Aktueller-Fall-Tab.

## Schritt 7 – Community ✅

Implementiert:

- Tabs: Statistiken, Quiz, Memory, Rangliste (Rangliste als Coming-soon-Stub).
- Voting-Ergebnisdetails.
- Filter UI.
- Quiz-Basisversion.
- Memory-Basisversion.

## Schritt 8 – Fakten ✅ (teilweise)

Implementiert:

- Fakten-Tab.
- Ermittler-Teams.
- Team-Detailseite.
- Geschichte / Zeitleiste.
- Städte.

**Offen:** Hinter den Kulissen.

## Schritt 9 – Profil ✅

Implementiert:

- Akte.
- XP und Level.
- persönliche Statistiken.
- Aktivitätstracker.
- Badge-Sammlung.
- Favoriten.

## Schritt 10 – Einstellungen ✅

Implementiert:

- Benachrichtigungen.
- App-Design.
- Datenschutz.
- Barrierefreiheit.
- Hilfe & FAQ.
- Über Spurfunk.
- Abmelden.

## Schritt 11 – Backend-Vorbereitung ⏳

- Repository Interfaces stabilisieren.
- Supabase Client vorbereiten.
- RLS-Konzept übertragen.
- Realtime Channels vorbereiten.

## Schritt 12 – Tests ⏳

- Unit Tests.
- Widget Tests.
- Navigation Tests.
- Mock Stream Tests.
- Accessibility Checks.

## Implementierungs-Checkliste

Bei neuen Features:

1. Designsystem prüfen: `docs/11_DESIGN_SYSTEM.md`, Mockups unter `assets/mockups/`.
2. Screen-Spec lesen: `docs/13_SCREENS.md`.
3. Anforderungen prüfen: `docs/04_REQUIREMENTS.md`, `docs/05_FEATURES.md`.
4. Mock-first, backend-ready über Repository Interfaces umsetzen.
