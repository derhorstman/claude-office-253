#!/bin/bash
# Pre-Session Backup - läuft vor jeder Claude Session
# Sichert /opt/Claude in ein lokales tar.gz

BACKUP_DIR="/opt/Claude/backups"
DATE=$(date +%Y-%m-%d_%H-%M)
HOSTNAME=$(hostname)

mkdir -p "$BACKUP_DIR"

# Backup erstellen (ohne backups-Ordner selbst)
tar --exclude='backups' --exclude='screenshots/*.png' \
    -czf "$BACKUP_DIR/pre-session-${DATE}.tar.gz" \
    -C /opt Claude 2>/dev/null

# Alte Backups löschen (behalte letzte 5)
ls -t "$BACKUP_DIR"/pre-session-*.tar.gz 2>/dev/null | tail -n +6 | xargs -r rm

echo "Backup erstellt: $BACKUP_DIR/pre-session-${DATE}.tar.gz"
