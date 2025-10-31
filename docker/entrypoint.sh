#!/bin/sh
set -e

echo "MinIO Console - Starting..."

# Function to generate a random secret
generate_secret() {
    # Generate a 32-byte random string and encode it in base64
    head -c 32 /dev/urandom | base64 | tr -d '\n'
}

# Check and generate CONSOLE_PBKDF_PASSPHRASE if not set
if [ -z "$CONSOLE_PBKDF_PASSPHRASE" ]; then
    export CONSOLE_PBKDF_PASSPHRASE=$(generate_secret)
    echo "⚠️  WARNING: CONSOLE_PBKDF_PASSPHRASE was not set!"
    echo "   Generated random passphrase for this session."
    echo "   Sessions will be lost on container restart."
    echo "   Set CONSOLE_PBKDF_PASSPHRASE environment variable for persistence."
    echo ""
fi

# Check and generate CONSOLE_PBKDF_SALT if not set
if [ -z "$CONSOLE_PBKDF_SALT" ]; then
    export CONSOLE_PBKDF_SALT=$(generate_secret)
    echo "⚠️  WARNING: CONSOLE_PBKDF_SALT was not set!"
    echo "   Generated random salt for this session."
    echo "   Sessions will be lost on container restart."
    echo "   Set CONSOLE_PBKDF_SALT environment variable for persistence."
    echo ""
fi

# Check if CONSOLE_MINIO_SERVER is set
if [ -z "$CONSOLE_MINIO_SERVER" ]; then
    echo "❌ ERROR: CONSOLE_MINIO_SERVER is not set!"
    echo "   Please set the MinIO server endpoint, e.g.:"
    echo "   export CONSOLE_MINIO_SERVER=http://minio:9000"
    echo ""
    exit 1
fi

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

echo "✅ Configuration validated"
echo "   MinIO Server: $CONSOLE_MINIO_SERVER"
echo "   MinIO Region: $CONSOLE_MINIO_REGION"
echo "   Console Port: ${CONSOLE_PORT:-9090}"
echo ""

# Execute the console binary with all arguments
exec /app/console "$@"
