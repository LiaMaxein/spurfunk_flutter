# Spurfunk – Cursor-Dokumentation

Diese Dokumentation übersetzt das Lastenheft **„Spurfunk – Der stille Gast schaut mit.“** in kompakte Markdown-Dateien für KI-Coding-Agenten wie Cursor.

## Ziel
Cursor soll jederzeit verstehen:

- welchen Nutzen die App hat,
- welche Zielgruppe angesprochen wird,
- welche Funktionen priorisiert sind,
- wie die App aussehen soll,
- welche Architektur verwendet wird,
- welche Regeln bei Code, UI, Datenschutz und Tests gelten.

## Empfohlene Nutzung in Cursor

1. Lege den gesamten Ordner in dein Flutter-Projekt.
2. Behalte `.cursor/rules/` unverändert bei, damit Cursor die Regeln automatisch berücksichtigen kann.
3. Nutze `docs/` als fachliche Referenz für Anforderungen, Screens, Datenmodell, API und Roadmap.
4. Frage Cursor bei jeder Umsetzung konkret nach einem Teilbereich, z. B. „Implementiere den Live-Screen gemäß docs/SCREENS.md und .cursor/rules/design.mdc“.

## Dokumentstruktur

```text
.cursor/rules/
  product.mdc
  architecture.mdc
  design.mdc
  flutter-coding.mdc
  data-security.mdc
  testing.mdc

docs/
  01_APP_PURPOSE.md
  02_PRODUCT_CONTEXT.md
  03_STAKEHOLDERS_PERSONAS.md
  04_REQUIREMENTS.md
  05_FEATURES.md
  06_RELEASE_ROADMAP.md
  07_ARCHITECTURE.md
  08_DATA_MODEL.md
  09_API_REALTIME.md
  10_NAVIGATION.md
  11_DESIGN_SYSTEM.md
  12_UI_COMPONENTS.md
  13_SCREENS.md
  14_GAMIFICATION.md
  15_SECURITY_COMPLIANCE.md
  16_TESTING_ACCEPTANCE.md
  17_LEGAL_BRANDING.md
  18_CURSOR_IMPLEMENTATION_PLAN.md
```
