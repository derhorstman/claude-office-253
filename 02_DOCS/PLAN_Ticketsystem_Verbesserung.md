# Plan: Ticketsystem-Verbesserung

**Erstellt:** 2026-01-04 (Session 46)
**Status:** Geplant

---

## Ziel

Tickets direkt im Terminal bearbeiten mit vollem Kontext - nicht über das kleine Claude-Modal im Frontend, sondern hier in der tmux-Session mit allem Systemwissen.

---

## Problem (Ist-Zustand)

1. Nach Context-Wechsel vergesse ich grundlegendes Systemwissen (Server-IPs, Drucker, Pfade)
2. Die Claude-Prüfung im Frontend ist oberflächlich (kein SSH, keine Dateioperationen)
3. Wenn ich ein Ticket bearbeite, fehlt mir oft der Kontext (wo liegen Akten, wie drucke ich, etc.)
4. Erinnerungen sind jetzt JSON, nicht mehr Apple Reminders - das vergesse ich

---

## Lösung (Soll-Zustand)

### 1. Schnellreferenz-Dokument

**Datei:** `/opt/Claude/01_START/Schnellreferenz.md`

Kompaktes Dokument mit dem Wichtigsten:
- Drucker: `lpstat -p -d`, dann `lp -d "Privat-Drucker" /pfad`
- Akten: `/mnt/dieterhorst/Documents/Erinnerungen/`
- Tickets: `/opt/office/data/akten/index.json`
- Erinnerungen: JSON unter `/opt/office/data/reminders-kategorisiert.json`
- SSH Quick-Reference (wichtigste IPs)
- Regel: Nicht raten, erst nachschlagen

### 2. Ticket-Befehle im Terminal

**"liste tickets"** oder **"zeig tickets"**
- Liest `/opt/office/data/akten/index.json`
- Zeigt Übersicht: ID | Titel | Status | Kategorie
- Filtert auf nicht-erledigte Tickets (optional: alle)

**"ticket [Name/ID]"** (z.B. "ticket Lindemann" oder "ticket SUPPORT-2026-012")
- Lädt Schnellreferenz (falls nicht im Kontext)
- Findet Ticket per ID oder Titel-Suche
- Liest verknüpften Ordner unter `/mnt/dieterhorst/...`
- Liest relevante Dateien (PDFs auflisten, Textdateien lesen)
- Zeigt History
- Ich habe dann vollen Kontext und kann arbeiten

### 3. Frontend-Button (optional, später)

Button "Im Terminal öffnen" im Ticket-Detail:
- Startet neue tmux-Session
- Setzt Ticket-Kontext als Prompt-Vorbau
- Öffnet Terminal im Frontend

---

## Umsetzung

### Phase 1: Schnellreferenz erstellen
- [ ] `/opt/Claude/01_START/Schnellreferenz.md` schreiben
- [ ] In Session-Start-Routine aufnehmen

### Phase 2: Ticket-Befehle
- [ ] Bei "liste tickets" → JSON lesen, Tabelle ausgeben
- [ ] Bei "ticket X" → Ticket laden, Ordner lesen, Kontext aufbauen
- [ ] Automatisch Schnellreferenz laden wenn nicht im Kontext

### Phase 3: Frontend-Integration (optional)
- [ ] Button "Im Terminal öffnen" in `/opt/office/src/routes/akten/+page.svelte`
- [ ] Script das tmux-Session mit Ticket-Kontext startet

---

## Beispiel-Ablauf

```
User: liste tickets

Claude:
| ID | Titel | Status | Kategorie |
|----|-------|--------|-----------|
| SUPPORT-2026-012 | posterXXL Reklamation | Erledigt | SUPPORT |
| SUPPORT-2025-008 | Lindemann Michael | Warte auf Antwort | SUPPORT |
| ADMIN-2026-004 | Nebenkostenabrechnung Kopfsprünge | Neu | ADMIN |
...

User: ticket lindemann

Claude: *lädt Schnellreferenz*
*lädt Ticket SUPPORT-2025-008*
*liest Ordner /mnt/dieterhorst/Documents/Erinnerungen/Projekte/Poimer_Simone/Lindemann Michael/*

Ticket SUPPORT-2025-008: Lindemann Michael
Status: Warte auf Antwort
Kategorie: SUPPORT

Ordner-Inhalt:
- 000_DECKBLATT.rtf
- 251215 Mahnbescheid AG Hagen - 428 EUR.pdf
- Antrag auf Erlass eines Vollstreckungsbescheids - Übersicht.pdf
...

Letzte Aktion: Neuzustellungsantrag online eingereicht (31.12.2025)

Was soll ich tun?
```

---

## Notizen

- Ticket-Befehle sind keine Scripts, sondern Konventionen die ich befolge
- Schnellreferenz muss kurz bleiben (< 50 Zeilen) damit sie schnell geladen ist
- Bei Context-Wechsel: Automatisch Schnellreferenz + Praefrontaler_Cortex lesen
