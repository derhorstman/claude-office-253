# Haushalt-Wissen für Blue

## Drucken

**Drucker:** Privat-Drucker-23 (192.168.42.140)

### Professionelle Dokumente erstellen und drucken

Wenn Simone ein Dokument braucht (Abmahnung, Widerspruch, Protokoll, etc.):

1. **Markdown erstellen** - Schreibe das Dokument als .md Datei
2. **In PDF umwandeln** - Mit pandoc schön formatiert:
   ```bash
   pandoc dokument.md -o dokument.pdf --pdf-engine=pdflatex -V geometry:margin=2.5cm -V fontsize=12pt
   ```
3. **Drucken**:
   ```bash
   lp -d Privat-Drucker-23 dokument.pdf
   ```

### Bilder generieren und drucken (DALL-E 3)

Für Ausmalbilder, Illustrationen, etc.:

1. **Bild generieren** mit OpenAI DALL-E 3 API
   - Ausmalbilder: style "line art coloring page, black outlines on white background, no shading"
   - Speichern als PNG
2. **Drucken**:
   ```bash
   lp -d Privat-Drucker-23 bild.png
   ```

### Einfache Druckbefehle

```bash
# PDF drucken
lp -d Privat-Drucker-23 /pfad/zur/datei.pdf

# Bild drucken
lp -d Privat-Drucker-23 /pfad/zum/bild.png

# Text direkt drucken
echo "Hallo Simone" | lp -d Privat-Drucker-23

# Drucker-Status prüfen
lpstat -p Privat-Drucker-23
```

### WICHTIG: Nicht nur beschreiben - MACHEN!

Wenn Simone sagt "Drucke mir X" oder "Ich brauche Y ausgedruckt":
- Dokument/Bild ERSTELLEN
- Als Datei SPEICHERN
- Mit lp-Befehl DRUCKEN
- Nicht nur erklären was du tun würdest!

Alternativ über CUPS-Webinterface: http://localhost:631

---

## E-Mail senden

### Konfiguration in /etc/msmtprc:

```
# Gmail Account
account gmail
host smtp.gmail.com
port 587
from poimerganzprivat@gmail.com
auth on
user poimerganzprivat@gmail.com
password vfcj-tove-ipnv-qwkr
tls on
tls_starttls on

# iCloud Account
account icloud
host smtp.mail.me.com
port 587
from poimerganzprivat@icloud.com
auth on
user poimerganzprivat@icloud.com
password vfcj-tove-ipnv-qwkr
tls on
tls_starttls on

# Standard-Account
account default : gmail
```

### E-Mail senden per Bash:

```bash
# Mit Gmail (Standard)
echo "Nachricht hier" | msmtp -a gmail empfaenger@example.com

# Mit iCloud
echo "Nachricht hier" | msmtp -a icloud empfaenger@example.com

# Mit Betreff und Body
msmtp -a gmail empfaenger@example.com << EOF
Subject: Betreff hier
From: poimerganzprivat@gmail.com
To: empfaenger@example.com

Nachricht hier.
EOF
```

### Simones E-Mail-Adressen:
- poimerganzprivat@gmail.com
- poimerganzprivat@icloud.com

---

## Dateien auf Dieters Desktop zeigen

```bash
scp /pfad/zur/datei dieterhorst@192.168.42.17:~/Desktop/
```

---

## Smart Home (OpenHAB)

**OpenHAB:** 192.168.42.10:8080

```bash
# Licht schalten (Beispiel)
curl -X POST -H "Content-Type: text/plain" -d "ON" http://192.168.42.10:8080/rest/items/ITEM_NAME

# Status abfragen
curl http://192.168.42.10:8080/rest/items/ITEM_NAME/state
```

---

## Wichtige IPs im Haushalt

| Gerät | IP |
|-------|-----|
| Drucker | 192.168.42.140 |
| OpenHAB | 192.168.42.10 |
| Mac (Dieter) | 192.168.42.17 |
| Fritzbox | 192.168.42.1 |
| DNS/DHCP | 192.168.42.216 |

---

## Reverse-Proxy für Blue

Deine Domain: **blue.systemhaus-horst.de**

Wird vom Office (.253) eingerichtet sobald du deinen Port sagst.
Standard wäre Port 3000.
