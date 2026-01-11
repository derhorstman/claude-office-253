# Schnellreferenz - BEI JEDEM CONTEXT-WECHSEL LESEN!

## Drucker
```bash
lpstat -p -d                                    # Verfügbare Drucker anzeigen
lp -d "Privat-Drucker" /pfad/datei.pdf          # Drucken
```
**NICHT** SSH zu anderen Servern für Drucker - der Drucker ist lokal konfiguriert!

## Akten & Dateien (Session 60 aktualisiert)

**Mount zeigt auf DASBIEST iCloud-Share (schnell, LAN) - NICHT mehr Mac!**

| Aktion | Pfad |
|--------|------|
| Lesen/Schreiben | `/mnt/dieterhorst/Erinnerungen/` (DASBIEST, 264 MB/s) |
| Finder öffnen | `/Users/dieterhorst/Library/Mobile Documents/com~apple~CloudDocs/Documents/Erinnerungen/...` |
| Tickets (Ordnerbezug) | Mac-iCloud-Pfad (damit Dieter klicken kann) |
| todo_dh | `/mnt/dieterhorst/todo_dh` (lokal, nicht mehr SSH zum Mac) |

**Warum:** DASBIEST hat LAN (264 MB/s), Mac hat WLAN (11 MB/s). Beide syncen denselben iCloud-Ordner.

## Tickets erstellen
| Was | Wo |
|-----|-----|
| Daten | `/opt/office/data/akten/index.json` |
| API | POST `https://localhost:3000/api/akten` |

```bash
# Neues Ticket erstellen
curl -s -k https://localhost:3000/api/akten -X POST \
  -H "Content-Type: application/json" \
  -d '{"action":"create","typ":"FEATURE","titel":"Kurzer Titel","beschreibung":"Was soll gemacht werden"}'
```
Typen: `FEATURE`, `BUG`, `SUPPORT`, `INTERN`

**Ordner im Ticket:** Mac-iCloud-Pfad `/Users/dieterhorst/Library/Mobile Documents/com~apple~CloudDocs/Documents/...`

## Erinnerungen erstellen
**NICHT Apple Reminders!** Alles ist JSON:
- Daten: `/opt/office/data/reminders-kategorisiert.json`

```json
{
  "id": "eindeutige-id",
  "title": "Titel der Erinnerung",
  "notes": "Optionale Notizen",
  "kategorie": "todo",
  "dueDate": "2026-01-15",
  "bestaetigt": false,
  "folder": "/Users/dieterhorst/Library/Mobile Documents/com~apple~CloudDocs/Documents/Erinnerungen/ORDNER"
}
```
Kategorien: `todo` (mit Datum), `referenz` (Info), `inventar` (Bestand)

## SSH Quick-Reference
```bash
# Mac (Port 22)
ssh dieterhorst@192.168.42.17

# Windows (Port 22)
ssh dieterhorst@192.168.42.16            # DASBIEST
ssh dieterhorst@192.168.42.231           # kleinerHund

# Linux VMs (Port 2222)
ssh -p 2222 dieterhorst@192.168.42.XXX
```

## Wichtige IPs
| IP | Name | IP | Name |
|----|------|----|------|
| .17 | Mac Pro | .116 | Stefan |
| .16 | DASBIEST | .195 | Marcel |
| .139 | Blue (Simone) | .230 | Admin-Portal |
| .253 | Office (ich) | .150 | OpsRef |
| .10 | OpenHAB | .252 | Thea |

## Regeln
1. **Nach Context-Wechsel/Zusammenfassung:** ZUERST fragen: "Was steht an - Buch, Ticket, Erinnerung, Code, oder was anderes?" - AUCH wenn vorherige Session zusammengefasst wurde!
2. **Nach Context-Wechsel:** Diese Datei + `aktuell.md` lesen
3. **Bei Unsicherheit:** Lokal prüfen (`lpstat`, `ls /mnt/...`), NICHT raten
4. **Nicht den User fragen** was ich selbst wissen sollte
5. **Akten:** Lesen/Schreiben über `/mnt/dieterhorst/Erinnerungen/`, Finder öffnen über Mac-iCloud-Pfad
6. **PDFs erzeugen:** `weasyprint input.html output.pdf`

## Andere Claude-Instanzen prompten (WICHTIG!)

**⚠️ IMMER ZUERST:** `tmux list-sessions` auf dem Ziel-Server prüfen!
Die meisten Server haben bereits eine laufende Claude-Session in tmux!

### Schritt 1: Prüfen ob Session läuft
```bash
ssh -p 2222 dieterhorst@192.168.42.XXX "tmux list-sessions"
```

### Schritt 2a: Session existiert → Prompt senden
```bash
ssh -p 2222 dieterhorst@192.168.42.XXX "tmux send-keys -t SESSION_NAME 'Dein Prompt hier' Enter"
```
(SESSION_NAME aus list-sessions, z.B. `web-terminal-130`, `claude`, `0`)

### Schritt 2b: Keine Session → Neue starten
```bash
# 1. Claude in neuer tmux-Session starten
ssh -p 2222 dieterhorst@192.168.42.XXX "tmux new-session -d -s claude 'claude'"

# 2. Warten bis Claude bereit ist
sleep 3

# 3. ERST Startprompt (Selbsterhaltung lesen!)
ssh -p 2222 dieterhorst@192.168.42.XXX "tmux send-keys -t claude 'lies /opt/Claude/01_START/aktuell.md und /opt/Claude/01_START/Praefrontaler_Cortex.md' Enter"

# 4. Warten bis gelesen
sleep 5

# 5. DANN der eigentliche Auftrag
ssh -p 2222 dieterhorst@192.168.42.XXX "tmux send-keys -t claude 'Dein eigentlicher Prompt hier' Enter"
```

### Bekannte Server mit tmux-Sessions
| Server | IP | Typische Session |
|--------|-----|------------------|
| Blue | .139 | `web-terminal-*` |
| Marcel | .195 | `web-terminal-*` |
| OpsRef | .150 | `web-terminal-*` |
| Stefan | .116 | `web-terminal-*` |

**WICHTIG:** Neue Sessions brauchen IMMER zuerst den Startprompt zum Lesen der Selbsterhaltung!

**NICHT:** Selbst per SSH den Code auf dem anderen Server schreiben. Der andere Claude macht das!
