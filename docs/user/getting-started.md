# Getting Started

## Prerequisites

- Go 1.23 or later

## Running the Server

```bash
make run
```

The server starts on port 8080 by default. Override with the `PORT` environment variable:

```bash
PORT=3000 make run
```

## Verify It Works

```bash
curl http://localhost:8080/healthz
```

Expected response:

```json
{"status": "ok"}
```

## Configuration

All configuration is via environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `8080` | HTTP listen port |
| `LOG_LEVEL` | `info` | Log level (`info` or `debug`) |
