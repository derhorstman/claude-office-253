# GPU-Passthrough Status

**Erstellt:** 2026-01-04 14:10
**Ticket:** FEATURE-2026-002
**Status:** VM-Neustart steht bevor

---

## Was passiert ist

1. **Backup erstellt:** `D:\Backups\VM-Exports\015_SYSTEMHAUS-006_VM_001` auf DASBIEST
2. **VM identifiziert:** `015_SYSTEMHAUS-006_VM_001` (Generation 2, Running)
3. **GPU identifiziert:** NVIDIA GeForce RTX 5080
   - InstanceId: `PCI\VEN_10DE&DEV_2C02&SUBSYS_F3221569&REV_A1\EEA8957A7D2DB04800`

---

## Was noch gemacht werden muss

### Schritt 1: VM herunterfahren
```powershell
Stop-VM -Name "015_SYSTEMHAUS-006_VM_001" -Force
```

### Schritt 2: Checkpoints deaktivieren
```powershell
Set-VM -Name "015_SYSTEMHAUS-006_VM_001" -CheckpointType Disabled
```

### Schritt 3: GPU vom Host dismounten
```powershell
Disable-PnpDevice -InstanceId "PCI\VEN_10DE&DEV_2C02&SUBSYS_F3221569&REV_A1\EEA8957A7D2DB04800" -Confirm:$false
Dismount-VMHostAssignableDevice -LocationPath "PCIROOT(E0)#PCI(0101)#PCI(0000)" -Force
```

### Schritt 4: GPU der VM zuweisen
```powershell
Add-VMAssignableDevice -VMName "015_SYSTEMHAUS-006_VM_001" -LocationPath "PCIROOT(E0)#PCI(0101)#PCI(0000)"
```

### Schritt 5: VM starten
```powershell
Start-VM -Name "015_SYSTEMHAUS-006_VM_001"
```

### Schritt 6: In der VM - NVIDIA Treiber installieren
```bash
# Nach Neustart in der Office-VM:
sudo apt update
sudo apt install -y nvidia-driver-550 nvidia-cuda-toolkit
sudo reboot
```

### Schritt 7: Verifizieren
```bash
nvidia-smi
```

---

## Falls etwas schiefgeht

**Backup wiederherstellen:**
```powershell
Import-VM -Path "D:\Backups\VM-Exports\015_SYSTEMHAUS-006_VM_001\Virtual Machines\E524F0CF-D1D4-420E-9523-3D955ACCC64F.vmcx"
```

**GPU wieder an Host zurückgeben:**
```powershell
Remove-VMAssignableDevice -VMName "015_SYSTEMHAUS-006_VM_001" -LocationPath "PCIROOT(E0)#PCI(0101)#PCI(0000)"
Mount-VMHostAssignableDevice -LocationPath "PCIROOT(E0)#PCI(0101)#PCI(0000)"
Enable-PnpDevice -InstanceId "PCI\VEN_10DE&DEV_2C02&SUBSYS_F3221569&REV_A1\EEA8957A7D2DB04800" -Confirm:$false
```

---

## Nach erfolgreichem Neustart

1. Diese Datei lesen
2. `nvidia-smi` ausführen um GPU zu prüfen
3. Falls GPU da: CUDA testen, Real-ESRGAN mit GPU testen
4. Ticket FEATURE-2026-002 auf "Erledigt" setzen
5. Diese Datei löschen
