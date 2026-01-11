# Hippocampus - Session-Gedächtnis

---

## Session 28 (2025-12-24)

**Thema:** Schreibstube KI-Berater repariert

**Erledigt:**
- **KI-Berater war nutzlos** - User hat sich beschwert, Dialog angeschaut
- **Problem 1:** Kein Chat-Gedächtnis - nur aktuelle Nachricht wurde gesendet
- **Problem 2:** Haiku-Modell zu dumm für echte Konversation
- **Problem 3:** Generischer System-Prompt, roboterhaftes Verhalten
- **Fix:** Chat-History eingebaut (letzte 20 Nachrichten)
- **Fix:** Modell auf Sonnet gewechselt
- **Fix:** Neuer System-Prompt der zuhört statt ständig fragt
- **Sammel-Prompt** für "Das 2. Compendium - Selbstliebe" gesetzt (Zuhör-Modus)
- Alte Dialoge gelöscht für frischen Start

**Geänderte Dateien:**
- /opt/office/src/routes/api/schreiben/+server.ts (Zeilen 88-164)

**Offen:** Nichts

---

## Session 27 (2025-12-24)

**Thema:** Bugfixes Erinnerungen

**Erledigt:**
- **Heute-Filter Bug:** Überfällige Termine wurden nicht angezeigt
  - Fix: `r.dueDate <= heute` statt `r.dueDate.startsWith(heute)`
  - Jetzt erscheint z.B. Friseur-Termin bei Jessica auch wenn überfällig
- **iOS Datum-Bug:** Buttons brauchten Doppel-Tap auf iPhone
  - Inline-Buttons entfernt
  - Neues Modal von unten (iOS-Style)
  - Große Touch-Targets, 4x2 Grid
  - Safe Area für iPhone berücksichtigt
  - "Datum entfernen" Option hinzugefügt

**Offen:** Nichts

---

## Session 26 (2025-12-24)

**Thema:** Schreibstube KI-Projekte + Mobile-Optimierung

**Erledigt:**
- **Schreibstube KI-Assistent** wie Claude Projects:
  - Pro Buch eigener Dialog mit eigener Historie
  - Automatischer Buch-Kontext (alle Kapitel werden der KI mitgegeben)
  - System-Prompt pro Buch editierbar (Projekt-Einstellungen)
  - DB: dialog_messages.book_id + books.system_prompt
- **Erinnerungen Lazy Loading:**
  - Nur 50 Einträge initial, "Mehr laden" Button
  - Performance bei 2000+ Einträgen drastisch verbessert
- **Schreibstube iPhone-Optimierung:**
  - Header: Tabs als Icons auf Mobile
  - Werkbank: Sidebar als Drawer (📚 Button)
  - Safe Area für iPhone Notch/Status Bar
  - Größere Touch-Targets überall
- **Bugfix:** Dialog-Nachrichten einzeln/gemeinsam löschen funktioniert jetzt

**Langfristig notiert:** Weg von iCloud Erinnerungen (in aktuell.md)

**Offen:** Nichts

---

## Session 25 (2025-12-23)

**Thema:** Schreibstube - Autoren-Tool

**Erledigt:**
- Neues Feature: /schreiben - Komplettes Autoren-Tool
- **Werkbank:** Bücher → Kapitel mit Auto-Save (2 Sek), Wort-/Zeichenzähler
- **Zettelkasten:** Freie Gedanken als Karten, Tags, Suche, "→ Kapitel" Funktion
- **KI-Dialog:** Sokratischer Sparringspartner (Claude Haiku), Kontext-Button
- **Export:** PDF/DOCX/MD via Pandoc
- SQLite-Datenbank: /opt/office/data/schreibstube.db
- API: /api/schreiben (CRUD für books, chapters, zettel, dialog, export)
- Compendium "Der dritte Weg" importiert (9 Kapitel)
- ✍️-Button auf Landing Page hinzugefügt

**Neue Dateien:**
- /opt/office/src/lib/schreibstube.ts (DB-Funktionen)
- /opt/office/src/routes/schreiben/+page.svelte (UI)
- /opt/office/src/routes/api/schreiben/+server.ts (API)

**Nachträglich hinzugefügt:**
- Dialog-Persistenz: Nachrichten werden in DB gespeichert (dialog_messages Tabelle)
- Admin-Tab: Übersicht aller Bücher/Kapitel/Zettel/Dialog-Nachrichten mit Einzellöschung

**Offen:** Nichts

---

## Session 24 (2025-12-23)

**Thema:** Erinnerungen-Seite Apple-Style

**Erledigt:**
- Apple-Style Hamburger-Menü mit farbigen Kacheln (Heute, Geplant, Offen, Alle, Wochenende)
- "Meine Listen" Sektion mit Kategorien
- Edit-Modal für Erinnerungen (Titel + Notizen bearbeiten)
- Datum-Buttons erweitert: 1W, 1M hinzugefügt
- Erinnerungen als neue Landing Page (/)
- /office Route für Chat/Terminal

**Offen:** Nichts

---
