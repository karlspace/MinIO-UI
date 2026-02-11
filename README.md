# Admin Console for MinIO

![license](https://img.shields.io/badge/license-AGPL%20V3-blue)

> **MinIO is a registered trademark of MinIO, Inc.**
> This project is an independent, third-party admin interface and is not affiliated with, endorsed by, or sponsored by MinIO, Inc.

---

## About

A web-based admin console for MinIO object storage servers. This fork preserves the full administrative functionality from MinIO Console v1.7.x that was removed in the upstream v2.0 simplification, with ongoing security updates applied.

### Features

- **User & Group Management** - Create, edit, delete users and groups
- **Policy Administration** - IAM policy creation and assignment
- **Bucket Management** - Versioning, encryption, quota, retention, replication, notifications
- **Dashboard & Monitoring** - Real-time metrics and server health
- **Configuration** - Server and service configuration
- **Identity Provider Integration** - LDAP/AD and OpenID Connect
- **KMS Integration** - Key Management Service configuration
- **Service Management** - Server control and diagnostics

---

## Quick Start (Docker)

```bash
docker compose -f docker-compose.development.yml up --build
```

This starts:
- **MinIO Server** on `localhost:9000` (API) and `localhost:9001` (built-in console)
- **Admin Console** on `localhost:9090`

Login with `minioadmin` / `minioadmin`.

### Environment

Copy `.env.example` to `.env` to customize:

```bash
cp .env.example .env
```

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `CONSOLE_MINIO_SERVER` | Yes | `http://minio:9000` | MinIO server endpoint |
| `CONSOLE_MINIO_REGION` | Yes | `us-east-1` | MinIO server region |
| `CONSOLE_PBKDF_PASSPHRASE` | No | auto-generated | JWT encryption secret |
| `CONSOLE_PBKDF_SALT` | No | auto-generated | JWT salt |
| `MINIO_ROOT_USER` | No | `minioadmin` | MinIO root user (dev) |
| `MINIO_ROOT_PASSWORD` | No | `minioadmin` | MinIO root password (dev) |

---

## Build from Source

### Prerequisites

- Go 1.26+
- Node.js 24+ (LTS)
- Yarn (via corepack)

### Backend

```bash
make console
```

### Frontend

```bash
cd web-app
corepack enable
yarn install
yarn build
```

### Docker Image

```bash
docker build -t admin-console-minio:latest .
```

### Run

```bash
export CONSOLE_MINIO_SERVER=http://localhost:9000
export CONSOLE_MINIO_REGION=us-east-1
./console server
```

The console starts on port `9090` (configurable with `--port`).

---

## Project Structure

```
.
├── Dockerfile                        # Multi-stage build (frontend + backend)
├── docker-compose.development.yml    # Development stack (Console + MinIO)
├── entrypoint.sh                     # Container entrypoint with config validation
├── .env.example                      # Environment template
├── Makefile                          # Build targets
├── cmd/console/                      # Go entry point
├── api/                              # Go backend API (incl. admin endpoints)
├── models/                           # Swagger-generated data models
├── pkg/                              # Shared Go packages
├── web-app/                          # React/TypeScript frontend
│   └── src/
├── swagger.yml                       # API specification
└── MINIO_SERVER_API_CALLS.md         # MinIO Server API documentation
```

---

## Version

Based on MinIO Console v1.7.6 with security patches from v2.0.x applied.

See [MINIO_SERVER_API_CALLS.md](MINIO_SERVER_API_CALLS.md) for the MinIO Server API documentation.

---

## License

GNU Affero General Public License v3.0 - see [LICENSE](LICENSE).
