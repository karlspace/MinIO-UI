# CONSOLE_MINIO_REGION - Obligatorischer Parameter

**Datum:** 2025-10-31
**Status:** ✅ Implementiert

---

## Zusammenfassung

`CONSOLE_MINIO_REGION` wurde als **obligatorischer Parameter** für den Docker-Container implementiert. Der Container startet nicht mehr, wenn diese Variable nicht gesetzt ist.

---

## Grund für die Änderung

### Problem
```
ErrorWithContext:The authorization header is malformed; the region is wrong; expecting 'us-east-1'.
```

MinIO verwendet AWS S3-kompatible Authentifizierung, die eine Region erfordert. Ohne korrekte Region-Konfiguration schlagen alle API-Anfragen fehl.

---

## Implementierte Änderungen

### 1. Entrypoint Script (docker/entrypoint.sh)

**Neue Validierung hinzugefügt:**

```bash
# Check if CONSOLE_MINIO_REGION is set
if [ -z "$CONSOLE_MINIO_REGION" ]; then
    echo "❌ ERROR: CONSOLE_MINIO_REGION is not set!"
    echo "   Please set the MinIO server region, e.g.:"
    echo "   export CONSOLE_MINIO_REGION=us-east-1"
    echo "   OR"
    echo "   export CONSOLE_MINIO_REGION=shared"
    echo ""
    exit 1
fi
```

**Ausgabe bei erfolgreicher Validierung:**
```
✅ Configuration validated
   MinIO Server: https://s3.shared.app.bauer-group.com
   MinIO Region: shared
   Console Port: 9090
```

### 2. Docker README (docker/README.md)

**Aktualisierte Beispiele:**

```bash
# Einfachste Variante
docker run -d \
  --name admin-console-minio \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  admin-console-minio:latest

# Produktion mit persistenten Sessions
docker run -d \
  --name admin-console-minio \
  -p 9090:9090 \
  -e CONSOLE_PBKDF_PASSPHRASE="your-secret-passphrase" \
  -e CONSOLE_PBKDF_SALT="your-secret-salt" \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  admin-console-minio:latest
```

**Required Environment Variables Sektion aktualisiert:**
- `CONSOLE_MINIO_SERVER`: URL of your MinIO server (e.g., `http://localhost:9000`)
- `CONSOLE_MINIO_REGION`: MinIO server region (e.g., `us-east-1`, `shared`, or custom region)

### 3. Environment File (.env.example)

**Neue Sektion hinzugefügt:**

```env
# Required: MinIO Server Region
# Examples:
#   - us-east-1 (AWS default)
#   - shared (custom region)
#   - eu-west-1
CONSOLE_MINIO_REGION=us-east-1
```

### 4. Docker Compose (docker-compose.yml)

**Environment Variable hinzugefügt:**

```yaml
environment:
  # Required: MinIO Server endpoint
  CONSOLE_MINIO_SERVER: "${CONSOLE_MINIO_SERVER:-http://minio:9000}"

  # Required: MinIO Server region
  CONSOLE_MINIO_REGION: "${CONSOLE_MINIO_REGION:-us-east-1}"
```

**Default-Wert:** `us-east-1` (wenn nicht in .env gesetzt)

### 5. Haupt-README (README.md)

**Quick Start Beispiel aktualisiert:**

```bash
docker run -d \
  --name admin-console-minio \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  admin-console-minio:latest
```

---

## Verwendung

### Standard AWS-kompatible Region

```bash
docker run --rm \
  --name minio-console \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="https://s3.example.com:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  minio-console:latest
```

### Custom Region (z.B. "shared")

```bash
docker run --rm \
  --name minio-console \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="https://s3.shared.app.bauer-group.com" \
  -e CONSOLE_MINIO_REGION="shared" \
  minio-console:latest
```

### Mit Docker Compose

**1. .env Datei erstellen:**
```bash
cp docker/.env.example docker/.env
```

**2. .env bearbeiten:**
```env
CONSOLE_MINIO_SERVER=https://s3.shared.app.bauer-group.com
CONSOLE_MINIO_REGION=shared
CONSOLE_PBKDF_PASSPHRASE=your-secret-passphrase
CONSOLE_PBKDF_SALT=your-secret-salt
```

**3. Starten:**
```bash
cd docker
docker-compose up -d
```

---

## Häufig verwendete Regionen

| Region | Verwendung |
|--------|------------|
| `us-east-1` | AWS Standard (Default für die meisten MinIO-Installationen) |
| `eu-west-1` | Europa (Irland) |
| `eu-central-1` | Europa (Frankfurt) |
| `ap-southeast-1` | Asien-Pazifik (Singapur) |
| `custom-name` | Benutzerdefinierte Region (z.B. `shared`, `production`, etc.) |

---

## Fehlerbehandlung

### Container startet nicht - Region fehlt

**Fehlermeldung:**
```
❌ ERROR: CONSOLE_MINIO_REGION is not set!
   Please set the MinIO server region, e.g.:
   export CONSOLE_MINIO_REGION=us-east-1
   OR
   export CONSOLE_MINIO_REGION=shared
```

**Lösung:**
```bash
# Region hinzufügen
docker run ... -e CONSOLE_MINIO_REGION="us-east-1" ...
```

### Falsche Region konfiguriert

**Fehlermeldung:**
```
ErrorWithContext:The authorization header is malformed; the region is wrong; expecting 'us-east-1'.
```

**Lösung:**
1. Prüfen Sie die Region Ihres MinIO-Servers
2. Setzen Sie die korrekte Region in der Umgebungsvariable

**MinIO Server Region herausfinden:**
```bash
# Mit mc (MinIO Client)
mc admin info your-minio-alias

# Oder in den MinIO Server Logs
docker logs your-minio-container | grep region
```

---

## Validierung

Nach dem Start sollten Sie folgende Ausgabe sehen:

```
MinIO Console - Starting...
⚠️  WARNING: CONSOLE_PBKDF_PASSPHRASE was not set!
   Generated random passphrase for this session.
   ...

⚠️  WARNING: CONSOLE_PBKDF_SALT was not set!
   Generated random salt for this session.
   ...

✅ Configuration validated
   MinIO Server: https://s3.shared.app.bauer-group.com
   MinIO Region: shared
   Console Port: 9090

Serving console at http://[::]:9090
```

**Wichtig:** Keine Fehlermeldungen über "region is wrong" mehr!

---

## Rückwärtskompatibilität

⚠️ **BREAKING CHANGE**

Diese Änderung bricht die Rückwärtskompatibilität. Bestehende Docker-Befehle müssen aktualisiert werden:

**Alt (funktioniert nicht mehr):**
```bash
docker run -e CONSOLE_MINIO_SERVER="http://minio:9000" minio-console
```

**Neu (erforderlich):**
```bash
docker run \
  -e CONSOLE_MINIO_SERVER="http://minio:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  minio-console
```

---

## Build und Deployment

**Nach diesen Änderungen müssen Sie neu bauen:**

```bash
# Docker Image neu bauen
cd docker
docker build -t minio-console:latest ..

# Oder mit spezifischem Tag
docker build -t admin-console-minio:1.7.6-extended ..
```

**Deployment aktualisieren:**

```bash
# Alten Container stoppen und entfernen
docker stop minio-console
docker rm minio-console

# Neuen Container mit Region starten
docker run -d \
  --name minio-console \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="https://s3.shared.app.bauer-group.com" \
  -e CONSOLE_MINIO_REGION="shared" \
  minio-console:latest
```

---

## Testing

**1. Container ohne Region starten (sollte fehlschlagen):**
```bash
docker run --rm \
  -e CONSOLE_MINIO_SERVER="http://minio:9000" \
  minio-console:latest
```

**Erwartete Ausgabe:**
```
❌ ERROR: CONSOLE_MINIO_REGION is not set!
```

**2. Container mit Region starten (sollte funktionieren):**
```bash
docker run --rm \
  -e CONSOLE_MINIO_SERVER="http://minio:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  minio-console:latest
```

**Erwartete Ausgabe:**
```
✅ Configuration validated
   MinIO Server: http://minio:9000
   MinIO Region: us-east-1
   Console Port: 9090
```

---

**Version:** 1.7.6-extended
**Status:** ✅ Produktionsbereit
**Breaking Change:** Ja - CONSOLE_MINIO_REGION ist jetzt erforderlich
