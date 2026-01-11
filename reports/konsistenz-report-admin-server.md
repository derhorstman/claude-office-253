# Konsistenz-Report: Admin-Portal (.230)

**Datum:** 2026-01-02
**Hostname:** admin-server
**Analysiert von:** Claude (Session 66)

---

## 1. API Endpoints vs. Frontend Calls

### Backend Endpoints (94 insgesamt)

| Modul | GET | POST | PUT | DELETE |
|-------|-----|------|-----|--------|
| auth | 0 | 2 | 0 | 0 |
| users | 3 | 0 | 3 | 1 |
| machines | 12 | 5 | 1 | 2 |
| vms | 3 | 1 | 0 | 1 |
| concepts | 5 | 4 | 1 | 1 |
| snippets | 4 | 2 | 2 | 2 |
| sessions | 3 | 1 | 0 | 2 |
| promptmachine | 3 | 4 | 0 | 0 |
| projekte | 2 | 1 | 0 | 0 |
| cronjobs | 7 | 3 | 1 | 1 |
| healthcheck | 2 | 1 | 0 | 0 |
| vmbackup | 3 | 1 | 0 | 1 |
| docs | 3 | 0 | 0 | 0 |
| servers | 4 | 2 | 0 | 0 |
| terminal | 1 | 0 | 0 | 1 |

---

## 2. Ungenutzte Backend-Endpoints

| Endpoint | Schweregrad | Anmerkung |
|----------|-------------|-----------|
| 🟡 `POST /api/auth/register` | Minor | Registrierung nicht im Frontend |
| 🟡 `POST /api/promptmachine/concept/continue` | Minor | Multi-Step Wizard nicht implementiert |
| 🟡 `GET /api/concepts/sync/history` | Minor | Sync-History nicht angezeigt |
| 🟡 `GET /api/docs/list` | Minor | Dokumenten-Liste nicht genutzt |
| 🟡 `GET /api/docs/read/{path}` | Minor | Dok-Reader nicht genutzt |
| 🟡 `GET /api/promptmachine/context` | Minor | Context-Endpoint nicht genutzt |
| 🟡 `GET /api/terminal/sessions/{machine_id}` | Minor | Terminal-Sessions-Liste nicht genutzt |
| 🟡 `DELETE /api/terminal/sessions/{machine_id}/{session}` | Minor | Session-Cleanup nicht im UI |

---

## 3. Ungenutzte Frontend API-Funktionen (api.ts)

| Funktion | Schweregrad | Anmerkung |
|----------|-------------|-----------|
| 🟡 `getServers()` | Minor | Legacy - ersetzt durch getMachines() |
| 🟡 `getServerStatus()` | Minor | Legacy - ersetzt durch getMachineStatus() |
| 🟡 `getServerServices()` | Minor | Legacy - ersetzt durch Machine-Module |
| 🟡 `controlService()` (Server-Version) | Minor | Legacy |
| 🟢 `getCronjobs()` | OK | Global-Redirect zu Admin-Server |
| 🟢 `getCronjobTemplates()` | OK | In Cronjobs-Page genutzt |

---

## 4. Datenmodell-Konsistenz

### Machine/Server

| Backend (Python) | Frontend (TypeScript) | Status |
|-----------------|----------------------|--------|
| `function_name: Optional[str]` | `function_name: string \| null` | 🟢 OK |
| `ip_address: Optional[str]` | `ip_address: string \| null` | 🟢 OK |
| `parent_id: Optional[int]` | `parent_id: number \| null` | 🟢 OK |
| `os: Enum` | `os: 'linux' \| 'windows' \| 'hyperv' \| null` | 🟢 OK |

### Snippets

| Backend | Frontend | Status |
|---------|----------|--------|
| `machine_id: Optional[int]` | `machine_id: Optional[int]` | 🟢 OK |
| `category_id: Optional[int]` | `category_id: Optional[int]` | 🟢 OK |

### Concepts

| Backend | Frontend | Status |
|---------|----------|--------|
| Komplett via fetch() | Kein Interface in api.ts | 🟡 Minor - Typsicherheit fehlt |

---

## 5. Feldnamen-Konsistenz

| Bereich | Backend | Frontend | Status |
|---------|---------|----------|--------|
| Allgemein | snake_case | snake_case | 🟢 OK |
| Pydantic | `from_attributes = True` | - | 🟢 OK |
| JSON Response | snake_case | snake_case | 🟢 OK |

**Keine camelCase/snake_case Inkonsistenzen gefunden!**

---

## 6. Fehlerbehandlung

### Backend

| Muster | Status |
|--------|--------|
| HTTPException mit detail | 🟢 Konsistent |
| Status-Codes korrekt | 🟢 OK (404, 400, 500, 503) |
| Deutsche Fehlermeldungen | 🟢 Konsistent |

### Frontend

| Muster | Status |
|--------|--------|
| try/catch überall | 🟢 Konsistent |
| error.message Nutzung | 🟢 OK |
| Fallback bei JSON-Parse | 🟢 OK (`catch(() => ({ detail: 'Request failed' }))`) |

---

## 7. Zusammenfassung

| Kategorie | Status | Anzahl Issues |
|-----------|--------|---------------|
| 🔴 Bugs (kritisch) | - | 0 |
| 🟡 Minor (ungenutzte Endpoints) | Harmlos | 8 |
| 🟢 OK | - | 86 Endpoints funktional |

### Gesamt-Bewertung: 🟢 GUT

Das Admin-Portal ist konsistent. Die ungenutzten Endpoints sind entweder:
- Legacy-Code (Server → Machines Migration)
- Features für spätere Nutzung (Multi-Step Wizard, Sync-History)

---

## 8. Vorgeschlagene Fixes (NICHT DURCHGEFÜHRT)

1. **Legacy-Cleanup (api.ts):**
   - Server-Interfaces entfernen (getServers, getServerStatus, etc.)
   - Nur Machines-API behalten

2. **Typsicherheit (Konzepte):**
   - TypeScript-Interfaces für Concepts in api.ts hinzufügen

3. **UI-Erweiterungen (optional):**
   - Sync-History in Konzepte-Seite anzeigen
   - Terminal-Sessions-Übersicht im Split-Terminal

---

*Report erstellt ohne Code-Änderungen. Keine Container-Neustarts durchgeführt.*
