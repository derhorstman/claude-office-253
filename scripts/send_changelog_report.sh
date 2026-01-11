#!/bin/bash
# Changelog-Report als PDF per Mail senden
# Erstellt: 2026-01-04
# Cronjob: 0 7 * * * /opt/Claude/scripts/send_changelog_report.sh

REPORT_DIR="/tmp/changelog_report"
DATE=$(date '+%Y-%m-%d')
MARKDOWN_FILE="$REPORT_DIR/changelog_$DATE.md"
PDF_FILE="$REPORT_DIR/changelog_$DATE.pdf"
EMAIL="derhorst@me.com"

# Verzeichnis erstellen
mkdir -p "$REPORT_DIR"

# Header für Markdown
cat > "$MARKDOWN_FILE" << EOF
---
title: "Server Changelog Report"
date: "$DATE"
geometry: margin=2cm
---

# Changelog-Report vom $DATE

Automatisch generiert um $(date '+%H:%M') Uhr.

---

EOF

# Changelog-Daten sammeln
echo "## Mac Pro (192.168.42.17)" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
ssh -o ConnectTimeout=5 dieterhorst@192.168.42.17 "cat ~/Claude/changelog.md 2>/dev/null" >> "$MARKDOWN_FILE" 2>/dev/null || echo "Nicht erreichbar" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
echo "" >> "$MARKDOWN_FILE"

echo "## DASBIEST (192.168.42.16)" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
ssh -o ConnectTimeout=5 dieterhorst@192.168.42.16 "cmd /c type C:\\Claude\\changelog.md" >> "$MARKDOWN_FILE" 2>/dev/null || echo "Nicht erreichbar" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
echo "" >> "$MARKDOWN_FILE"

echo "## kleinerHund (192.168.42.231)" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
ssh -o ConnectTimeout=5 dieterhorst@192.168.42.231 "cmd /c type C:\\Claude\\changelog.md" >> "$MARKDOWN_FILE" 2>/dev/null || echo "Nicht erreichbar" >> "$MARKDOWN_FILE"
echo '```' >> "$MARKDOWN_FILE"
echo "" >> "$MARKDOWN_FILE"

# Linux VMs
for server in "OpenHAB:10" "zigbee2mqtt:11" "Nextcloud:12" "Webserver:13" "SYSTEMHAUS:15" "Stefan:116" "PEDAGOGUS:128" "OpsRef:150" "cant:166" "Marcel:195" "DevoraXx:214" "DNS-Server:216" "Admin-Portal:230" "edo:246" "Thea:252" "Reverse-Proxy:254"; do
    name="${server%:*}"
    ip="192.168.42.${server#*:}"

    echo "## $name ($ip)" >> "$MARKDOWN_FILE"
    echo '```' >> "$MARKDOWN_FILE"
    ssh -o ConnectTimeout=5 -p 2222 dieterhorst@$ip "cat /opt/Claude/03_HIPPOCAMPUS/changelog.md 2>/dev/null" >> "$MARKDOWN_FILE" 2>/dev/null || echo "Nicht erreichbar" >> "$MARKDOWN_FILE"
    echo '```' >> "$MARKDOWN_FILE"
    echo "" >> "$MARKDOWN_FILE"
done

# PDF erstellen
pandoc "$MARKDOWN_FILE" -o "$PDF_FILE" --pdf-engine=pdflatex 2>/dev/null

# Mail senden mit msmtp
if [ -f "$PDF_FILE" ]; then
    (
        echo "From: derhorst@me.com"
        echo "To: $EMAIL"
        echo "Subject: Server Changelog Report - $DATE"
        echo "MIME-Version: 1.0"
        echo "Content-Type: multipart/mixed; boundary=\"BOUNDARY\""
        echo ""
        echo "--BOUNDARY"
        echo "Content-Type: text/plain; charset=utf-8"
        echo ""
        echo "Changelog-Report aller 18 Server im Anhang."
        echo ""
        echo "Generiert: $(date '+%Y-%m-%d %H:%M')"
        echo ""
        echo "--BOUNDARY"
        echo "Content-Type: application/pdf; name=\"changelog_$DATE.pdf\""
        echo "Content-Transfer-Encoding: base64"
        echo "Content-Disposition: attachment; filename=\"changelog_$DATE.pdf\""
        echo ""
        base64 "$PDF_FILE"
        echo ""
        echo "--BOUNDARY--"
    ) | msmtp "$EMAIL"

    echo "Report gesendet an $EMAIL"
else
    echo "Fehler: PDF konnte nicht erstellt werden"
    exit 1
fi

# Aufräumen
rm -rf "$REPORT_DIR"
