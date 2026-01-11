#!/bin/bash
# Family-Chat Watcher - sendet Mail bei neuen Nachrichten
# Erstellt: 2026-01-04

CHAT_FILE="/opt/office/data/family-chat.json"
STATE_FILE="/opt/Claude/scripts/.family_chat_count"
EMAIL="derhorst@me.com"

# Aktuelle Anzahl Nachrichten
CURRENT_COUNT=$(jq '.messages | length' "$CHAT_FILE" 2>/dev/null || echo 0)

# Letzte bekannte Anzahl
if [ -f "$STATE_FILE" ]; then
    LAST_COUNT=$(cat "$STATE_FILE")
else
    LAST_COUNT=0
fi

# Neue Nachrichten?
if [ "$CURRENT_COUNT" -gt "$LAST_COUNT" ]; then
    NEW_COUNT=$((CURRENT_COUNT - LAST_COUNT))

    # Letzte Nachricht holen
    LAST_MSG=$(jq -r '.messages[-1] | "\(.from) (\(.fromServer)): \(.text)"' "$CHAT_FILE")
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

    # Mail senden
    (
        echo "From: derhorst@me.com"
        echo "To: $EMAIL"
        echo "Subject: Family-Chat: Neue Nachricht"
        echo "Content-Type: text/plain; charset=utf-8"
        echo ""
        echo "Neue Nachricht im Family-Chat ($TIMESTAMP)"
        echo ""
        echo "$LAST_MSG"
        echo ""
        echo "---"
        echo "Insgesamt $NEW_COUNT neue Nachricht(en)"
    ) | msmtp "$EMAIL"

    echo "$(date): Mail gesendet - $NEW_COUNT neue Nachricht(en)" >> /var/log/family_chat_watcher.log
fi

# Neuen Stand speichern
echo "$CURRENT_COUNT" > "$STATE_FILE"
