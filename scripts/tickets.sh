#!/bin/bash
# Ticket-Verwaltung für Claude Terminal

AKTEN_JSON="/opt/office/data/akten/index.json"

case "$1" in
    liste|list|"")
        echo ""
        echo "=== TICKETS ==="
        echo ""
        jq -r '.tickets | sort_by(if .status == "Neu" then "1" elif .status == "In Bearbeitung" then "2" elif .status == "Warte auf Antwort" then "3" else "9" end) | .[] | "[\(.status | if . == "Warte auf Antwort" then "Warte" elif . == "In Bearbeitung" then "In Bearb." else . end)] \(.id): \(.titel)\n    \(.beschreibung | split("\n") | first | .[0:75] // "(keine Beschreibung)")\n"' "$AKTEN_JSON"
        TOTAL=$(jq '.tickets | length' "$AKTEN_JSON")
        OFFEN=$(jq '[.tickets[] | select(.status != "Erledigt")] | length' "$AKTEN_JSON")
        echo "--- Gesamt: $TOTAL | Offen: $OFFEN ---"
        echo ""
        ;;

    show|zeig)
        if [ -z "$2" ]; then
            echo "Verwendung: tickets.sh show <ID oder Suchbegriff>"
            exit 1
        fi

        SEARCH="$2"

        # Suche nach ID oder Titel
        TICKET=$(jq --arg s "$SEARCH" '[.tickets[] | select(.id == $s or (.titel | ascii_downcase | contains($s | ascii_downcase)))] | first' "$AKTEN_JSON")

        if [ "$TICKET" == "null" ] || [ -z "$TICKET" ]; then
            echo "Ticket nicht gefunden: $SEARCH"
            exit 1
        fi

        echo ""
        echo "=== TICKET ==="
        echo "$TICKET" | jq -r '"ID: \(.id)\nTitel: \(.titel)\nStatus: \(.status)\nKategorie: \(.kategorie)\nErstellt: \(.erstellt)\nAktualisiert: \(.aktualisiert)"'

        FOLDER=$(echo "$TICKET" | jq -r '.folder // empty' | tr -d "'\"")
        if [ -n "$FOLDER" ]; then
            echo ""
            echo "=== ORDNER ==="
            # Mac-Pfad zu Linux-Pfad konvertieren
            LINUX_FOLDER=$(echo "$FOLDER" | sed 's|/Users/dieterhorst/|/mnt/dieterhorst/|')
            echo "Pfad: $LINUX_FOLDER"
            echo ""
            if [ -d "$LINUX_FOLDER" ]; then
                ls -la "$LINUX_FOLDER" 2>/dev/null | head -20
            else
                echo "(Ordner nicht erreichbar)"
            fi
        fi

        echo ""
        echo "=== BESCHREIBUNG ==="
        echo "$TICKET" | jq -r '.beschreibung // "(keine)"'

        echo ""
        echo "=== HISTORY (letzte 5) ==="
        echo "$TICKET" | jq -r '.history | .[-5:] | .[] | "[\(.datum | .[0:10])] \(.aktion)"'
        echo ""
        ;;

    *)
        echo "Verwendung:"
        echo "  tickets.sh [liste]        - Alle Tickets anzeigen"
        echo "  tickets.sh show <ID>      - Ticket-Details anzeigen"
        echo "  tickets.sh show <Begriff> - Ticket nach Titel suchen"
        ;;
esac
