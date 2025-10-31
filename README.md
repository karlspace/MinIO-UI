# Admin Console for MinIO®

![license](https://img.shields.io/badge/license-AGPL%20V3-blue)

**umentation**

---

## ⚠️ Disclaimer

**MinIO® is a registered trademark of MinIO, Inc.**

This project is an **independent, third-party admin interface** and is **not affiliated with, endorsed by, or sponsored by MinIO, Inc.**

This is a community-maintained fork that preserves the full administrative functionality that was available in MinIO Console v1.7.6, with added security updates.

All trademarks, service marks, and company names are the property of their respective owners.

---

## About

Admin Console for MinIO® is a comprehensive web-based management interface for MinIO object storage servers. It provides full administrative capabilities including:

- **User & Group Management** - Manage users, groups, and permissions
- **Policy Administration** - Create and manage IAM policies
- **Bucket Management** - Advanced bucket configuration (versioning, encryption, quota, retention)
- **Dashboard & Monitoring** - Real-time metrics and server health
- **Configuration** - Server and service configuration
- **Identity Provider Integration** - LDAP/AD and OpenID Connect support
- **KMS Integration** - Key Management Service configuration
- **Service Management** - Server control and diagnostics

---

## Installation

### Quick Start with Docker

```bash
docker run -d \
  --name admin-console-minio \
  -p 9090:9090 \
  -e CONSOLE_MINIO_SERVER="http://your-minio-server:9000" \
  -e CONSOLE_MINIO_REGION="us-east-1" \
  admin-console-minio:latest
```

### Build from Source

#### Prerequisites
- Go 1.23 or later
- Node.js 18 or later
- Yarn package manager

#### Backend Build
```bash
# Clone the repository
git clone https://github.com/yourusername/admin-console-minio.git
cd admin-console-minio

# Build the console binary
make console
```

#### Frontend Build
```bash
cd web-app
yarn install
yarn build
cd ..
```

#### Docker Build
```bash
docker build -f docker/Dockerfile -t admin-console-minio:latest .
```

---

## Setup

All Admin Console for MinIO® needs is a MinIO® user with admin privileges and URL pointing to your MinIO® deployment.

> **Note:** We don't recommend using MinIO®'s root credentials

### 1. Create a user `console` using `mc`

```bash
mc admin user add myminio/
Enter Access Key: console
Enter Secret Key: xxxxxxxx
```

### 2. Create a policy for `console` with admin access

```sh
cat > admin.json << EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Action": [
				"admin:*"
			],
			"Effect": "Allow",
			"Sid": ""
		},
		{
			"Action": [
                "s3:*"
			],
			"Effect": "Allow",
			"Resource": [
				"arn:aws:s3:::*"
			],
			"Sid": ""
		}
	]
}
EOF

mc admin policy create myminio/ consoleAdmin admin.json
```

### 3. Assign the policy to the `console` user

```sh
mc admin policy attach myminio consoleAdmin --user=console
```

---

## Configuration

### Required Environment Variables

Before running Admin Console for MinIO®, the following environment settings must be supplied:

```sh
# MinIO® Server Endpoint
export CONSOLE_MINIO_SERVER=http://localhost:9000

# Salt to encrypt JWT payload (optional - auto-generated if not set)
export CONSOLE_PBKDF_PASSPHRASE=SECRET

# Salt for JWT encryption (optional - auto-generated if not set)
export CONSOLE_PBKDF_SALT=SECRET
```

### Start the Console

```bash
./console server
```

By default the console runs on port `9090`. This can be changed with `--port`.

**Example output:**
```
2021-01-19 02:36:08.893735 I | Serving console at http://localhost:9090
```

---

## TLS Configuration

### Start with TLS

Copy your `public.crt` and `private.key` to `~/.console/certs`, then:

```sh
./console server
```

The console will automatically detect certificates and serve both HTTP and HTTPS:
```
Serving console at http://[::]:9090
Serving console at https://[::]:9443
```

### Multiple Domain Support

For advanced users, the console supports multiple certificates for different domains:

```sh
certs/
  │
  ├─ public.crt
  ├─ private.key
  │
  ├─ example.com/
  │   │
  │   ├─ public.crt
  │   └─ private.key
  └─ foobar.org/
     │
     ├─ public.crt
     └─ private.key
```

### Connect to MinIO® with Self-Signed Certificate

Copy the MinIO® `ca.crt` under `~/.console/certs/CAs`, then:

```sh
export CONSOLE_MINIO_SERVER=https://localhost:9000
./console server
```

---

## Docker Deployment

See [docker/README.md](docker/README.md) for comprehensive Docker deployment guide.

### Docker Compose Example

```yaml
version: '3.8'

services:
  admin-console:
    image: admin-console-minio:latest
    container_name: admin-console-minio
    ports:
      - "9090:9090"
      - "9443:9443"
    environment:
      CONSOLE_MINIO_SERVER: "http://minio:9000"
      # Optional: For persistent sessions
      # CONSOLE_PBKDF_PASSPHRASE: "your-secret"
      # CONSOLE_PBKDF_SALT: "your-salt"
    restart: unless-stopped
```

---

## Features

### Full Administrative Suite

- ✅ **User Management** - Create, edit, delete users
- ✅ **Group Management** - Organize users into groups
- ✅ **Policy Management** - IAM policy creation and assignment
- ✅ **Service Accounts** - Create and manage service accounts
- ✅ **Configuration** - Server configuration management
- ✅ **Dashboard** - Real-time metrics and monitoring
- ✅ **Bucket Management** - Advanced bucket features:
  - Versioning
  - Encryption
  - Quota management
  - Retention policies
  - Replication rules
  - Event notifications
  - Access policies
- ✅ **Identity Provider** - LDAP/AD and OpenID integration
- ✅ **KMS Integration** - Key Management Service
- ✅ **Log Search** - Server log analysis
- ✅ **System Tools** - Inspect, diagnostics, speedtest
- ✅ **Service Management** - Server restart and control

### Security

- Built with Go and React/TypeScript
- AGPL v3 licensed
- Regular security updates
- TLS/HTTPS support
- JWT-based authentication
- Non-root Docker container

---

## Development

See [DEVELOPMENT.md](DEVELOPMENT.md) for development setup and guidelines.

### Project Structure

```
admin-console-minio/
├── api/              # Go backend API
├── cmd/console/      # Main application
├── models/           # Data models
├── web-app/          # React frontend
│   └── src/
├── docker/           # Docker configuration
└── integration/      # Integration tests
```

---

## Contributing

We welcome contributions! However, please note:

- This is a **community fork** maintaining full admin features
- **Not affiliated** with the official MinIO® Console project
- Contributions should maintain compatibility with MinIO® servers
- See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines

---

## Version History

This project is based on:
- **Base:** MinIO Console v1.7.6 (last version with full admin features)
- **Security Updates:** Applied patches from v2.0.0 - v2.0.4
- **Status:** Production-ready with full administrative capabilities

See [SECURITY_UPDATES_APPLIED.md](SECURITY_UPDATES_APPLIED.md) for details on applied security patches.

---

## Documentation

- [Docker Deployment Guide](docker/README.md)
- [Development Guide](DEVELOPMENT.md)
- [Security Updates](SECURITY_UPDATES_APPLIED.md)
- [Feature Analysis](ANALYSIS_V2_CHANGES.md)
- [Deployment Guide](DEPLOYMENT_READY.md)

---

## Troubleshooting

### Connection Issues

```bash
# Test MinIO® server connectivity
curl http://your-minio-server:9000/minio/health/live

# Check console logs
./console server --verbose
```

### Debug Logging

Set `CONSOLE_DEBUG_LOGLEVEL` environment variable:
- `0` (default) - No logging
- `1` - Server errors (5xx)
- `2` - Client & server errors (4xx/5xx)
- `3` - All requests
- `4-6` - Detailed logging with headers

---

## License

This project is licensed under the **GNU Affero General Public License v3.0** (AGPL-3.0).

See [LICENSE](LICENSE) for details.

---

## Acknowledgments

This project is built upon the MinIO Console codebase (v1.7.6) and maintains the full administrative functionality that was available before the v2.0 simplification.

**Original MinIO Console:** https://github.com/minio/console

---

## Support & Community

- **Issues:** Report bugs and request features via GitHub Issues
- **Discussions:** Community discussions and support
- **Documentation:** See [docs](docs/) directory

---

**Project Status:** ✅ Production Ready
**Last Updated:** 2025-10-31
**Version:** 1.7.6-extended (with security updates through v2.0.4)
