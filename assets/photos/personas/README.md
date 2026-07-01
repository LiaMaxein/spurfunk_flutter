# Persona-Profilbilder (Lastenheft)

Illustrierte Noir-Portraits der vier UX-Personas aus dem Lastenheft — **fiktive Archetypen**, keine Echtfotos, nicht mit App-Avataren (SVG-Motive) verwechseln.

| Datei | Persona | Alter | Ziel in der App |
|-------|---------|-------|-----------------|
| `persona_claudia.png` | Claudia | 70 | Gemeinschaft, Austausch, Barrierefreiheit |
| `persona_lukas.png` | Lukas | 28 | Austausch, Abstimmungen, Live-Analyse |
| `persona_anna.png` | Anna | 21 | Gamification (Quiz, Memory), Social Feeling |
| `persona_fritz.png` | Fritz | 45 | Qualitäts-Orientierung, Community, Voting |

## Kurzprofile

**Claudia (70)** — Jahrzehntelange Tatort-Fanin, rätselt gerne, kompetent am Handy, braucht große Schrift und klare Führung. Sitzt oft allein vor dem TV, möchte Austausch und kritisch bewerten.

**Lukas (28)** — Will den Täter früh finden, analysiert Plots und Logikfehler. Mobile-first, technikaffin. Empört sich über unrealistische Szenen — nutzt Chat und Abstimmungen.

**Anna (21)** — Tatort-Nostalgie aus dem Elternhaus, schaut sporadisch. Social-App-Nutzerin, tratscht gern, spielt parallel Memory/Quiz am Smartphone.

**Fritz (45)** — Kennt Tatort noch nicht lange (Österreich), pragmatischer App-Nutzer. Nutzt Voting und Aggregation für gute Folgen, will über Chat in den Sonntagskult eintauchen.

## Technik

- Pfade in Code: `AppAssets.personaClaudia` … `personaFritz`
- Ersetzen: PNG gleichen Namens überschreiben, optional Noir-Grading:
  ```bash
  python3 tool/postprocess_tatort_asset.py portrait input.png assets/photos/personas/persona_claudia.png
  ```
