# 04 – Requirements

## Funktionale Anforderungen

### FR-01 Registrierung und Profil – Muss

Das System muss eine Registrierung bzw. lokale Login-Struktur erlauben. Nutzer:innen müssen ein Profil anlegen können.

**Akzeptanzkriterien**

- Nutzer:in kann Onboarding abschließen.
- Nutzer:in kann Avatar wählen.
- Nutzer:in kann Alias eingeben oder anonym bleiben.
- Profildaten werden lokal gespeichert, im Zielsystem später sicher im Backend.

### FR-02 Live-Abstimmung – Muss

Nutzer:innen müssen während der Sendezeit eine Bewertung abgeben können. Das Votingfenster schließt 30 Minuten nach der Live-Ausstrahlung.

**Bewertungsskala**

- 😡 Schlecht – rot
- 🙁 Langweilig – orange
- 😐 Okay – gelb
- 🙂 Gut – blau
- 😍 Mega – grün

**Akzeptanzkriterien**

- Pro Nutzer:in und Episode ist nur eine reguläre Stimme zulässig.
- Voting ist nur im aktiven Zeitfenster möglich.
- Nach Ende des Fensters wird Voting deaktiviert.

### FR-03 Echtzeit-Resultate – Muss

Abgegebene Stimmen müssen aggregiert und im Frontend per persistentem Stream live aktualisiert werden.

**Akzeptanzkriterien**

- Ergebnisse aktualisieren ohne manuellen Reload.
- Balkendiagramme zeigen Prozentwerte und Anzahl Stimmen.
- Update-Latenz bleibt innerhalb der nicht-funktionalen Vorgabe.

### FR-04 Filterfunktionen – Muss

Ergebnisse sollen nach Region, Alterskohorte und Geschlecht filterbar sein.

**Akzeptanzkriterien**

- Filter können einzeln und kombiniert angewendet werden.
- Keine deanonymisierende Darstellung kleiner Gruppen.
- Ergebnisdiagramme aktualisieren nach Filteränderung.

### FR-05 Nutzerprofile / Akte – Muss

Nutzer:innen müssen eine persönliche Akte mit Avatar und Benutzername/Alias anlegen können.

**Akzeptanzkriterien**

- Keine echten Fotos.
- Keine Pflicht zu Klarnamen.
- Avatar-Auswahl aus symbolischen Krimi-/Noir-Motiven.

### FR-06 Live-Interaktion – Muss

Das System muss einen Chat-Raum bereitstellen. Schnellreaktionen müssen als flüchtige, schwebende Emojis gerendert werden können.

**Akzeptanzkriterien**

- Nachrichten erscheinen chronologisch.
- Chat scrollt fließend weiter.
- Emoji-Reaktionen steigen animiert rechts im Chat auf.
- Rate Limiting verhindert Spam.

### FR-07 Newsbereich / Polizeifunk – Soll

Ein Newsbereich soll redaktionelle Metadaten anzeigen.

**Inhalte**

- nächste Folgen,
- Interviews,
- Abstimmungsergebnisse,
- Community-News,
- neue Funktionen,
- Hintergrundinformationen.

### FR-08 QR-Code-Einladungssystem – Kann

Die App kann dynamische QR-Codes generieren.

**Use Cases**

- Einstieg in spezifische lokale Chatrooms.
- Teilen der App im privaten Umfeld.
- Nutzung für Kneipen oder Viewing-Events.

### FR-09 Push-Benachrichtigungen – Soll

Die App soll Push-Benachrichtigungen unterstützen.

**Beispiele**

- Erinnerung vor Live-Beginn,
- neue Folge,
- Live-Abstimmung startet,
- Community-Aktivitäten,
- Antworten im Chat.

### FR-10 Ermittlerdatenbank – Soll

Informationen über Ermittlerteams sollen bereitgestellt werden.

**Inhalte**

- aktuelle Teams,
- ehemalige Teams,
- Teamübersicht,
- Detailseiten,
- Favoriten.

### FR-11 Historienbereich – Soll

Informationen zur Geschichte der Serie sollen abrufbar sein.

**Inhalte**

- Zeitleiste,
- Meilensteine,
- Produktionsfakten,
- Rekorde,
- Serienentwicklung.

### FR-12 Quiz – Kann

Nutzer:innen sollen Quizze absolvieren können.

**Akzeptanzkriterien**

- Standard-Quiz mit 15 zufälligen Fragen.
- Kategorien werden unterstützt.
- Ergebnis inklusive Score, Lösungsquote und XP.

### FR-13 Memory – Kann

Nutzer:innen sollen Memory in verschiedenen Schwierigkeitsstufen spielen können.

**Stufen**

- Leicht 4×4
- Mittel 6×6
- Schwer 9×9
- Experte 12×12

### FR-14 Premium-Mitgliedschaft – Kann

Premium-Nutzer:innen erhalten Zugriff auf erweiterte Inhalte.

**Mögliche Vorteile**

- unbegrenzte Quizze,
- unbegrenztes Memory,
- erweiterte Statistiken,
- exklusive Badges.

### FR-15 Datenimport – Kann

Das System soll perspektivisch redaktionelle Basisdaten aus zulässigen Quellen importieren können.

**Datenarten**

- Episoden,
- Termine,
- Ermittlerteams,
- Hintergrundinformationen,
- Polizeifunk-Inhalte.

## Nicht-funktionale Anforderungen

### NFA-01 Latenz & Performance – Muss

Round-Trip-Time für Live-Chat und Voting-Updates unter Spitzenlast: **< 2 Sekunden**.

### NFA-02 Barrierefreiheit & Usability – Muss

Die App muss skalierbare Schriftgrößen, kontrastreiche Darstellung, Dark Theme und einfache Bedienbarkeit unterstützen.

### NFA-03 Responsivität – Muss

Das Layout muss Smartphones, Tablets und Webbrowser unterstützen.

### NFA-04 Kompatibilität – Muss

Zielplattformen:

- iOS,
- Android,
- Web.

## Definition of Done je Feature

Ein Feature gilt erst als fertig, wenn:

- UI im Dark Theme konsistent ist,
- leere, ladende und fehlerhafte Zustände vorhanden sind,
- Accessibility-Labels gesetzt sind,
- State nicht direkt im Widget versteckt ist,
- relevante Tests vorhanden sind,
- Navigation korrekt funktioniert,
- keine personenbezogenen Daten unnötig gespeichert werden.
