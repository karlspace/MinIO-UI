# Logo und Icons Setup - Admin Console for MinIO®

**Datum:** 2025-10-31
**Status:** ✅ Vollständig implementiert

---

## Überblick

Alle MinIO-Logos (Flamingo) wurden entfernt und durch neutrale, markenrechtlich unbedenkliche Icons ersetzt.

---

## Neue Logo-Dateien

### 1. Hauptlogos

| Datei | Größe | Verwendung |
|-------|-------|------------|
| `web-app/src/logo.svg` | 200x200 | React App Import (falls benötigt) |
| `web-app/public/logo.svg` | 200x200 | Öffentliches Logo, Preload in index.html |

### 2. Icons für Browser/PWA

| Datei | Größe | Verwendung |
|-------|-------|------------|
| `web-app/public/favicon.svg` | 32x32 optimiert | Browser Favicon (Haupt-Icon) |
| `web-app/public/logo192.png.svg` | 192x192 | PWA Icon, Android |
| `web-app/public/logo512.png.svg` | 512x512 | PWA Icon, hochauflösend |

---

## Design-Beschreibung

### Farben
- **Hintergrund:** Blauer Gradient
  - Start: `#4A90E2`
  - Ende: `#357ABD`
- **Datenbank-Zylinder:** Weiß/Hellblau (`#E8F4F8`, `#C1E1EC`)
- **Admin-Zahnrad:** Orange (`#FFB74D`) mit weißem Zentrum

### Symbolik
- **Drei Zylinder:** Repräsentieren gestapelte Datenbanken/Object Storage
- **Zahnrad:** Symbolisiert Admin-Funktionen und Konfiguration
- **Zusammen:** Admin Console für Storage Management

### Eigenschaften
✅ Keine Markenrechtskonflikte
✅ Generic/Neutral Design
✅ Klar erkennbare Funktion (Storage + Admin)
✅ Professionelles Erscheinungsbild
✅ Skalierbar (SVG)

---

## Integration

### index.html

```html
<head>
  <!-- Favicon -->
  <link href="%PUBLIC_URL%/favicon.svg" rel="icon" type="image/svg+xml" />

  <!-- PWA Manifest -->
  <link href="%PUBLIC_URL%/manifest.json" rel="manifest" />
</head>

<body>
  <div id="preload">
    <img src="./images/background.svg" />
    <img src="./images/background-wave-orig2.svg" />
    <img src="./logo.svg" />
  </div>
</body>
```

### manifest.json

```json
{
  "name": "Admin Console for MinIO",
  "short_name": "Admin Console",
  "description": "A third-party admin interface for MinIO object storage",
  "theme_color": "#4A90E2",
  "background_color": "#FFFFFF",
  "icons": [
    {
      "src": "favicon.svg",
      "sizes": "any",
      "type": "image/svg+xml",
      "purpose": "any maskable"
    },
    {
      "src": "logo192.png.svg",
      "sizes": "192x192",
      "type": "image/svg+xml"
    },
    {
      "src": "logo512.png.svg",
      "sizes": "512x512",
      "type": "image/svg+xml"
    }
  ]
}
```

---

## Entfernte Dateien (MinIO-Branding)

Die folgenden Dateien mit MinIO-Flamingo-Logo wurden entfernt:

### Icons (17 Dateien)
- ❌ `minio-logo.svg`
- ❌ `minioTier.png`
- ❌ `logo192.png`
- ❌ `logo512.png`
- ❌ `src/logo.svg` (ersetzt)
- ❌ `favicon.ico`
- ❌ `favicon-16x16.png`
- ❌ `favicon-32x32.png`
- ❌ `favicon-96x96.png`
- ❌ `android-icon-36x36.png`
- ❌ `android-icon-48x48.png`
- ❌ `android-icon-72x72.png`
- ❌ `android-icon-96x96.png`
- ❌ `android-icon-144x144.png`
- ❌ `android-icon-192x192.png`
- ❌ `apple-icon-180x180.png`
- ❌ `safari-pinned-tab.svg`

---

## Build-Prozess

Nach dem Ändern der Icons/Logos:

```bash
# Frontend neu bauen
cd web-app
yarn install
yarn build

# Backend mit neuem Frontend bauen
cd ..
make assets
make build

# Docker Image neu bauen
cd docker
docker build -t admin-console-minio:latest ..
```

---

## Testing

### Browser-Test
1. Öffnen Sie die Anwendung im Browser
2. Prüfen Sie das Favicon in der Browser-Tab
3. Prüfen Sie Developer Tools → Application → Manifest

### PWA-Test
1. Installieren Sie die App als PWA
2. Prüfen Sie das App-Icon auf dem Homescreen
3. Prüfen Sie das Splash-Screen beim Start

---

## Hinweise

### SVG vs PNG/ICO
Wir verwenden SVG-Dateien statt PNG/ICO weil:
- ✅ Verlustfrei skalierbar
- ✅ Kleinere Dateigröße
- ✅ Einfacher zu bearbeiten
- ✅ Moderne Browser unterstützen SVG-Favicons
- ✅ Bessere Darstellung auf High-DPI Displays

### Namenskonvention
- Dateien mit `.png.svg` Extension sind SVG-Dateien, die PNG-Icons ersetzen
- Browser interpretieren diese korrekt als SVG (type in manifest.json)
- Alternative: Umbenennen zu `.svg` und alle Referenzen aktualisieren

### Anpassung
Um die Icons anzupassen:
1. Bearbeiten Sie die SVG-Dateien mit einem Editor (Inkscape, Figma, etc.)
2. Behalten Sie die ViewBox-Dimensionen bei
3. Testen Sie alle Größen (16px, 32px, 192px, 512px)
4. Führen Sie einen kompletten Build durch

---

## Browser-Kompatibilität

| Browser | Favicon SVG | Manifest PWA |
|---------|-------------|--------------|
| Chrome 94+ | ✅ | ✅ |
| Firefox 85+ | ✅ | ✅ |
| Safari 15+ | ✅ | ✅ |
| Edge 94+ | ✅ | ✅ |

Für ältere Browser wird automatisch auf Default-Icon zurückgefallen.

---

## Rechtliche Hinweise

✅ **Markenrechtlich unbedenklich**
- Keine MinIO-Logos
- Keine geschützten Designs
- Generic Storage/Admin Symbole
- Eigenes Design

✅ **Nutzungsrechte**
- Vollständige Rechte an den Designs
- Frei verwendbar für dieses Projekt
- Keine Lizenzierung erforderlich

---

**Stand:** 2025-10-31
**Version:** 1.7.6-extended
**Status:** ✅ Produktionsbereit
