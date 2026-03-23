# Architecture

## Overview

HTTP server built with Go stdlib. No frameworks — keep dependencies minimal.

## Package Responsibilities

| Package | Purpose |
|---------|---------|
| `cmd/server` | Entry point. Wires config, handlers, and starts the HTTP server with graceful shutdown. |
| `internal/config` | Loads configuration from environment variables. Single `Config` struct. |
| `internal/handler` | HTTP handlers. Each handler is a function registered via `Register(mux)`. |
| `internal/middleware` | HTTP middleware (logging, recovery, CORS, etc). Applied in `cmd/server`. |

## Design Principles

1. **Stdlib first** — Use Go's standard library. Add a dependency only when the stdlib alternative would be significantly worse.
2. **Flat packages** — Avoid deep nesting. Each package under `internal/` owns one concern.
3. **Explicit wiring** — No init() functions, no global state. Dependencies are passed explicitly.
4. **Structured logging** — All logging via `slog`. JSON output in production.
5. **Graceful shutdown** — Server handles SIGINT/SIGTERM and drains in-flight requests.

## Adding a New Feature

1. Create a package under `internal/` if it represents a new domain.
2. Add HTTP handlers to `internal/handler/` and register them in `Register()`.
3. Add configuration knobs to `internal/config/config.go`.
4. Write tests next to the implementation.
5. Run `make check` to validate.
