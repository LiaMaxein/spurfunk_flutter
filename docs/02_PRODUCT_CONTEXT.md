# 02 – Product Context

## Ausgangssituation

Krimifans konsumieren Folgen derzeit überwiegend über:

- lineare TV-Ausstrahlung,
- Mediatheken,
- parallele Social-Media-Diskussionen.

Die Social-Media-Diskussion ist fragmentiert, unstrukturiert und nicht speziell auf gemeinsames Miträtseln während einer Ausstrahlung ausgelegt.

## Soll-Situation

Spurfunk soll eine zentrale App bereitstellen, die folgende Funktionen kombiniert:

- Live-Reaktionen,
- Community-Interaktion,
- Echtzeit-Abstimmungen,
- personalisierte und anonymisierte Auswertungen,
- Gamification.

## Systemumfang

### Enthalten

- Mobile App für iOS und Android mit native-like Verhalten.
- Optionale Webanwendung mit responsivem Design.
- Backend-System für Datenverarbeitung, Benutzerverwaltung und Echtzeitkommunikation.
- Lokaler Prototyp mit Mock-Daten und SharedPreferences.
- Spätere Supabase-Anbindung mit PostgreSQL, Auth und Realtime-Service.

### Nicht enthalten

- Keine Änderung oder Erweiterung der offiziellen ARD-Mediathek.
- Kein eigenes Videostreaming.
- Kein offizielles Streaming-Backend.
- Kein Hosting offizieller, urheberrechtlich geschützter Inhalte.
- Keine offizielle Kooperation oder Datenexklusivität.

## Dokumentkonventionen

Anforderungen werden in drei Prioritätsstufen geführt:

| Begriff | Bedeutung |
|---|---|
| Muss | Zwingende Anforderung. Ohne diese Funktion ist der Kernnutzen nicht erfüllt. |
| Soll | Wichtige Anforderung, aber nicht zwingend für den ersten Betrieb. |
| Kann | Optionale Erweiterung oder zukünftiges Feature. |

## Produktmetriken

Nach Release sollen folgende KPIs messbar sein:

| KPI | Messziel |
|---|---|
| Registrierte Nutzer:innen | Anzahl angelegter Profile/Akten |
| Gleichzeitige aktive Nutzer:innen | Parallel aktive Verbindungen während Live-Episoden |
| Interaktionsrate | Verhältnis Voting-Stimmen zu aktiven Nutzer:innen |
| Community-Aktivität | Anzahl Beiträge und Emoji-Reaktionen |
| Retentionsrate | Wiederkehrende Nutzung an mehreren Sonntagen |
