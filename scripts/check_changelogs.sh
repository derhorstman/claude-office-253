#!/bin/bash
# Changelog-Abfrage für alle Server
# Erstellt: 2026-01-04

echo "=== CHANGELOG-STATUS ALLER SERVER ==="
echo "Abfrage: $(date '+%Y-%m-%d %H:%M')"
echo ""

# Funktion zum Abrufen und Anzeigen (Linux/Mac)
check_server() {
    local name=$1
    local ip=$2
    local port=$3
    local path=$4

    echo "--- $name ($ip) ---"
    if [ "$port" = "22" ]; then
        result=$(ssh -o ConnectTimeout=5 dieterhorst@$ip "cat $path 2>/dev/null" 2>/dev/null)
    else
        result=$(ssh -o ConnectTimeout=5 -p $port dieterhorst@$ip "cat $path 2>/dev/null" 2>/dev/null)
    fi

    if [ -n "$result" ]; then
        echo "$result" | tail -10
    else
        echo "NICHT ERREICHBAR oder kein Changelog"
    fi
    echo ""
}

# Funktion für Windows-Hosts
check_windows() {
    local name=$1
    local ip=$2
    local path=$3

    echo "--- $name ($ip) ---"
    result=$(ssh -o ConnectTimeout=5 dieterhorst@$ip "cmd /c type $path" 2>/dev/null)

    if [ -n "$result" ]; then
        echo "$result" | tail -10
    else
        echo "NICHT ERREICHBAR oder kein Changelog"
    fi
    echo ""
}

# Mac
check_server "Mac Pro" "192.168.42.17" "22" "~/Claude/changelog.md"

# Windows Hosts
check_windows "DASBIEST" "192.168.42.16" "C:\\Claude\\changelog.md"
check_windows "kleinerHund" "192.168.42.231" "C:\\Claude\\changelog.md"

# Linux VMs (Port 2222)
check_server "OpenHAB" "192.168.42.10" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "zigbee2mqtt" "192.168.42.11" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Nextcloud" "192.168.42.12" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Webserver" "192.168.42.13" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "SYSTEMHAUS" "192.168.42.15" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Stefan" "192.168.42.116" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "PEDAGOGUS" "192.168.42.128" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "OpsRef" "192.168.42.150" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "cant" "192.168.42.166" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Marcel" "192.168.42.195" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "DevoraXx" "192.168.42.214" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "DNS-Server" "192.168.42.216" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Admin-Portal" "192.168.42.230" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "edo" "192.168.42.246" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Thea" "192.168.42.252" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"
check_server "Reverse-Proxy" "192.168.42.254" "2222" "/opt/Claude/03_HIPPOCAMPUS/changelog.md"

echo "=== ENDE ==="
