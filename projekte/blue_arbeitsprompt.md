# Projekt: Blue - KI-Assistent für Simone

**VM:** 192.168.42.139

**Ziel:** Persönlicher KI-Assistent für Pflegedienstleitung. iPhone-first, minimalistisch, dunkelblau.

---

## Technische Basis

- SvelteKit + TailwindCSS (wie Office)
- Node.js Server
- Dunkelblau-Theme
- PWA-fähig
- Logo kommt separat

**Domain:** blue.systemhaus-horst.de (Reverse-Proxy .254)

**Login:** Passwortgeschützt

---

## E-Mail Accounts

| Account | E-Mail | App-Passwort | IMAP | SMTP |
|---------|--------|--------------|------|------|
| Gmail | poimerganzprivat@gmail.com | vfcj-tove-ipnv-qwkr | imap.gmail.com:993 | smtp.gmail.com:587 |
| iCloud | poimerganzprivat@icloud.com | vfcj-tove-ipnv-qwkr | imap.mail.me.com:993 | smtp.mail.me.com:587 |

---

## Features

1. **Chat mit Claude** - Hauptfunktion, Problemlöser
2. **Spracheingabe** - OpenAI Whisper API (wie Office /api/stt)
3. **E-Mail** - Lesen + Senden
4. **Wissensbasis** - MDK-Richtlinien, Arbeitsrecht, Mitarbeiterführung (Dokumente hinterlegen)

---

## Design

- iPhone-first (Safe-Area, Touch-optimiert)
- Dunkelblau-Theme
- Clean, minimalistisch
- Große Buttons, wenig Klicks

---

## Kontext für Claude

Simone ist Pflegedienstleitung einer betreuten Wohnanlage (~50 Mitarbeiter). Blue soll ihr bei folgenden Themen helfen:

- MDK-Gutachterfragen
- Mitarbeiterführung
- Gesprächsvorbereitung (Kritik, Lob, Abmahnung)
- Arbeitsrechtliche Fragen
- Problemlösung per Mail/Chat
