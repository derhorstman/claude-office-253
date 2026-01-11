# OpenHAB Smart Home für Blue

**OpenHAB Server:** http://192.168.42.10:8080

## Befehle

### Licht einschalten
```bash
curl -X POST -H "Content-Type: text/plain" -d "ON" http://192.168.42.10:8080/rest/items/ITEM_NAME
```

### Licht ausschalten
```bash
curl -X POST -H "Content-Type: text/plain" -d "OFF" http://192.168.42.10:8080/rest/items/ITEM_NAME
```

### Jalousie steuern
```bash
# Hoch (0 = offen)
curl -X POST -H "Content-Type: text/plain" -d "0" http://192.168.42.10:8080/rest/items/ITEM_NAME

# Runter (100 = geschlossen)
curl -X POST -H "Content-Type: text/plain" -d "100" http://192.168.42.10:8080/rest/items/ITEM_NAME

# Stopp
curl -X POST -H "Content-Type: text/plain" -d "STOP" http://192.168.42.10:8080/rest/items/ITEM_NAME
```

### Status abfragen
```bash
curl http://192.168.42.10:8080/rest/items/ITEM_NAME/state
```

---

## Lampen (Switch - ON/OFF)

| Item-Name | Beschreibung |
|-----------|--------------|
| Lampe_Kuche | Lampe Küche |
| Tischlampe_Kuche | Tischlampe Küche |
| Lampe_Esszimmer | Lampe Esszimmer |
| Wandlampe_Esszimmer | Wandlampe Esszimmer |
| Wandlampe_Wohnzimmer | Wandlampe Wohnzimmer |
| Lampe_Flur_Betrieb | Lampe Flur |
| Tischlampe_Flur_Betrieb | Tischlampe Flur |
| Lampe_Treppe | Lampe Treppe (Dimmer 0-100) |
| Lampe_Oben | Lampe Oben |
| Tischlampe_oben | Tischlampe Oben |
| Lampe_Buro | Lampe Büro |
| Lampe_WC | Lampe WC |
| Lampe_Badezimmer | Lampe Badezimmer |
| Lampe_Schlafen | Lampe Schlafen |
| Lampe_Schlafzimmer | Lampe Schlafzimmer |
| Tischlampe_Schlafen | Tischlampe Schlafen |
| Lampe_Ankleide | Lampe Ankleide |
| Lampe_Dachboden | Lampe Dachboden |
| Lampe_Vorrat | Lampe Vorrat |
| Lampe_Heizung | Lampe Heizung |
| Lampe_Eingang | Lampe Eingang |
| Lampe_Garten | Lampe Garten |
| Lampe_Saule_Betrieb | Lampe Säule Garten |
| Strahler | Strahler Terrasse |
| Rotlicht | Rotlicht Fitness |

---

## Jalousien (Rollershutter - 0-100 oder UP/DOWN/STOP)

| Item-Name | Beschreibung |
|-----------|--------------|
| Jalousie_1 | Jalousie Küche 1 |
| Jalousie_2 | Jalousie Küche 2 |
| Jalousie_3 | Jalousie Wohnzimmer 1 |
| Jalousie_4 | Jalousie Wohnzimmer 2 |
| Jalousie_5 | Jalousie Wohnzimmer 3 |
| Jalousie_6 | Jalousie Wohnzimmer 4 |
| Jalousie_7 | Jalousie Wohnzimmer 5 |
| Jalousie_8 | Jalousie Büro |
| Jalousie_9 | Jalousie Heizung |
| Jalousie_10 | Jalousie WC |
| Jalousie_11 | Jalousie Arbeitszimmer |
| Jalousie_12 | Jalousie Ankleide |
| Jalousie_13 | Jalousie Schlafzimmer |
| Jalousie_14 | Jalousie Schlafen |
| Jalousie_15 | Jalousie Badezimmer |
| Jalousie_16 | Jalousie Dachboden rechts |
| Jalousie_17 | Jalousie Dachboden links |

---

## Geräte (Switch - ON/OFF)

| Item-Name | Beschreibung |
|-----------|--------------|
| TV | TV Wohnzimmer |
| Wasserkocher | Wasserkocher Küche |
| Heizstrahler_Betrieb | Heizstrahler Terrasse |
| HotWater_Betrieb | HotWater Badezimmer |
| Hochdruckreiniger | Hochdruckreiniger Garage |
| Garagentor | Garagentor |

---

## Garten (Switch - ON/OFF)

| Item-Name | Beschreibung |
|-----------|--------------|
| Wasser_Vorne_Betrieb | Wasser Vorne Garten |
| Zaunbewasserung_Betrieb | Zaunbewässerung Garten |
| Rasenbewasserung_Betrieb | Rasenbewässerung Garten |
| Wasserpumpe | Wasserpumpe Garten |

---

## Markisen (Rollershutter)

| Item-Name | Beschreibung |
|-----------|--------------|
| Seitenmarkise_gross | Seitenmarkise Groß Terrasse |
| Obermarkise_gross | Obermarkise groß Terrasse |

---

## Temperatur (nur lesen)

| Item-Name | Beschreibung |
|-----------|--------------|
| Heizung_Wohnzimmer | Heizung Wohnzimmer |
| Walldisplay_Buro_Innentemperatur | Heizung Büro |
| Walldisplay_WC_Innentemperatur | Heizung WC |
| Walldisplay_Schlafen_Innentemperatur | Heizung Schlafen |

---

## Beispiele

### Küchenlicht einschalten
```bash
curl -X POST -H "Content-Type: text/plain" -d "ON" http://192.168.42.10:8080/rest/items/Lampe_Kuche
```

### Küchenlicht ausschalten
```bash
curl -X POST -H "Content-Type: text/plain" -d "OFF" http://192.168.42.10:8080/rest/items/Lampe_Kuche
```

### Alle Wohnzimmer-Jalousien runter
```bash
for i in 3 4 5 6 7; do curl -X POST -H "Content-Type: text/plain" -d "100" http://192.168.42.10:8080/rest/items/Jalousie_$i; done
```

### TV Status prüfen
```bash
curl http://192.168.42.10:8080/rest/items/TV/state
```
