# MinIO Console Docker Build

This directory contains the Docker configuration for building and running MinIO Console.

## Files

- **Dockerfile**: Multi-stage build for MinIO Console
- **.dockerignore**: Excludes unnecessary files from Docker context
- **docker-compose.yml**: Example Docker Compose setup
- **README.md**: This file

## Quick Start

### Build the Docker Image

From the project root directory:

```bash
docker build -f docker/Dockerfile -t minio-console:latest .
```

Or from the docker directory:

```bash
cd docker
docker build -f Dockerfile -t minio-console:latest ..
```

### Run with Docker

**Simplest way (auto-generates secrets):**
```bash
docker run -d \
  --name minio-console \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  minio-console:latest
```

**With persistent sessions (recommended for production):**
```bash
docker run -d \
  --name minio-console \
  -p 9090:9090 \
  -e CONSOLE_PBKDF_PASSPHRASE="your-secret-passphrase" \
  -e CONSOLE_PBKDF_SALT="your-secret-salt" \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  minio-console:latest
```

### Run with Docker Compose

1. Copy the example environment file:
   ```bash
   cp docker/.env.example docker/.env
   ```

2. Edit `docker/.env` and set your configuration:
   ```env
   CONSOLE_PBKDF_PASSPHRASE=your-secret-passphrase
   CONSOLE_PBKDF_SALT=your-secret-salt
   CONSOLE_MINIO_SERVER=http://minio:9000
   ```

3. Start the services:
   ```bash
   cd docker
   docker-compose up -d
   ```

## Configuration

### Required Environment Variables

- `CONSOLE_MINIO_SERVER`: URL of your MinIO server (e.g., `http://localhost:9000`)

### Auto-Generated Environment Variables

These are **optional** but **recommended for production**. If not set, they will be auto-generated on startup:

- `CONSOLE_PBKDF_PASSPHRASE`: Secret passphrase for JWT encryption (auto-generated if not set)
- `CONSOLE_PBKDF_SALT`: Salt for JWT encryption (auto-generated if not set)

**⚠️ Important:** Without setting these values, user sessions will be lost on container restart!

Generate secure values with:
```bash
echo "CONSOLE_PBKDF_PASSPHRASE=$(openssl rand -base64 32)"
echo "CONSOLE_PBKDF_SALT=$(openssl rand -base64 32)"
```

### Optional Environment Variables

- `CONSOLE_PORT`: HTTP port (default: 9090)
- `CONSOLE_TLS_PORT`: HTTPS port (default: 9443)
- `CONSOLE_DEBUG_LOGLEVEL`: Debug logging level (0-6, default: 0)
- `CONSOLE_TLS_CERTIFICATE`: Path to TLS certificate
- `CONSOLE_TLS_KEY`: Path to TLS private key

### TLS Configuration

To use TLS, mount your certificates:

```bash
docker run -d \
  --name minio-console \
  -p 9090:9090 \
  -p 9443:9443 \
  -v /path/to/certs:/home/console/.console/certs:ro \
  -e CONSOLE_PBKDF_PASSPHRASE="secret" \
  -e CONSOLE_PBKDF_SALT="salt" \
  -e CONSOLE_MINIO_SERVER="http://minio:9000" \
  minio-console:latest
```

Certificate structure:
```
certs/
├─ public.crt
├─ private.key
└─ CAs/
   └─ ca.crt (optional, for MinIO with self-signed certs)
```

## Build Arguments

The Dockerfile supports customization through build stages:

- **frontend-builder**: Builds the React/TypeScript frontend
- **backend-builder**: Builds the Go backend
- **runtime**: Minimal Alpine-based runtime image

## Ports

- **9090**: HTTP Console interface
- **9443**: HTTPS Console interface (when TLS is configured)

## Health Check

The container includes a health check that pings the `/api/v1/health` endpoint every 30 seconds.

Check health status:
```bash
docker ps --filter name=minio-console
```

## Troubleshooting

### View logs

```bash
docker logs minio-console
```

### Interactive shell

```bash
docker exec -it minio-console sh
```

### Check if service is running

```bash
curl http://localhost:9090/api/v1/health
```

## Security Notes

1. **Never use default credentials in production**
2. Use strong, randomly generated values for `CONSOLE_PBKDF_PASSPHRASE` and `CONSOLE_PBKDF_SALT`
3. Always use TLS in production environments
4. The container runs as non-root user `console` (UID 1000)

## Building for Different Architectures

For ARM64 (e.g., Apple Silicon, ARM servers):
```bash
docker build --platform linux/arm64 -f docker/Dockerfile -t minio-console:arm64 .
```

For multi-platform build:
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -f docker/Dockerfile \
  -t minio-console:latest \
  .
```

## Advanced Usage

### Custom Build Version

Set build version and time:
```bash
docker build \
  -f docker/Dockerfile \
  --build-arg BUILD_VERSION=$(git describe --tags) \
  --build-arg BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  -t minio-console:custom \
  .
```

### Development Mode

For development, you can mount the source code:
```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  golang:1.23-alpine \
  sh -c "go run ./cmd/console server"
```

## Resources

- [MinIO Console Documentation](https://github.com/minio/console)
- [MinIO Server Documentation](https://min.io/docs)
- [Docker Documentation](https://docs.docker.com)
