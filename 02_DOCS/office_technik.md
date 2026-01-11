# Office-Projekt - Technische Dokumentation

**Stand:** 2026-01-06

---

## Projekt-Übersicht

| Info | Wert |
|------|------|
| Pfad | `/opt/office` |
| Frontend | SvelteKit + TailwindCSS |
| Backend | Express.js (integriert in SvelteKit) |
| Datenbank | SQLite (`/opt/office/data/`) |
| Service | `office.service` (systemd) |
| URL | https://192.168.42.253:3000 |

---

## Wichtige Pfade

```
/opt/office/
├── src/
│   ├── routes/           # SvelteKit Pages
│   │   ├── +page.svelte  # Landing (Erinnerungen)
│   │   ├── akten/        # Ticket-System
│   │   ├── schreiben/    # Schreibstube
│   │   ├── mail/         # E-Mail Client
│   │   ├── events/       # Event-System
│   │   └── api/          # API-Endpoints
│   └── lib/
│       ├── components/   # Svelte Components
│       └── server/       # Server-side Code
├── data/
│   ├── reminders-kategorisiert.json  # Erinnerungen
│   ├── akten/index.json              # Tickets
│   ├── schreibstube.db               # Bücher (SQLite)
│   └── box_dh/                       # Alexa/Scan-Watcher
└── scripts/                          # Hilfsskripte
```

---

## API-Endpoints

### Erinnerungen
- `GET /api/reminders` - Alle Erinnerungen
- `POST /api/reminders` - Erinnerung erstellen/updaten

### Akten/Tickets
- `GET /api/akten` - Alle Tickets
- `POST /api/akten` - Actions: create, update, add-note, update-folder

### Schreibstube
- `GET /api/books` - Alle Bücher
- `GET /api/books/[id]` - Einzelnes Buch mit Kapiteln
- `POST /api/books` - Buch erstellen
- `POST /api/chapters` - Kapitel erstellen/updaten
- `POST /api/roter-faden` - Roten Faden updaten

### Mail
- `GET /api/mail` - Mails abrufen (IMAP)
- `POST /api/mail/send` - Mail senden (SMTP)

---

## Schreibstube - Datenbank

SQLite: `/opt/office/data/schreibstube.db`

### Tabelle: books
| Feld | Typ | Beschreibung |
|------|-----|--------------|
| id | INTEGER | Primary Key |
| title | TEXT | Buchtitel |
| roter_faden | TEXT | KI-Gedächtnis pro Buch |
| created_at | DATETIME | Erstellt |

### Tabelle: chapters
| Feld | Typ | Beschreibung |
|------|-----|--------------|
| id | INTEGER | Primary Key |
| book_id | INTEGER | FK zu books |
| title | TEXT | Kapiteltitel |
| content | TEXT | Kapitelinhalt |
| position | INTEGER | Reihenfolge |

### Bücher-IDs
| ID | Titel |
|----|-------|
| 2 | Das 1. Compendium - Der dritte Weg |
| 5 | Das 2. Compendium - Selbstliebe |
| 6 | Die vergessene Natur des Menschen |
| 8 | Das 3. Compendium - Der Gottesbeweis |
| 9 | Das 4. Compendium - Die Maschine die fragt |
| 10 | Dieter und die KI |
| 11 | Charakterbuch - Der Autor (Biografie) |

---

## Ticket-System

JSON: `/opt/office/data/akten/index.json`

### Kategorien
- BUG, SUPPORT, FEATURE, ORDER, ADMIN

### Status-Werte
- Neu, In Bearbeitung, Warte auf Antwort, Erledigt

### Ticket anlegen (curl)
```bash
curl -s -k "https://localhost:3000/api/akten" -X POST \
  -H "Content-Type: application/json" \
  -d '{"action":"create","kategorie":"ADMIN","titel":"Titel","beschreibung":"Text","folder":"/Users/dieterhorst/Documents/Erinnerungen/ORDNER"}'
```

**WICHTIG:** Folder-Pfad mit `/Users/dieterhorst/` (Mac-Pfad, nicht /mnt/)

---

## Flutter iOS App

| Info | Wert |
|------|------|
| Server-Pfad | `/opt/office_app` |
| Mac-Pfad | `~/Developer/office_app` |
| Workflow | `/opt/office_app/WORKFLOW.md` |
| iPhone Device ID | `00008150-0008399E0EBA401C` |
| Team ID | `58LU7ZPY87` |

**Build:** Muss im lokalen Mac Terminal laufen (Keychain für Code Signing)

---

## Mount (Mac-Dateien)

- Quelle: `//192.168.42.17/dieterhorst`
- Ziel: `/mnt/dieterhorst`
- Credentials: `/root/.smbcredentials`

---

## Service-Befehle

```bash
sudo systemctl status office
sudo systemctl restart office    # NUR mit Erlaubnis!
cd /opt/office && npm run build
journalctl -u office -n 50       # Logs
```

---

## Audio-Tools

| Tool | Funktion | Pfad |
|------|----------|------|
| FluidSynth | MIDI→WAV | /usr/bin/fluidsynth |
| worker_noten.py | MP3→Noten | /opt/evy/02_automediaprocessor/ |
| Audiveris | Notenblatt→MIDI | /opt/evy/02_automediaprocessor/audiveris/ |
