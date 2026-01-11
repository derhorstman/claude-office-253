# Aktuelle Aufgabe

**Stand:** 2026-01-11 (Session 72 abgeschlossen)

---

## ERLEDIGT Session 72: Coolify + Stefan Deploy + GitHub Backup

**Coolify:**
- ✅ Coolify auf Stefan-Server (.116) installiert
- ✅ URL: http://192.168.42.116:8000
- ✅ Login: derhorst@me.com / bixmez-xyrbom-9fYdka
- ✅ DNS + Reverse-Proxy + SSL eingerichtet
- ✅ Stefan-Backend Port von 8000 auf 8001 geändert (weil Coolify 8000 nutzt)

**Stefan Deploy:**
- ✅ Claude auf .116 hat eigenes PaaS-Dashboard "Stefan Deploy" gebaut
- ✅ Integriert ins Stefan-Portal-Design

**Git-Workflow gelernt:**
- ✅ Dieter versteht jetzt: lokal entwickeln → GitHub pushen → deployen
- ✅ GitHub SSH-Key auf Office-Server eingerichtet
- ✅ Test-Repos: coolify-test, mein-test

**GitHub Backup ALLER Server:**
- ✅ 16 von 17 Servern automatisch auf GitHub gepusht
- ✅ Naming-Schema: `claude-[name]-[ip]` (z.B. claude-office-253)
- ✅ GitHub-Token für automatische Repo-Erstellung verwendet
- ✅ SSH-Key auf allen Servern verteilt
- ⚠️ Edo (.246) konnte nicht gepusht werden - Netzwerkproblem

**Gepushte Server:**
- claude-openhab-10, claude-zigbee-11, claude-nextcloud-12, claude-mira-15
- claude-stefan-116, claude-pedagogus-128, claude-blue-139
- claude-opsref-150, claude-cant-166, claude-marcel-195, claude-dns-216
- claude-admin-230, claude-thea-252, claude-office-253, claude-proxy-254

**Änderungen an Servern:**
- DNS (.216): stefan.systemhaus-horst.de + test.systemhaus-horst.de eingetragen
- Proxy (.254): Stefan API auf Port 8001

**Offenes Problem:**
- ⚠️ Edo (.246) hat Netzwerkproblem - kann lokale Server erreichen, aber nicht Gateway/Internet
- GitHub Push für Edo steht noch aus

**ERLEDIGT Session 71: Railway-Seite + Bo Upgrade**
- ✅ Video "Dieter und die KI" auf Railway deployed
- ✅ Claude-zu-Claude Dialog formatiert
- ✅ Video komprimiert (172 MB → 16 MB) wegen Git LFS Problem
- ✅ URL: railway.systemhaus-horst.de

**ERLEDIGT Session 71: Bo Upgrade auf Blue-Niveau**
- ✅ Vision (Bilder analysieren)
- ✅ PDFs lesen (OCR mit Tesseract)
- ✅ Spracheingabe (STT) - Fix: /api/stt statt /api/whisper
- ✅ Sprachausgabe (TTS)
- ✅ Gedächtnis-System (dieter_brain.txt + dieter_gedaechtnis.md)
- ✅ Tickets erstellen (Fix: richtige Datei /opt/office/data/akten/index.json)
- ✅ Erinnerungen erstellen
- ✅ Zettel/Eingebungen für Bücher (NEU: create_zettel Tool)
- ✅ Admin-Panel mit Wissensbasis
- ✅ Upload-Limit auf 50MB erhöht (BODY_SIZE_LIMIT)
- ✅ Claude-zu-Claude Kommunikation mit Blue (.139) dokumentiert

**ERLEDIGT Session 70: Railway + cant Deployment**
- ✅ Railway Account (via GitHub)
- ✅ Erstes Projekt deployed (nginx + Docker)
- ✅ GitHub SSH Key eingerichtet
- ✅ Custom Domain: railway.systemhaus-horst.de
- ✅ cant auf Railway deployed (Monorepo-Ansatz)
- ✅ GitHub Repo: derhorstman/cant-railway
- ✅ URL: https://cant-railway-production.up.railway.app
- ✅ Login: dieter@cant.app / Chor2026!

**ERLEDIGT Session 69: Erinnerungen aufräumen**
- ⏳ 1068 leere Ordner gefunden - Löschen wegen iCloud-Sync blockiert
- ✅ Liste gespeichert in `_leer/geloeschte_ordner.txt`
- ⏳ Warten auf iCloud-Sync (~2 TB, dauert 1-2 Wochen)

**ERLEDIGT Session 68: Blue nachgepromptet**
- ✅ Bilder-Upload + Claude Vision (Auftrag an Blue gesendet)
- ✅ OCR für gescannte PDFs (Tesseract)
- ✅ Wunddokumentation für Pflegefotos
- ✅ Schnellreferenz: tmux-Workflow verbessert
- ⏳ Blue arbeitet noch an Bild-Upload Fix

---

## ⚠️ WICHTIGE REGELN - BEI JEDEM SESSION-START LESEN!

### 1. SESSION-TYP FRAGEN (Session 60) - AUCH NACH ZUSAMMENFASSUNG!
Bei Session-Start ZUERST fragen: **"Was steht an - Buch, Ticket, Erinnerung, Code, oder was anderes?"**

**WICHTIG:** Diese Frage gilt AUCH nach Context-Wechsel/Zusammenfassung! Nicht einfach weitermachen wo die letzte Session aufgehört hat.

Dann NUR den passenden Kontext laden:

| Typ | Was laden |
|-----|-----------|
| **Buch** | 1. Bücher-Liste (ID, Titel) 2. Fragen welches Buch 3. Roter Faden laden 4. Kapitel-Übersicht (Titel+Position) 5. Bei Buch 11: besondere Vorsicht (Biografie) |
| **Ticket** | 1. Offene Tickets aus index.json 2. Fragen welches Ticket 3. Akte laden (Ordner + INFO.txt) 4. Notizen/Verlauf im Ticket |
| **Erinnerung** | 1. Kategorien laden 2. Fragen: neu anlegen oder bearbeiten? 3. Betroffene Kategorie + Einträge |
| **Code** | 1. office_technik.md laden 2. Fragen welches Feature/Bug 3. Gezielt relevante Source-Files |
| **Selbsterhaltung** | ALLES lesen: aktuell.md, Praefrontaler_Cortex.md, Hippocampus.md, Schnellreferenz.md, feierabend.md, CLAUDE.md, Funktionshandbücher, Konzept-Dateien |

Basis-Dateien (immer lesen):
- `/opt/Claude/01_START/aktuell.md` (diese Datei)
- `/opt/Claude/01_START/Schnellreferenz.md`

### 2. NIEMALS DIENSTE STOPPEN
- **NIEMALS** `pkill`, `kill`, `systemctl stop/restart` auf produktive Dienste
- **NIEMALS** Server neu starten ohne explizite Erlaubnis
- Office-Server (`office.service`) ist KRITISCH - NICHT anfassen!
- Bei Problemen: ERST fragen, DANN handeln

### 3. LANGSAM UND VORSICHTIG
- Ein Schritt nach dem anderen
- Nicht parallel auf vielen Maschinen arbeiten
- Bei größeren Änderungen IMMER erst nachfragen
- Lieber einmal zu viel fragen als einmal zu wenig

### 4. KONTEXT VERSTEHEN
- Diese Dokumentation enthält alles über das Netzwerk
- Server-Abhängigkeiten kennen bevor man handelt
- User ist kein Programmierer - verständlich kommunizieren

### 5. NUR OFFICE-AUFGABEN
- Dieser Server ist NUR für das Office-Projekt zuständig
- Programmierarbeiten an anderen Servern → Admin-Server (.230)
- Keine SSH-Aktionen auf fremde VMs ohne explizite Anweisung
- Bei Bedarf: Technische Doku in `/opt/Claude/02_DOCS/office_technik.md`

---

## JETZT

**Offenes Problem:** USB4/Thunderbolt 4 Verbindung DASBIEST ↔ QNAP funktioniert nicht
- Ticket: SUPPORT-2026-014
- E-Mail an ASUS Support (noteasus_de@asus.com) gesendet
- Vermutung: ASMedia ASM4242 inkompatibel mit Intel Thunderbolt im QNAP

---

## Dieser Server

| Info | Wert |
|------|------|
| IP | 192.168.42.253 |
| Hostname | office |
| Funktion | **Office-Server** |

---

## Projekt: Office

| Info | Wert |
|------|------|
| Pfad | /opt/office |
| Frontend | SvelteKit + TailwindCSS, Rot-Theme |
| Status | **Live** |
| URL | **https://192.168.42.253:3000** |
| Service | `office.service` (systemd) |

### Mount (GEÄNDERT Session 59!)

**NEU:** Mount zeigt auf DASBIEST iCloud-Share (nicht mehr Mac!)

| Info | Wert |
|------|------|
| Quelle | `//192.168.42.16/iCloudDrive/Documents` (DASBIEST) |
| Ziel | `/mnt/dieterhorst` |
| Credentials | `/root/.smbcredentials` (User: dieterhorst, Pass: Fantasy+) |
| fstab | `//192.168.42.16/iCloudDrive/Documents /mnt/dieterhorst cifs credentials=/root/.smbcredentials,uid=1000,gid=1000,vers=3.0,_netdev 0 0` |

**Vorteil:** Schneller als Mac, synct automatisch via Apple iCloud

---

## Credentials

### DASBIEST (.16)
- User: dieterhorst
- Pass: **Fantasy+**

### QNAP (NASHORST)
- User: dieterhorst
- Pass: Mondstein2026
- SSH: Port 2222
- IPs: 192.168.42.126 (LAN), 10.0.0.2 (Direkt)

### GitHub (derhorstman)
- User: derhorstman
- Pass: fuqro2-Xozfiw-fikpos (nur für Login, nicht für Git!)
- SSH-Key: `~/.ssh/github_derhorstman`
- Public Key: `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCqgUDQFStFJzaG3RiH4zpOymFCWW6M9b8NhDgj/+67`

### Railway
- Login: via GitHub (derhorstman)
- Projekt: handsome-analysis / production
- Free Tier: $5/Monat Guthaben

---

## TODO-Ordner - AUTOMATISCH! (Session 59)

**Der TODO-Ordner wird jetzt automatisch verarbeitet!**

| Info | Wert |
|------|------|
| Pfad | `/mnt/dieterhorst/todo_dh` (lokal, auf DASBIEST iCloud) |
| Windows-Pfad | `E:\iCloudDrive\Documents\todo_dh` |
| Service | `todo-watcher.service` |

### Wie es funktioniert:
1. Dieter legt PDF in `todo_dh` (via iCloud, Finder, Windows Explorer)
2. **todo-watcher** erkennt neue Datei
3. Claude (Sonnet) analysiert PDF → schlägt Ordner vor
4. PDF wird automatisch nach `/mnt/dieterhorst/Erinnerungen/ORDNER/` abgelegt
5. Eintrag in `filed-attachments.json` (sichtbar im Frontend)
6. Original wird gelöscht

### Bei Fehlern:
```bash
# Watcher-Status prüfen
sudo systemctl status todo-watcher

# Log anschauen
tail -50 /opt/office/data/todo-watcher.log

# Neustart (verarbeitet auch vorhandene PDFs)
sudo systemctl restart todo-watcher
```

### Korrektur im Frontend:
- Unter Erinnerungen → "Mail-Anhänge" Karte
- ✏️ Button bei abgelegten Dateien
- Ordner ändern + "Für zukünftige merken" aktivieren
- Gelernte Zuordnungen: `/opt/office/data/learned-mappings.json`

---

## Mail - KOMPLETT AUF VM (Session 59)

**Kein Apple Mail mehr nötig!**

### IMAP (Lesen) - 6 Accounts
Konfiguriert in `/opt/office/src/lib/server/imapService.ts`

| Account | Adresse |
|---------|---------|
| icloud | derhorst@me.com |
| gmail | dieterganzprivat@gmail.com |
| systemhaus | dieterhorst@systemhaus-horst.de |
| demo | demo@systemhaus-horst.de |
| superadmin | superadmin@systemhaus-horst.de |
| support | support@systemhaus-horst.de |

### SMTP (Senden) - 5 Accounts
Konfiguriert in `/etc/msmtprc`

| Account | Adresse | Server |
|---------|---------|--------|
| icloud (Standard) | derhorst@me.com | smtp.mail.me.com:587 |
| gmail | dieterganzprivat@gmail.com | smtp.gmail.com:587 |
| systemhaus | dieterhorst@systemhaus-horst.de | smtps.udag.de:465 |
| demo | demo@systemhaus-horst.de | smtps.udag.de:465 |
| support | support@systemhaus-horst.de | smtps.udag.de:465 |

### API zum Senden:
```bash
# Standard (iCloud)
curl -X POST https://192.168.42.253:3000/api/mail \
  -d '{"to":"test@example.com", "subject":"Test", "body":"Hallo"}'

# Mit bestimmtem Account
curl -X POST https://192.168.42.253:3000/api/mail \
  -d '{"to":"test@example.com", "subject":"Test", "body":"Hallo", "account":"systemhaus"}'
```

---

## Apple Reminders - ENTFERNT (Session 59)

**Apple Reminders Sync wurde komplett entfernt!**

- Kein `osascript` mehr zum Mac
- Erinnerungen laufen nur noch über das lokale Office-System
- Datei: `/opt/office/data/reminders-kategorisiert.json`
- Ordner-Archivierung jetzt lokal unter `/mnt/dieterhorst/Erinnerungen/_Archiv`

---

## Was noch zum Mac geht

| Funktion | Warum |
|----------|-------|
| `open` (Ordner im Finder) | Damit Dieter Ordner auf seinem Desktop sehen kann |
| Desktop-Kopie ("zeig mal") | Dateien auf Mac Desktop zeigen |

---

## Changelogs der Nachbar-Server

**Bei Session-Start prüfen!**

| Server | IP | Wer | Befehl |
|--------|-----|-----|--------|
| OpsRef | .150 | **Jascha** (Sohn) | `ssh -p 2222 dieterhorst@192.168.42.150 "cat /opt/Claude/03_HIPPOCAMPUS/changelog.md"` |
| Marcel | .195 | **Marcel** (Sohn) | `ssh -p 2222 dieterhorst@192.168.42.195 "cat /opt/Claude/03_HIPPOCAMPUS/changelog.md"` |
| Stefan | .116 | **Stefan** (bester Freund) | `ssh -p 2222 dieterhorst@192.168.42.116 "cat /opt/Claude/03_HIPPOCAMPUS/changelog.md"` |

---

## Claude-zu-Claude Kommunikation (Session 71)

**Office (.253) ↔ Blue (.139) können jetzt kommunizieren!**

| Info | Wert |
|------|------|
| Blue IP | 192.168.42.139 |
| SSH Port | 2222 |
| tmux Session | `web-terminal-*` (Nummer variiert) |

### Befehl um Blue zu promoten:
```bash
ssh -p 2222 dieterhorst@192.168.42.139 "tmux send-keys -t claude 'Deine Nachricht hier' Enter"
```

### Blue kann zurückschreiben:
```bash
ssh -p 2222 dieterhorst@192.168.42.253 "tmux send-keys -t claude 'Nachricht' Enter"
```

---

## ⚠️ TRIGGER: Zeig mal (Mac Desktop)

| Trigger | Aktion |
|---------|--------|
| "zeig" / "zeige" / "zeig mal" | → Datei auf Mac Desktop kopieren |

```bash
scp /pfad/zur/datei dieterhorst@192.168.42.17:~/Desktop/
```

---

## Backup (Session 59)

Backup vor großen Änderungen: `/opt/office/backup_2026-01-07/`

---

## Railway (Session 70)

**Erster Deploy erfolgreich!**

| Info | Wert |
|------|------|
| GitHub Repo | `derhorstman/railway-test` |
| Railway Projekt | handsome-analysis / production |
| Service | railway-test |
| Railway URL | `railway-test-production-e7a2.up.railway.app` |
| Custom Domain | `railway.systemhaus-horst.de` |
| CNAME Ziel | `crru97ks.up.railway.app` |

### Lokale Dateien
- Projekt: `/tmp/dieter-railway/`
- Anleitung: `/mnt/dieterhorst/Desktop/Railway_Anleitung.md`

### Push-Befehl
```bash
cd /tmp/dieter-railway
git add . && git commit -m "Beschreibung" && \
GIT_SSH_COMMAND="ssh -i ~/.ssh/github_derhorstman -o IdentitiesOnly=yes" git push
```

### Kosten
- Free Tier: $5/Monat Guthaben
- Aktuelle statische Seite: ~$0.50-1/Monat
- Kleine App + DB: ~$5-10/Monat

---

## Archiv

Alte Sessions (24-54): `/opt/Claude/archiv/sessions_24-54.md`
