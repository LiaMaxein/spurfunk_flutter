# 15 – Security & Compliance

## Grundprinzipien

- Datenschutz durch Technikgestaltung.
- Datenminimierung.
- Keine Klarnamenpflicht.
- Keine echten Profilbilder.
- Keine dauerhafte Speicherung exakter GPS-Daten.
- Sichere lokale Speicherung.
- Sichere Kommunikation.

## DSGVO

Das System folgt dem Prinzip der Datenminimierung und Privacy by Design.

### Nicht dauerhaft speichern

- Klarnamen,
- unmaskierte IP-Adressen,
- exakte GPS-Koordinaten,
- echte Profilfotos.

### Zulässig

- Alias,
- Avatar-ID,
- grobe Region,
- Alterskohorte,
- freiwillige demografische Angaben,
- Voting-Werte,
- Chat-Inhalte.

## Lokale Speicherung

- Normale Prototyp-Daten: SharedPreferences.
- Sensible Session-/Token-Daten: Flutter Secure Storage.
- iOS: Keychain.
- Android: Keystore.

## Kommunikation

- HTTPS für API.
- WSS für WebSockets.
- Kein Fallback auf unverschlüsselte Protokolle.

## Abstimmungsintegrität

### Schutzmechanismen

- Eine Stimme pro Episode und Nutzer:in.
- Rate Limiting.
- JWT-Validierung nach Supabase-Anbindung.
- Blockieren ungültiger Tokens.
- HTTP 429 bei zu vielen Anfragen.

## Rate-Limit-Regeln

- Maximal 3 Chat-Nachrichten pro 5 Sekunden.
- Maximal 1 Vote pro Episode.
- Emoji-Reaktionen ggf. begrenzen.

## OWASP Mobile Top 10

### M1 Insecure Data Storage

Sensible Profildaten und Tokens werden verschlüsselt gespeichert.

### M2 Insecure Communication

Alle Datenübertragungen laufen über TLS.

## Logging & Monitoring

### Loggen

- Systemfehler.
- fehlgeschlagene Authentifizierungsversuche.
- Rate-Limit-Verstöße.
- verdächtige API-Nutzung.

### Nicht loggen

- Passwörter.
- unmaskierte IP-Adressen.
- unnötige personenbezogene Daten.

## Monitoring

- Antwortzeiten der Datenbank.
- WebSocket-Verbindungslast.
- Fehlerrate.
- Crashrate.
- Lastspitzen während Live-Sendungen.

## Rechtliche Rahmenbedingungen

Siehe `17_LEGAL_BRANDING.md` für Branding, Namensrecht und offizielle Abgrenzung.
