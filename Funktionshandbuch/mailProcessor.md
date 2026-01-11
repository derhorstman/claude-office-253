# Mail-Prozessor

**Datei:** `/opt/office/src/lib/server/mailProcessor.ts`

---

## Funktion

KI-basierter Mail-Prozessor der eingehende Mails automatisch verarbeitet:

- **LÖSCHEN** - Server-Monitor ONLINE-Mails, Spam
- **ARCHIVIEREN** - Rechnungen, FRITZ!Box-Berichte
- **VERSCHIEBEN** - Newsletter, nach Kategorie sortieren
- **BEHALTEN** - Wichtige Mails in INBOX lassen
- **AKTE ERSTELLEN** - Support-Anfragen → neues Ticket

---

## Archiv-Ordner pro Account

Der Prozessor verwendet unterschiedliche Pfade je nach IMAP-Server:

| Account | Prefix | Separator | Beispiel |
|---------|--------|-----------|----------|
| iCloud | (leer) | `/` | `Archiv/Tech` |
| Gmail | (leer) | `/` | `Archiv/Tech` |
| Systemhaus (UDAG) | `INBOX.` | `.` | `INBOX.Archiv.Tech` |

### Unterordner

- Tech
- Gesundheit
- Finanzen
- Persoenlich
- Einkauefe
- Reisen

---

## Helper-Funktionen

### `getArchivePath(account, subfolder?)`

Baut den korrekten Archiv-Pfad für einen Account.

```typescript
getArchivePath(account)           // → "Archiv" oder "INBOX.Archiv"
getArchivePath(account, "Tech")   // → "Archiv/Tech" oder "INBOX.Archiv.Tech"
```

### `getAllArchiveFolders(account)`

Gibt alle Archiv-Ordner für einen Account zurück.

### `findArchiveSubfolder(searchText)`

Findet den passenden Unterordner basierend auf Keywords.

---

## Keyword-Zuordnung

```typescript
ARCHIVE_KEYWORDS = {
  'Finanzen': ['bank', 'paypal', 'versicherung', 'rechnung', ...],
  'Einkauefe': ['amazon', 'bestellung', 'lieferung', ...],
  'Reisen': ['eurowings', 'flug', 'hotel', 'booking', ...],
  'Gesundheit': ['dak', 'dexcom', 'apotheke', 'arzt', ...],
  'Tech': ['fritz', 'server', 'domain', 'hosting', ...],
  'Persoenlich': ['familie', 'hochzeit', 'privat', ...]
}
```

---

## API-Endpunkte

**Datei:** `/opt/office/src/routes/api/mail/process/+server.ts`

| Methode | Endpunkt | Funktion |
|---------|----------|----------|
| POST | `/api/mail/process` | Mails verarbeiten |
| GET | `/api/mail/process` | Status abrufen |
| GET | `/api/mail/process?action=rules` | Regeln anzeigen |
| GET | `/api/mail/process?action=log` | Log abrufen |
| PUT | `/api/mail/process` | Regel hinzufügen |
| DELETE | `/api/mail/process?ruleId=xxx` | Regel löschen |

### POST-Parameter

```json
{
  "account": "icloud",     // optional, sonst alle
  "dryRun": true,          // nur simulieren
  "limit": 20,             // max. Mails pro Account
  "allMails": false        // auch gelesene Mails
}
```

---

## Cronjob

**Script:** `/opt/office/scripts/mail-processor.sh`

Läuft alle 15 Minuten:

```bash
*/15 * * * * /opt/office/scripts/mail-processor.sh >> /opt/office/data/mail-cron.log 2>&1
```

---

## Regeln-Datei

**Pfad:** `/opt/office/data/mail-rules.json`

Speichert gelernte Regeln für automatische Zuordnung.

---

## Abhängigkeiten

- `imapService.ts` - IMAP-Verbindungen und Account-Konfiguration
- Anthropic API - Claude für KI-Entscheidungen
- Office API - Akten-Erstellung

---

## Änderungshistorie

| Datum | Änderung |
|-------|----------|
| 2026-01-06 | Archiv-Pfade dynamisch pro Account (Prefix/Separator) |
