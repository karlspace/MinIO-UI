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

## Add to Existing MinIO Stack

The pre-built image is available from GitHub Container Registry:

```
ghcr.io/karlspace/minio-ui/minio-admin-console:latest
```

To integrate the Admin Console into an existing MinIO stack, add the following service to your `docker-compose.yml`:

```yaml
services:
  # ... existing MinIO services ...

  admin-console:
    image: ghcr.io/karlspace/minio-ui/minio-admin-console:latest
    container_name: admin-console-minio
    restart: unless-stopped
    environment:
      CONSOLE_MINIO_SERVER: "http://minio:9000"
      CONSOLE_MINIO_REGION: "us-east-1"
    ports:
      - "9090:9090"
    depends_on:
      minio:
        condition: service_healthy
    networks:
      - minio
```

> **Note:** `CONSOLE_MINIO_SERVER` must point to the MinIO S3 API (port 9000),
> not the built-in MinIO Console (port 9001). The hostname must be reachable
> within the Docker network.

The console authenticates with a MinIO user that has admin privileges.
This user must be created beforehand (e.g. via `mc admin user add`).

| Variable               | Description                                       |
|------------------------|---------------------------------------------------|
| `CONSOLE_MINIO_SERVER` | URL to MinIO Server (e.g. `http://minio:9000`)    |
| `CONSOLE_MINIO_REGION` | MinIO region (default: `us-east-1`)               |

---

## Development

A complete development environment with MinIO server, init container, and console is provided:

```bash
docker compose -f docker-compose.development.yml up --build
```

After startup:

- **Admin Console** on `http://localhost:9090` (login: `minioconsole` / `minioconsole`)
- **MinIO API** on `http://localhost:9000`

Copy `.env.example` to `.env` to customize. See `docker-compose.development.yml` for all available variables.

---

## Build from Source

### Prerequisites

- Go 1.26+
- Node.js 22+ (LTS)
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

## Related Forks

| Project                                              | Description                                                                                                                                                                  | Status       |
|------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| [OpenMaxIO/mds](https://github.com/OpenMaxIO/mds)   | 1:1 Fork of MinIO Design System (minio/mds). Used as dependency source since the original repo was deleted. Our fork: [karlspace/MinIO-MDS](https://github.com/karlspace/MinIO-MDS) | Maintained   |
| [opens3](https://github.com/opens3)                 | Community fork of several MinIO repos (mds, object-browser). Has own branding (OpenS3 logo, modified login page). No tags/releases, no security patches.                    | Unmaintained |
| [OpenMaxIO](https://github.com/OpenMaxIO)           | Fork of the full MinIO Console with admin features preserved. Source for cherry-picked security patches.                                                                     | Maintained   |

---

## License

GNU Affero General Public License v3.0 - see [LICENSE](LICENSE).
