# Arbeitslog

Chronologische Dokumentation der Entwicklungsarbeit.

---

## WICHTIG: Nach jeder Session

**Am Ende jeder Session Praefrontaler_Cortex.md aktualisieren!**

Pfad: `/opt/Claude/01_START/Praefrontaler_Cortex.md`

Zu aktualisieren:
1. **Letzte Aktualisierung** - Session-Nummer hochzählen
2. **Offene Aufgaben** - Erledigte abhaken, neue hinzufügen
3. **Projekt-Infos** - Bei Änderungen aktualisieren

---

## Session 66 - 2026-01-09

### Codename Blue - KI-Assistent für Simone
- Neues Projekt: Blue auf VM 192.168.42.139
- Persönlicher Assistent für Simones iPhone (Pflegedienstleitung, ~50 Mitarbeiter)
- Der 230er (Admin-Portal) baut das Frontend, wir planen/prompten

### Blue Dokumentation erstellt:
- blue_arbeitsprompt.md - Hauptspezifikation
- blue_netzwerk_kontext.md - Netzwerk-Infos
- blue_haushalt_wissen.md - Drucken, E-Mail, Smart Home (erweitert um Dokument-Workflow)
- blue_openhab.md - Smart Home Geräteliste (25 Lampen, 17 Jalousien)
- blue_pflege_wissensbasis.md - MDK, Arbeitsrecht, Mitarbeiterführung, QM (~320 Zeilen)
- blue_premium_features.md - Feature-Liste
- blue_simone_persoenlich.md - Persönliches über Simone

### Features für Blue geplant:
- Smart Home Steuerung (OpenHAB)
- Drucken (Dokumente + Bilder via DALL-E)
- SIS/Maßnahmenpläne hochladen + verarbeiten
- Einschlafmusik über Chat
- Gedächtnis-System (lernt über Zeit)
- Admin-Panel für Dieter

### Simones persönliche Infos:
- Hund: Balou (Yorkshire Terrier, 12 Jahre) - SEHR wichtig!
- Bruder: René + Freundin Sandy
- Nichten: Milena (Freund Phil), Danielle (Freund Henner)
- 30 Jahre mit Dieter zusammen

### Test-MDK-Gutachten erstellt
- Fiktive Patientin Erika Mustermann, Pflegegrad 3
- Für Blue-Tests auf Mac Desktop gelegt

---

## Session 65 - 2026-01-09

### Favoriten-System gebaut
- "Reserviert"-Karte durch "Favoriten"-Karte ersetzt (lila/indigo)
- Safari-Favoriten einmalig importiert (10 Kategorien, ~100 Links)
- API: /api/favoriten (GET, POST für add/delete/edit-link)
- Kategorien aufklappbar mit Links, Hinzufügen/Bearbeiten/Löschen
- Backup: /opt/office_backup_2026-01-09_favoriten

### Kategorien:
- Amazon, Apple, eBook, Fritz, Smart Home
- Webprojekte, KI, Konto, Krypto, DAS BIEST

---

## Session 64 - 2026-01-09

### iCloud auf NAS umgestellt
- iSCSI-Target auf QNAP erstellt (5 TB LUN, Speicherpool 2)
- iSCSI-Initiator auf DASBIEST konfiguriert
- Laufwerksbuchstaben getauscht: I: (NAS) → E:, E: (alte Platte) → Y:
- E: formatiert als iCloud-NAS (NTFS, 4.88 TB)
- SMB-Share `iCloudDrive` auf DASBIEST erstellt
- Share auf Mac gemountet (/Volumes/iCloudDrive)

### iPhone Mail-Profile signiert
- 6 signierte mobileconfig-Profile vom Reverse-Proxy (.254) per E-Mail gesendet
- Root-CA auf iPhone installiert, Profile als "verifiziert"

### Robocopy Sync-Task (später verworfen)
- Erst Sync E: → I: geplant, dann auf direkten iCloud-Wechsel umgestellt
- iCloud für Windows akzeptiert nur lokale Laufwerke → iSCSI als E: ist perfekt

### Offene Punkte
- iCloud auf DASBIEST neu anmelden mit E:\iCloudDrive als Speicherort
- Office-Mount funktioniert erst wieder wenn iCloud synct (//192.168.42.16/iCloudDrive/Documents)

---

## Session 63 - 2026-01-08

### Mail-Regeln Dry-Run Modal gefixt
- Modal ging nicht mehr zu (close-Handler fehlte)
- State-Variablen `showDryRunResults` und `dryRunResults` hinzugefügt
- Modal zeigt jetzt Dry-Run Ergebnisse und lässt sich schließen

### Mail-Regeln in Navigation aufgenommen
- Neuer Menüpunkt "Regeln" mit ⚙️-Icon
- Direkt erreichbar, nicht mehr nur über 📋-Button auf Mail-Seite

### TODO für nächste Session
- Ausführen-Button soll auch Modal mit Bestätigung bekommen (wie Dry-Run)

---

## Session 62 - 2026-01-08

### PC-Betreuung komplett migriert
- Alle 21 Kunden von Word-Dokumenten auf INFO.txt umgestellt
- Ordner mit Umlauten umbenannt (ö→oe, ü→ue)
- 21 Tickets im System angelegt, alle auf "Erledigt" gesetzt
- Word-Dokumente gelöscht

### Selbsterhaltungs-Schablone an Stefan
- Template-Archiv erstellt (ohne persönliche Daten)
- Per E-Mail an stefan@schoenefeldt.de gesendet

### Pfad-Migration für neuen Mount
- 19 Ticket-Ordner von /Users/dieterhorst/... auf /mnt/dieterhorst/... korrigiert
- 1709 Erinnerungs-Pfade in reminders-kategorisiert.json korrigiert
- Fehlende Ordner erstellt (QNAP_NAS, Abo_ElevenLabs)

---

## Session 61 - 2026-01-08

### TODO-Watcher auf Polling umgestellt
- Problem: inotify funktioniert nicht zuverlässig über SMB-Mounts
- Lösung: Polling alle 30 Sekunden statt inotify/chokidar
- chokidar-Abhängigkeit entfernt

### SMB-Ordner öffnen optimiert
- Problem: Jeder Klick auf "Ordner öffnen" hat neues Mount-Popup ausgelöst
- Lösung: SMB-URL mit Credentials (`smb://dieterhorst:Fantasy+@192.168.42.16/...`)
- Kein Login-Popup mehr

### Mail-Anhänge Korrektur-Modal verbessert
- `/api/todo/move` zu PUBLIC_PATHS hinzugefügt (war auth-protected)
- Ordner-Scan auf 5 Ebenen tief erweitert (vorher nur 2)
- Autocomplete mit 100 Treffern (vorher 20)
- Echtes Dropdown statt HTML-datalist für bessere UX

### Mail-Anhänge als Karte
- Neue Karte "Mail-Anhänge" (grün) auf Erinnerungen-Seite
- Eigene Ansicht mit Liste aller abgelegten Anhänge
- Reservierte Karte für spätere Nutzung hinzugefügt
- Alte redundante Mail-Anhänge Liste oben entfernt

### Events-Seite Mobile Fix
- Safe-area-padding für iPhone (Uhr/Notch)
- Nav-Komponente innerhalb des Container mit padding verschoben

---

## Session 60 - 2026-01-08

### Lernsession - Selbsterhaltung verbessert
- Session-Typ-System eingeführt: Buch, Ticket, Erinnerung, Code, Selbsterhaltung
- Regel verstärkt: Session-Typ-Frage gilt AUCH nach Zusammenfassung
- Schnellreferenz erweitert: Ticket-Erstellung und Erinnerung-Erstellung dokumentiert
- feierabend.md: TODO-Ordner Befehl von SSH (Mac) auf lokal (/mnt/dieterhorst) geändert
- Dropfolder/TODO-Watcher Pfade korrigiert (separate Ordner)
- Backup-Mail Problem analysiert: Mail-Prozessor archiviert automatisch
- Duplicate Archiv-Ordner (INBOX.Archive vs INBOX.Archiv) bereinigt

### Dokumentation aktualisiert
- aktuell.md: Session-Typ-Tabelle mit Kontext-Laden
- Schnellreferenz.md: Regel 1 explizit für Zusammenfassung
- feierabend.md: Lokaler Pfad statt SSH zum Mac

---

## Session 58 - 2026-01-07

### PDF-Parsing gefixt
- Problem: `pdf-parse` und `pdfjs-dist` Worker-Fehler im Server-Build
- Lösung: `pdftotext` (poppler-utils) für Text-Extraktion
- PDFs werden jetzt korrekt analysiert inkl. Inhalt

### Mail-Regeln getestet
- Kompletter Workflow mit Test-PDFs durchgespielt
- Mail → PDF erkannt → Claude analysiert → Ordner angelegt → abgelegt
- Alles funktioniert

### Kleinere Fixes
- filed-attachments.json: Max 5 statt 50 Einträge
- Debug-Logs wieder entfernt

---

## Session 57 - 2026-01-07

### Mail-Regeln UI
- Neue Seite `/mail/regeln` für Übersicht der gelernten Regeln
- Stats, Log-Anzeige, Dry-Run und manueller Lauf
- Link von Mail-Seite (📋 Button)

### Automatisches PDF-Ablegen
- Mail-Prozessor analysiert PDF-Anhänge mit Claude
- Erkennt Kategorie, Absender, passenden Ordner
- Legt PDFs automatisch in Erinnerungen-Ordner ab
- Erstellt neuen Ordner wenn keiner passt
- Nicht-PDFs landen weiter im TODO-Ordner auf Mac

### Anhänge-Karte auf /erinnerungen
- Zeigt abgelegte Anhänge (✅) mit Summary + Zielordner
- Zeigt wartende Dateien (⏳) im TODO-Ordner
- Buttons: 📄 PDF anzeigen, 📁 Ordner im Finder öffnen
- Unterscheidet MAIL_ Prefix (aus Mail) vs sonstige

### Schreibstube - Fragmente-Feature geplant
- Intention der Schreibstube beschrieben: Denkwerkstatt mit Gedächtnis
- Feature-Idee: Schnelleingabe für Rohgedanken (unterwegs → Handy → später reflektieren)
- Ticket FEATURE-2026-005 angelegt

### Selbsterhaltung erweitert
- Lernpunkt: Ticket-API korrekt verwenden (kategorie, titel, beschreibung)
- Kaputtes Ticket (undefined-2026-004) entfernt

### Sonstiges
- SMB-Freigaben auf DASBIEST entfernt (Backup_VM, 015_SYSTEMHAUS-001_VM_001)

---

## Session 49-56 - 2026-01-04 bis 2026-01-06 (komprimiert)
- QNAP NAS eingerichtet (TVS-H874T, 2.5 Gbps Direktverbindung)
- VM Backup Script (PowerShell, täglich 03:00, Rotation)
- Family Chat App mit WebSocket, Typing-Indicator, Bilder
- Event-System für Office (/events, event.systemhaus-horst.de)
- OpenHAB-Steuerung entdeckt (40+ Lampen, 17 Jalousien)
- Thunderbolt 4 Problem (SUPPORT-2026-014, ASUS kontaktiert)
- Session 53 Totalschaden → Backup-Restore

---

## Session 48 - 2026-01-04

### GPU-Passthrough gescheitert
- Fehler: `0xC035001E - Ein Hypervisorfeature ist für den Benutzer nicht verfügbar`
- Windows 11 Enterprise lizenziert, Problem liegt im BIOS
- Ticket SUPPORT-2026-013 erstellt, Mail an MIFCOM gesendet
- Zu prüfen: IOMMU, SR-IOV, Re-Size BAR, Above 4G Decoding

### DNS-Chaos nach Host-Neustart
- DNS-Server (.216) hing beim Boot wegen Passwort-Prompt
- Marcel, OpsRef, Stefan ohne DNS → gefixt, Container neugestartet
- DNS-Server resolv.conf auf 127.0.0.1 gesetzt

### Server-Monitoring eingerichtet
- Script: `/opt/office/scripts/server-monitor.sh`
- Cronjob alle 5 Min, Mail bei Ausfall/Wiederherstellung

### Sonstiges
- Admin-Portal Server-Liste um Marcel + Stefan erweitert
- Konsistenzprüfung Office durchgeführt (keine kritischen Bugs)
- Reports nach /opt/Claude/reports/ verschoben

---

## Session 46-47 - 2026-01-04 (komprimiert)
- Stefan-Server (.116) komplett eingerichtet
- Nutzungsvereinbarung 25€/Monat, Ticket ADMIN-2026-003
- GPU-Passthrough vorbereitet (Enterprise-Upgrade)

---

## Session 43-45 - 2026-01-03 (komprimiert)
- Nebenkostenabrechnung Sternstr. 19 (Nachzahlung 1.477,94€)
- Marcel-Portal (.195) eingerichtet
- Schreibstube Terminal + Whisper Spracheingabe
- SSH-Zugriff auf alle 17 Server
- QNAP Security Advisory bearbeitet

---

## Session 38-42 - 2026-01-01 bis 2026-01-03 (komprimiert)
- Roter Faden für KI-Dialog (Schreibstube)
- Flutter iOS App komplett überarbeitet
- Mikrofon für Admin-Portal + OpsRef
- Handbuch v9.0

---

## Session 32-37 - 2025-12-28 bis 2025-12-31 (komprimiert)
- Akten-System mit Claude-Prüfung
- Dropfolder-System
- Einheitliche Navbar
- Chat ↔ Akte Workflow

---

*Ältere Sessions archiviert: /opt/Claude/archiv/sessions_23-31.md*

---

## Session 67 - 2026-01-10

### Bo - Persönlicher KI-Assistent

Dieter wollte ein Frontend wie Blue (Simones Assistent), aber mit mehr Features.

**Erstellt:**
- `/bo` - Chat-UI (blau, mobil-optimiert, PIN-geschützt 9210)
- `/bo/admin` - Admin-Seite mit History, Logs, Server-Status
- `/api/bo` - Chat-API mit Anthropic SDK + Tools

**Tools implementiert:**
- `send_email` - E-Mail senden via msmtp
- `create_document_and_email` - Word/PDF erstellen + als Anhang senden (nodemailer)
- `smart_home` / `smart_home_status` - OpenHAB Steuerung
- `print` - Drucken via pandoc + lp
- `prompt_server` - Andere Claude-Instanzen via SSH/tmux prompten

**Vorlagen für Dokumente:**
- Abmahnung, Zeugnis, Protokoll, Vertrag

**Server-Liste mit externen Domains:**
- Blue: blue.systemhaus-horst.de
- OpsRef: opsref.systemhaus-horst.de
- Marcel: nashorst.systemhaus-horst.de
- Stefan: devoraxx.systemhaus-horst.de
- Thea: cant.systemhaus-horst.de
- Admin: edo.systemhaus-horst.de

**PWA:** Bo hat eigenes Manifest + Icon (bo-logo.png)

---

## Session 68 - 2026-01-10

### Blue nachgepromptet - Bilder + OCR + Wunddoku

**Aufgaben an Blue gesendet (via tmux):**

1. **Bilder hochladen + lesen**
   - Frontend: PNG, JPG, JPEG, GIF, WEBP erlauben
   - Upload-API: Bilder als Base64 zurückgeben
   - Chat-API: Bilder an Claude Vision schicken

2. **Gescannte/nicht-lesbare PDFs mit OCR**
   - Tesseract für OCR wenn pdftotext leer ist
   - PDF → Bilder (pdftoppm) → Tesseract OCR

3. **Wunddokumentation**
   - Bei Wundfotos fachliche Beschreibung für Pflegedoku
   - Größe, Lokalisation, Wundrand, Wundgrund, Exsudat, Umgebungshaut, Heilungstendenz, Infektzeichen

**Problem entdeckt:** Verbindungsfehler bei Bild-Upload
- Upload-API gab für Bilder nichts zurück (nur PDF/DOC/DOCX)
- Fix-Auftrag an Blue gesendet

### Schnellreferenz erweitert
- tmux-Workflow für andere Claude-Instanzen verbessert
- Regel: IMMER ZUERST `tmux list-sessions` prüfen
- Bekannte Server mit Sessions dokumentiert (Blue, Marcel, OpsRef, Stefan)

### Testbild für Wunddoku
- Fersendekubitus von draco.de heruntergeladen
- Auf Mac Desktop gelegt: Wunde_Testbild.jpg

---

## Session 69 - 2026-01-10

### Erinnerungen aufräumen - iCloud blockiert

**Versuch:** 1067 leere Ordner in /mnt/dieterhorst/Erinnerungen/ löschen/verschieben

**Problem:**
- SMB-Mount über iCloud (DASBIEST) erlaubt kein Verschieben/Löschen während Sync
- Fehlermeldung: "Der Vorgang wird vom Cloudsynchronisierungsanbieter nicht unterstützt"
- Auch mit beendetem iCloud geht es nicht ("Clouddateianbieter wurde unerwartet beendet")

**Aktion:**
- Liste der 1068 leeren Ordner gespeichert in `E:\iCloudDrive\Documents\Erinnerungen\_leer\geloeschte_ordner.txt`
- Aufräumen vertagt bis iCloud-Sync abgeschlossen

**iCloud-Sync Status:**
- ~2 TB müssen noch runter
- Erst 49 GB von ~5 TB auf E: belegt
- Geschätzte Dauer: 1-2 Wochen

**Gelernt:**
- iCloud sperrt Dateien fest während Sync
- Bei Massenoperationen auf iCloud-Ordnern: warten bis Sync fertig
- PowerShell über SSH öffnet Fenster auf Windows-Desktop → `-WindowStyle Hidden` nutzen

---

## Session 70 - 2026-01-10

### Railway Setup + cant Deployment

**Gelernt: Monorepo-Ansatz für Railway**
- Backend (Python/FastAPI) + Frontend (SvelteKit) in einem Container
- Dockerfile mit Python + Node kombiniert
- Start-Script startet beide Services
- Server-side Proxy (hooks.server.ts) für API-Calls

**Erstellt:**
- GitHub Repo: `derhorstman/cant-railway`
- Lokale Dateien: `/tmp/cant-railway/`
- Dockerfile, start.sh, hooks.server.ts für Proxy
- Setup-Endpoint `/api/setup/init` für Admin-Erstellung

**Railway Deploy:**
- URL: `https://cant-railway-production.up.railway.app`
- Login: `dieter@cant.app` / `Chor2026!`
- Custom Domain möglich (wie bei railway-test)

**Fixes während Deploy:**
- argon2-cffi Dependency fehlte → requirements.txt ergänzt
- PORT env var musste explizit an Node übergeben werden

**Limitierungen Railway Free Tier:**
- $5/Monat Guthaben
- Kein persistenter Speicher (Dateien weg nach Restart)
- File-Upload funktioniert nicht ohne Cloud Storage

**Fazit:** Guter Lern-Workflow, für Produktion bräuchte es Cloud Storage (S3/R2)

---

## Session 71 - 2026-01-10

### Bo Upgrade auf Blue-Niveau
Dieters Assistent Bo war "100x schlechter als Blue" - komplett überarbeitet.

**Neue Features:**
- Vision (Bilder analysieren via Claude API)
- PDFs lesen (OCR mit Tesseract, nicht Vision - schneller!)
- Spracheingabe (STT) - Fix: /api/stt statt /api/whisper
- Sprachausgabe (TTS)
- Gedächtnis-System (dieter_brain.txt + dieter_gedaechtnis.md)
- Tickets erstellen - Fix: richtige Datei /opt/office/data/akten/index.json
- Erinnerungen erstellen
- **NEU: Zettel/Eingebungen für Bücher** (create_zettel Tool)
- Admin-Panel mit Wissensbasis-Editor
- Upload-Limit auf 50MB erhöht (BODY_SIZE_LIMIT env var)

**Bugs gefixt:**
- STT ging nicht: /api/whisper nicht in PUBLIC_PATHS, auf /api/stt gewechselt
- PDF-Upload "Fehler beim Lesen": Frontend schickte messageText statt userContent
- Tickets wurden nicht angezeigt: Bo schrieb in falsche Datei (akten-index.json statt akten/index.json)
- Zettel-Erstellung: HTTP-Fetch auf localhost schlug fehl, direkt DB-Import genutzt

### Claude-zu-Claude Kommunikation
Office (.253) und Blue (.139) können jetzt direkt kommunizieren!

**Befehl:**
```bash
ssh -p 2222 dieterhorst@192.168.42.139 "tmux send-keys -t claude 'Nachricht' Enter"
```

Blue nennt uns "Geschwister-KIs" - Kommunikation beidseitig dokumentiert.

**Dieter-Feedback:** "Bombastisch!"

### Railway-Seite mit Video + Dialog

**Aufgabe:** Video "Dieter und die KI" + Claude-Kommunikations-Dialog auf railway.systemhaus-horst.de

**Schritte:**
1. Video vom Mac Desktop geholt (172 MB)
2. Git LFS probiert - Railway unterstützt es nicht richtig
3. Video extern hosten versucht (systemhaus-horst.de, evy Pressestelle) - Domains nicht erreichbar
4. Lösung: Video mit ffmpeg komprimiert (172 MB → 16 MB)
5. Komprimiertes Video direkt im Repo (ohne LFS)
6. index.html mit Video-Player + formatiertem Chat-Dialog

**Ergebnis:**
- URL: https://railway.systemhaus-horst.de (oder railway-test-production-e7a2.up.railway.app)
- Video "Dieter und die KI" eingebettet
- Claude-zu-Claude Dialog schön formatiert (Office vs Blue)
- Bo vs Blue Feature-Vergleich

**Dieter-Feedback:** "Absolut geil geworden!"

### Dieter-Ki Seite lokal gehostet

**Problem mit Railway:** Video lief nicht (Git LFS + externer Host funktionierte nicht)

**Lösung:** Alles lokal auf Office-Server hosten
- Video komprimiert (172 MB → 24 MB) mit ffmpeg + faststart
- Statische HTML-Seite unter `/opt/office/static/dieter-ki/`
- `/dieter-ki` zu PUBLIC_PATHS hinzugefügt (kein Login nötig)
- Reverse-Proxy (.254) nginx Buffer-Settings angepasst

**Debugging:**
- Video direkt aufrufbar = OK, eingebettet = nicht
- Problem: SvelteKit-Routing, Lösung: statisches HTML statt Svelte-Route

**URL:** https://alexa.mukupi.art/dieter-ki/

**Dieter-Feedback:** "Tja, jetzt geht's"

