
## Erinnerungen / Follow-ups

### 2026-01-06 (morgens)
- VM Backup pruefen: Hat das naechtliche Backup um 3:00 Uhr geklappt?
  - QNAP checken: `sshpass -p 'Mondstein2026' ssh -p 2222 dieterhorst@192.168.42.126 "ls -la /share/Public/Backups/VMs/"`
  - Falls Fehler: Logs auf DASBIEST pruefen (C:\Logs\VM-Backup)
  - User fragen ob alles OK oder Nachjustierung noetig

---

## Inter-Claude Kommunikation

### Mit anderen Claude-Sessions kommunizieren

Auf der 230 (192.168.42.230) laufen Claude-Sessions in tmux. So erreichst du sie:

```bash
# SSH zur 230
ssh -p 2222 dieterhorst@192.168.42.230

# Laufende Sessions anzeigen
tmux ls

# Nachricht in eine Session schicken (z.B. web-terminal-96)
ssh -p 2222 dieterhorst@192.168.42.230 'tmux send-keys -t web-terminal-96 "Deine Nachricht hier" Enter'
```

### Beispiel: Info an anderen Claude senden
```bash
ssh -p 2222 dieterhorst@192.168.42.230 'tmux send-keys -t web-terminal-96 "
WICHTIG: Neue Information für dich...
" Enter'
```

### Aktive Claude-Prozesse finden
```bash
ssh -p 2222 dieterhorst@192.168.42.230 'ps aux | grep -i claude | grep -v grep'
```

