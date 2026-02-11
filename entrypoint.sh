#!/bin/sh
set -e

echo "Admin Console for MinIO - Starting..."

# Generate a random secret
generate_secret() {
    head -c 32 /dev/urandom | base64 | tr -d '\n'
}

# Auto-generate JWT secrets if not set
if [ -z "$CONSOLE_PBKDF_PASSPHRASE" ]; then
    export CONSOLE_PBKDF_PASSPHRASE=$(generate_secret)
    echo "WARNING: CONSOLE_PBKDF_PASSPHRASE not set - generated random value."
    echo "         Sessions will be lost on container restart."
fi

if [ -z "$CONSOLE_PBKDF_SALT" ]; then
    export CONSOLE_PBKDF_SALT=$(generate_secret)
    echo "WARNING: CONSOLE_PBKDF_SALT not set - generated random value."
    echo "         Sessions will be lost on container restart."
fi

# Validate required configuration
if [ -z "$CONSOLE_MINIO_SERVER" ]; then
    echo "ERROR: CONSOLE_MINIO_SERVER is not set!"
    echo "  Example: CONSOLE_MINIO_SERVER=http://minio:9000"
    exit 1
fi

if [ -z "$CONSOLE_MINIO_REGION" ]; then
    echo "ERROR: CONSOLE_MINIO_REGION is not set!"
    echo "  Example: CONSOLE_MINIO_REGION=us-east-1"
    exit 1
fi

echo "Configuration:"
echo "  MinIO Server: $CONSOLE_MINIO_SERVER"
echo "  MinIO Region: $CONSOLE_MINIO_REGION"
echo "  Console Port: ${CONSOLE_PORT:-9090}"
echo ""

exec /app/console "$@"
