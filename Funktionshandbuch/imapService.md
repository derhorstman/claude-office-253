# IMAP Service

**Datei:** `/opt/office/src/lib/server/imapService.ts`

---

## Funktion

Multi-Account IMAP-Service mit persistenten Verbindungen:

- **Mehrere Mail-Accounts** gleichzeitig verwalten
- **Persistente Verbindung** pro Account
- **IDLE-Modus** für Push-Updates (Echtzeit)
- **Auto-Reconnect** bei Verbindungsabbruch
- **In-Memory Cache** für schnelle Responses

---

## Konfigurierte Accounts

| ID | Name | Host | User |
|----|------|------|------|
| `icloud` | iCloud (derhorst) | imap.mail.me.com | derhorst@me.com |
| `gmail` | Gmail (Privat) | imap.gmail.com | dieterganzprivat@gmail.com |
| `systemhaus` | Systemhaus-Horst | imaps.udag.de | dieterhorst@systemhaus-horst.de |
| `demo` | Demo Systemhaus | imaps.udag.de | demo@systemhaus-horst.de |
| `superadmin` | Superadmin Systemhaus | imaps.udag.de | superadmin@systemhaus-horst.de |
| `support` | Support Systemhaus | imaps.udag.de | support@systemhaus-horst.de |

---

## Account-Konfiguration

```typescript
interface AccountConfig {
  id: string;
  name: string;
  host: string;
  port: number;
  secure: boolean;
  user: string;
  pass: string;
  trashFolder?: string;
  archiveFolder?: string;
  folderPrefix?: string;      // z.B. "INBOX." für UDAG
  folderSeparator?: string;   // z.B. "." für UDAG, "/" für iCloud
}
```

### Folder-Konfiguration pro Provider

| Provider | folderPrefix | folderSeparator | Beispiel |
|----------|--------------|-----------------|----------|
| iCloud | `""` | `/` | `Archiv/Tech` |
| Gmail | `""` | `/` | `Archiv/Tech` |
| UDAG (Systemhaus) | `"INBOX."` | `.` | `INBOX.Archiv.Tech` |

---

## Klassen

### `ImapAccountService`

Verwaltet eine einzelne IMAP-Verbindung.

**Methoden:**

| Methode | Beschreibung |
|---------|--------------|
| `init()` | Verbindung initialisieren |
| `connect()` | Verbindung herstellen |
| `disconnect()` | Verbindung trennen |
| `isConnected()` | Verbindungsstatus |
| `getConfig()` | Account-Konfiguration abrufen |
| `getFolders()` | Alle Ordner aus Cache |
| `refreshFolders()` | Ordner neu laden |
| `getEmails(folder, limit)` | Mails aus Ordner |
| `getEmailDetail(uid, folder)` | Mail-Details |
| `moveEmail(uid, from, to)` | Mail verschieben |
| `deleteEmail(uid, folder)` | Mail löschen |
| `archiveEmail(uid, folder)` | Mail archivieren |
| `createFolder(name)` | Ordner erstellen |
| `deleteFolder(name)` | Ordner löschen |

### `ImapMultiAccountService`

Verwaltet alle Accounts.

**Methoden:**

| Methode | Beschreibung |
|---------|--------------|
| `init()` | Alle Accounts initialisieren |
| `getAccount(id)` | Account nach ID |
| `getAllAccounts()` | Alle Accounts |
| `getAccountIds()` | Liste der Account-IDs |

---

## Singleton-Export

```typescript
export const imapService = new ImapMultiAccountService();
```

Wird beim Server-Start in `hooks.server.ts` initialisiert.

---

## Cache-Struktur

```typescript
interface CacheData {
  folders: FolderInfo[];
  emails: Map<string, EmailSummary[]>;
  emailDetails: Map<string, EmailDetail>;
  lastFolderUpdate: number;
}
```

---

## Reconnect-Einstellungen

```typescript
RECONNECT_DELAY = 5000;        // 5 Sekunden
MAX_RECONNECT_ATTEMPTS = 10;
RECONNECT_BACKOFF = 1.5;       // Exponential backoff
IDLE_REFRESH_INTERVAL = 25 * 60 * 1000;  // 25 Minuten
```

---

## Events

Der Service emittiert Events bei neuen Mails:

```typescript
account.on('newMail', (email) => {
  // Neue Mail empfangen
});
```

---

## Verwendung

```typescript
import { imapService } from '$lib/server/imapService';

// Account holen
const account = imapService.getAccount('icloud');

// Mails abrufen
const emails = await account.getEmails('INBOX', 50);

// Mail verschieben
await account.moveEmail(uid, 'INBOX', 'Archiv/Tech');

// Config für Pfad-Berechnung
const config = account.getConfig();
const archivePath = `${config.folderPrefix}Archiv${config.folderSeparator}Tech`;
```

---

## Abhängigkeiten

- `imapflow` - IMAP-Client Library
- `events` - Node.js EventEmitter

---

## Änderungshistorie

| Datum | Änderung |
|-------|----------|
| 2026-01-06 | `folderPrefix` und `folderSeparator` in AccountConfig |
| 2026-01-06 | `getConfig()` Methode hinzugefügt |
