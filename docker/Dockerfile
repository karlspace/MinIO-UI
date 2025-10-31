# Multi-stage Dockerfile for MinIO Console
# This builds both the frontend (React/TypeScript) and backend (Go) in optimized stages

# Stage 1: Build Frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /workspace/web-app

# Copy frontend package files for dependency installation
COPY web-app/package.json web-app/.yarnrc.yml ./

# Install dependencies (generates new lockfile due to package rename)
# Note: Not copying old yarn.lock because package.json name was changed (rebranding)
RUN corepack enable && \
    yarn install

# Copy frontend source code
COPY web-app/ ./

# Build static assets
RUN yarn build

# Stage 2: Build Backend
FROM golang:1.23-alpine AS backend-builder

# Install build dependencies
RUN apk add --no-cache git make

WORKDIR /workspace

# Copy go mod files first for better layer caching
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Ensure go.mod and go.sum are in sync
RUN go mod tidy

# Copy built frontend assets from previous stage
COPY --from=frontend-builder /workspace/web-app/build ./web-app/build

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -trimpath \
    --tags=kqueue \
    --ldflags "-s -w" \
    -o console \
    ./cmd/console

# Stage 3: Runtime
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache ca-certificates tzdata wget

# Create non-root user
RUN addgroup -g 1000 console && \
    adduser -D -u 1000 -G console console

WORKDIR /app

# Copy binary from builder
COPY --from=backend-builder /workspace/console /app/console

# Copy entrypoint script
COPY docker/entrypoint.sh /app/entrypoint.sh

# Create directory for certificates and set permissions
# Fix line endings for entrypoint script (in case of Windows CRLF)
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    mkdir -p /home/console/.console/certs && \
    chown -R console:console /home/console /app

# Switch to non-root user
USER console

# Expose ports
# 9090: HTTP Console
# 9443: HTTPS Console (if certificates are provided)
EXPOSE 9090 9443

# Environment variables (can be overridden at runtime)
ENV CONSOLE_PORT=9090

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:${CONSOLE_PORT}/api/v1/health || exit 1

# Run the console server via entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["server"]
