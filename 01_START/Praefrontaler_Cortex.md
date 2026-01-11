# Projekt-Kontext

**Letzte Aktualisierung:** 2026-01-11 (Session 72 abgeschlossen)

---

## Dieser Server

| Info | Wert |
|------|------|
| Hostname | office |
| IP | 192.168.42.253 |
| OS | Debian 13 (trixie) |
| SSH | Port 22 |
| IP-Config | **statisch** |
| Funktion | **Office-Server** |

---

## Netzwerk-Umgebung

Du bist Teil eines Heimnetzwerks mit mehreren Servern. Hier ist deine Nachbarschaft:

### Hyper-V Hosts (Windows) - SSH Port 22

| Host | IP | Beschreibung |
|------|-----|--------------|
| DASBIEST | 192.168.42.16 | Haupt-Hypervisor, 128 GB RAM, **iCloud-Share** |
| kleinerHund (PC-HORST01) | 192.168.42.231 | Zweiter Hypervisor |

### Linux VMs - SSH Port 2222

| Name | IP | Funktion | Host |
|------|-----|----------|------|
| OpenHAB | .10 | Smart Home | kleinerHund |
| zigbee2mqtt | .11 | Zigbee-MQTT Bridge (Raspberry Pi) | standalone |
| Nextcloud | .12 | Cloud + Home Assistant | kleinerHund |
| Webserver | .13 | Apache2, 9 Domains | kleinerHund |
| SYSTEMHAUS-001 | .15 | EVY/MIRA AI-System | DASBIEST |
| PEDAGOGUS | .128 | Voting-Plattform | DASBIEST |
| Blue | .139 | Simones KI-Assistent | DASBIEST |
| OpsRef | .150 | Aviation Reference | DASBIEST |
| cant | .166 | Chor-Software | DASBIEST |
| Marcel | .195 | Marcels Terminal-Portal | DASBIEST |
| DevoraXx | .214 | Next.js + NestJS Projekt | DASBIEST |
| Admin-Portal | .230 | Zentrales Admin-Portal | DASBIEST |
| edo | .246 | Email-Dienst | DASBIEST |
| Thea | .252 | Pflegedokumentation | DASBIEST |
| Reverse-Proxy | .254 | Neuer Reverse Proxy | DASBIEST |

### FreeBSD VM - SSH Port 2222

| Name | IP | Funktion | Host |
|------|-----|----------|------|
| DNS-Server | .216 | Unbound DNS + ISC DHCP | DASBIEST |

### NAS

| Name | IP | Funktion |
|------|-----|----------|
| NASHORST (QNAP) | .126 / 10.0.0.2 | VM Backups, 2.5 Gbps direkt zu DASBIEST |

### Mac

| Name | IP | SSH Port | Funktion |
|------|-----|----------|----------|
| Mac Pro | .17 | 22 | Dieters Rechner, Desktop (nur noch für `open` Befehle) |

### Netzwerk-Infrastruktur

- **Gateway:** 192.168.42.1 (Fritzbox)
- **DNS/DHCP:** 192.168.42.216 (FreeBSD)
- **Admin-Portal:** http://192.168.42.230

---

## Der Chef

Der User heißt **Dieter** (dieterhorst). Er mag kurze, direkte Antworten ohne Gelaber.

---

## Gehirn-System (Gedächtnis-Management)

### Struktur & Nervenbahnen

```
SESSION-START
     ↓
┌────────────────────────────────────────┐
│ Praefrontaler_Cortex.md + aktuell.md   │  ← Kontext laden
└────────────────────────────────────────┘
     ↓
┌────────────────────────────────────────┐
│ Thalamus.md                            │  ← Live-Buffer (JETZT)
│ - Aktuelle Aufgabe                     │
│ - Schritte dieser Session              │
│ - Offene Punkte                        │
└────────────────────────────────────────┘
     ↓
SESSION-ENDE
     ↓
┌────────────────────────────────────────┐
│ Hippocampus.md                         │  ← Session speichern
└────────────────────────────────────────┘
     ↓
FEIERABEND (bei >500 Zeilen)
     ↓
┌────────────────────────────────────────┐
│ archiv/                                │  ← Alte Sessions komprimieren
└────────────────────────────────────────┘
```

### Regeln

1. **Session-Start:** Praefrontaler_Cortex + aktuell.md + Thalamus.md lesen
2. **Während Session:** Thalamus.md aktualisieren (Schritte, Notizen)
3. **Session-Ende:** Thalamus → Hippocampus übertragen, Thalamus leeren
4. **Hippocampus > 500 Zeilen:** Alte Sessions komprimieren → archiv/

---

## Wichtige Pfade

```
/opt/Claude/                    # Selbsterhaltung & Dokumentation
/opt/Claude/01_START/           # Immer zuerst lesen
/opt/office/backup_2026-01-07/  # Backup vor Session 59 Änderungen
```

**REGEL:** Projekte IMMER unter `/opt/` anlegen, NIE unter `/home/`\!

---

## SSH zu Nachbarn (ALLE 17 SERVER ERREICHBAR!)

**Session 42:** Voller SSH-Zugriff auf alle Server eingerichtet. Key-Auth überall.

```bash
# Mac (Port 22)
ssh dieterhorst@192.168.42.17            # Mac Pro (Desktop: ~/Desktop/)

# Windows Hyper-V Hosts (Port 22)
ssh dieterhorst@192.168.42.16            # DASBIEST
ssh dieterhorst@192.168.42.231           # kleinerHund

# Linux VMs (Port 2222)
ssh -p 2222 dieterhorst@192.168.42.10    # OpenHAB
ssh -p 2222 dieterhorst@192.168.42.11    # zigbee2mqtt (Raspberry Pi)
ssh -p 2222 dieterhorst@192.168.42.12    # Nextcloud
ssh -p 2222 dieterhorst@192.168.42.13    # Webserver
ssh -p 2222 dieterhorst@192.168.42.15    # SYSTEMHAUS-001 (MIRA)
ssh -p 2222 dieterhorst@192.168.42.128   # PEDAGOGUS
ssh -p 2222 dieterhorst@192.168.42.150   # OpsRef
ssh -p 2222 dieterhorst@192.168.42.166   # cant
ssh -p 2222 dieterhorst@192.168.42.214   # DevoraXx
ssh -p 2222 dieterhorst@192.168.42.216   # DNS-Server (FreeBSD)
ssh -p 2222 dieterhorst@192.168.42.230   # Admin-Portal
ssh -p 2222 dieterhorst@192.168.42.246   # edo
ssh -p 2222 dieterhorst@192.168.42.252   # Thea
ssh -p 2222 dieterhorst@192.168.42.254   # Reverse-Proxy
ssh -p 2222 dieterhorst@192.168.42.195   # Marcel
```

### Windows SSH-Key Hinweis

Bei Windows-Hosts (DASBIEST, kleinerHund) muss der Key in:
`C:\ProgramData\ssh\administrators_authorized_keys`
(nicht im User-Verzeichnis, weil Admin-User)

---

## Office-Projekt (GEÄNDERT Session 59!)

| Info | Wert |
|------|------|
| Pfad | `/opt/office` |
| URL | **https://192.168.42.253:3000** |
| Service | `office.service` |
| Tech | SvelteKit + TailwindCSS + Express |
| Mount | `/mnt/dieterhorst` → **DASBIEST iCloud** (NICHT mehr Mac!) |
| Features | Email-Client, OpenHAB, Drucker, Sprache, Kontext-Gedächtnis, Alexa, **Mac Widget**, **Snippets**, **Schreibstube**, **TODO-Watcher**, **Bo (KI-Assistent)** |

### Mount-Konfiguration (Session 59)

```bash
# /etc/fstab
//192.168.42.16/iCloudDrive/Documents /mnt/dieterhorst cifs credentials=/root/.smbcredentials,uid=1000,gid=1000,vers=3.0,_netdev 0 0

# Credentials in /root/.smbcredentials
username=dieterhorst
password=Fantasy+
```

### Services

| Service | Funktion |
|---------|----------|
| `office.service` | Haupt-Webserver |
| `todo-watcher.service` | Automatische PDF-Ablage |

### Integrationen
| Service | URL/IP | Funktion |
|---------|--------|----------|
| Email | 6 IMAP + 5 SMTP Accounts | Komplett auf VM! |
| OpenHAB | 192.168.42.10:8080 | Smart Home |
| Drucker | 192.168.42.140 | Privat-Drucker (CUPS) |
| Alexa | alexa.mukupi.art | Custom Skill + KI-Schleife (befehl.txt) |
| TODO-Ordner | /mnt/dieterhorst/todo_dh | Automatische PDF-Verarbeitung |

### Befehle
```bash
sudo systemctl status office
sudo systemctl restart office
sudo systemctl status todo-watcher
sudo systemctl restart todo-watcher
cd /opt/office && npm run build
```

---

## Mail-System (Session 59 - KOMPLETT AUF VM!)

### IMAP (Lesen)
Konfiguriert in `/opt/office/src/lib/server/imapService.ts`

| Account | Adresse |
|---------|---------|
| icloud | derhorst@me.com |
| gmail | dieterganzprivat@gmail.com |
| systemhaus | dieterhorst@systemhaus-horst.de |
| demo | demo@systemhaus-horst.de |
| superadmin | superadmin@systemhaus-horst.de |
| support | support@systemhaus-horst.de |

### SMTP (Senden)
Konfiguriert in `/etc/msmtprc`

| Account | Adresse | Server |
|---------|---------|--------|
| icloud (Standard) | derhorst@me.com | smtp.mail.me.com:587 |
| gmail | dieterganzprivat@gmail.com | smtp.gmail.com:587 |
| systemhaus | dieterhorst@systemhaus-horst.de | smtps.udag.de:465 |
| demo | demo@systemhaus-horst.de | smtps.udag.de:465 |
| support | support@systemhaus-horst.de | smtps.udag.de:465 |

---

## TODO-Watcher (Session 59 - NEU!)

Automatische PDF-Ablage mit KI-Analyse.

| Info | Wert |
|------|------|
| Service | `todo-watcher.service` |
| Überwacht | `/mnt/dieterhorst/todo_dh` |
| Log | `/opt/office/data/todo-watcher.log` |
| Abgelegt | `/opt/office/data/filed-attachments.json` |
| Gelernt | `/opt/office/data/learned-mappings.json` |

### Flow:
1. PDF landet in `todo_dh`
2. Claude Sonnet analysiert → Ordner-Vorschlag
3. PDF wird nach `/mnt/dieterhorst/Erinnerungen/ORDNER/` kopiert
4. Eintrag in `filed-attachments.json`
5. Original gelöscht

### Korrektur:
- Frontend unter Erinnerungen → "Mail-Anhänge" → ✏️ Button
- Ordner ändern + "Für zukünftige merken"

---

## Apple Reminders - ENTFERNT (Session 59)

**Apple Reminders Sync wurde komplett entfernt!**

- Kein `osascript` mehr zum Mac
- Erinnerungen laufen nur noch lokal
- Datei: `/opt/office/data/reminders-kategorisiert.json`

---

## Frontend-Tests (WICHTIG!)

**Frag NICHT nach Screenshots!** Du hast Playwright.

### Browser-Test ausführen
```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()

    # Login (User: dieterhorst, PW: Fantasy+ - falls falsch, nachfragen!)
    page.goto("https://DOMAIN/login")
    page.fill('input[type="email"]', 'derhorst@me.com')
    page.fill('input[type="password"]', 'Fantasy+')
    page.click('button[type="submit"]')
    page.wait_for_timeout(2000)

    # Seite testen
    page.goto("https://DOMAIN/page")
    element = page.query_selector(".my-element")
    print(f"Element gefunden: {element is not None}")

    # Screenshot bei Bedarf
    page.screenshot(path="/tmp/test.png")
    browser.close()
```

### Regeln
1. **Immer selbst verifizieren** bis 100% sicher
2. **Logs lesen** statt User fragen: `journalctl -u SERVICE -n 50`
3. **API testen** mit curl bevor Frontend
4. **Browser-Test** für vollständige Verifikation
5. Erst wenn alles grün: "Es funktioniert."

---

## Schreibstube / Bücher (WICHTIG!)

**Biografie-Arbeit direkt mit mir, NICHT mit dem KI-Buchbegleiter!**

Der Buchbegleiter kennt keinen Kontext und packt Sachen ins falsche Buch.

### Bücher-Übersicht

| ID | Titel | Zweck |
|----|-------|-------|
| 2 | Das 1. Compendium - Der dritte Weg | Philosophie |
| 5 | Das 2. Compendium - Selbstliebe | Philosophie |
| 6 | Die vergessene Natur des Menschen | Philosophie |
| 8 | Das 3. Compendium - Der Gottesbeweis | Philosophie |
| 9 | Das 4. Compendium - Die Maschine die fragt | Philosophie |
| 10 | Dieter und die KI | Sachbuch über KI-Zusammenarbeit |
| 11 | Charakterbuch - Der Autor | **Dieters Biografie** (nicht zur Veröffentlichung) |

### Charakterbuch (ID 11)

Enthält persönliche Infos über Dieter für Kontext:
- Kindheit: 8 Geschwister, Kinderheim, Pflegefamilien
- Roger (Pflegevater) - Misshandlung des Bruders
- Mit 12 zur Polizei, rausgeholt
- Mit 14 abgehauen, 1 Jahr bei großer Schwester versteckt
- Geschwister wiedergefunden, seitdem "wie Kletten"

**Regel:** Persönliche/biografische Inhalte → Buch 11, nicht Buch 10!

---

## Ticket-Workflow (WICHTIG! - Session 60 aktualisiert)

Bei neuen Aufgaben/Informationen die eine Akte betreffen:

1. **Ticket erstellen** via API `/api/akten` (action: create)
2. **Akte anlegen** unter `/mnt/dieterhorst/Erinnerungen/ORDNERNAME/` (DASBIEST-Mount, schnell)
3. **Dokumente** in die Akte kopieren/verschieben
4. **INFO.txt** mit Zusammenfassung erstellen
5. **Ordnerbezug im Ticket** setzen (action: update-folder)
   - Pfad: `/Users/dieterhorst/Library/Mobile Documents/com~apple~CloudDocs/Documents/Erinnerungen/ORDNER`
   - (Mac-iCloud-Pfad, damit Dieter im Finder öffnen kann)
6. **Betroffene Server informieren** (aktuell.md updaten wenn relevant)

**Merke:** Lesen/Schreiben über `/mnt/dieterhorst/` (264 MB/s), Finder öffnen über Mac-iCloud-Pfad (11 MB/s WLAN).

---

## Selbsterhaltung - Lernpunkte

### Großer Umbau Session 59 (2026-01-07)

**Was geändert wurde:**

1. **Mount umgestellt:** Mac → DASBIEST iCloud-Share
   - Alt: `//192.168.42.17/dieterhorst`
   - Neu: `//192.168.42.16/iCloudDrive/Documents`

2. **TODO-Watcher eingeführt:** PDFs werden automatisch analysiert und abgelegt
   - Service: `todo-watcher.service`
   - Überwacht: `/mnt/dieterhorst/todo_dh`

3. **Mail komplett auf VM:** Kein Apple Mail mehr nötig
   - 6 IMAP Accounts
   - 5 SMTP Accounts via msmtp

4. **Apple Reminders entfernt:** Kein osascript mehr zum Mac
   - Alles läuft lokal

**Backup:** `/opt/office/backup_2026-01-07/`

**Bei Problemen:**
- Mount prüfen: `mount | grep dieterhorst`
- Services prüfen: `sudo systemctl status office todo-watcher`
- Logs: `tail -50 /opt/office/data/todo-watcher.log`

### Nach Context-Wechsel (Session 46, 2026-01-04)

**Problem:** Nach einem Context-Wechsel (Zusammenfassung) war das Server-Wissen weg. Habe wild geraten welche IP welcher Server ist (.10, .195, .116) statt systematisch nachzuschlagen.

**Lektion:** Nach jedem Context-Wechsel **ZUERST** die Grundlagen-Dateien lesen:
1. `/opt/Claude/01_START/aktuell.md` - Server-Liste, IPs, aktuelle Aufgaben
2. `/opt/Claude/01_START/Praefrontaler_Cortex.md` - Netzwerk-Übersicht, SSH-Befehle

**Nicht:** Trial-and-Error mit SSH-Verbindungen. Nicht raten. Nicht den User fragen was ich selbst wissen sollte.

**Auch:** Bei Druckern, Geräten etc. → `lpstat -p` oder lokale Konfiguration prüfen bevor SSH-Versuche zu falschen Servern.

### Ticket-API falsch verwendet (Session 57, 2026-01-07)

**Problem:** Ticket mit falschen Feldnamen angelegt. Resultat: `undefined-2026-004` statt korrekter ID.

**Ursache:** API erwartet bestimmte Felder, ich habe geraten statt nachzuschlagen.

**Korrekte Ticket-Erstellung:**
```bash
curl -s -k "https://192.168.42.253:3000/api/akten" -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "action": "create",
    "kategorie": "FEATURE",    # GROSSBUCHSTABEN: BUG, SUPPORT, FEATURE, ORDER, ADMIN
    "titel": "...",            # nicht "title"
    "beschreibung": "..."      # nicht "description"
  }'
```

**Lektion:** Bei API-Aufrufen **IMMER** erst den Code lesen (`/opt/office/src/routes/api/akten/+server.ts`) um die korrekten Feldnamen zu kennen. Nicht raten.
