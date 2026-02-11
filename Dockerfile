# Multi-stage Dockerfile for Admin Console for MinIO
# Builds frontend (React/TypeScript) and backend (Go) in optimized stages

# Stage 1: Build Frontend
FROM node:22-alpine AS frontend-builder

RUN apk add --no-cache git

WORKDIR /workspace/web-app

COPY web-app/ ./
RUN corepack enable && corepack prepare && yarn install && yarn build

# Stage 2: Build Backend
FROM golang:1.26-alpine AS backend-builder

RUN apk add --no-cache ca-certificates tzdata git

WORKDIR /workspace

# Go module caching
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Copy built frontend assets from previous stage
COPY --from=frontend-builder /workspace/web-app/build ./web-app/build

# Build static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -trimpath \
    --tags=kqueue \
    -ldflags='-w -s -extldflags "-static"' \
    -o console \
    ./cmd/console

# Stage 3: Runtime
FROM alpine:3.23

# Metadata
LABEL vendor="karlspace"
LABEL maintainer="Karl Bauer <karl.bauer@bauer-group.com>"

# OCI Metadata (https://github.com/opencontainers/image-spec/blob/main/annotations.md)
LABEL org.opencontainers.image.title="Admin Console for MinIO"
LABEL org.opencontainers.image.licenses="AGPL-3.0"
LABEL org.opencontainers.image.vendor="karlspace"
LABEL org.opencontainers.image.authors="Karl Bauer <karl.bauer@bauer-group.com>"
LABEL org.opencontainers.image.source="https://github.com/karlspace/MinIO-UI"
LABEL org.opencontainers.image.url="https://github.com/karlspace/MinIO-UI"
LABEL org.opencontainers.image.documentation="https://github.com/karlspace/MinIO-UI#readme"
LABEL org.opencontainers.image.description="Web-based admin console for MinIO object storage servers, preserving full admin functionality from Console v1.7.x"
LABEL org.opencontainers.image.version="0.0.0"

RUN apk add --no-cache ca-certificates curl tzdata

# Create non-root user
RUN addgroup -g 1000 console && \
    adduser -D -u 1000 -G console console

WORKDIR /app

# Copy binary and entrypoint
COPY --from=backend-builder /workspace/console /app/console
COPY entrypoint.sh /app/entrypoint.sh

# Fix line endings and set permissions
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    chown -R console:console /home/console /app

USER console

EXPOSE 9090

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -sf http://localhost:9090/api/v1/health || exit 1

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["server"]
