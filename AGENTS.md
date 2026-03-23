# Agent Guide

This file is a table of contents. Detailed docs live in `docs/`.

## Tooling

- **Language**: Go 1.23+
- **Build**: `make build`
- **Test**: `make test`
- **Lint**: `make lint` (golangci-lint)
- **Format**: `make fmt` (gofmt + goimports)
- **All checks**: `make check` (mirrors CI)

## Project Layout

```
cmd/server/       Entry point
internal/         Private packages (config, handler, middleware)
docs/             System of record for architecture and workflows
scripts/          Automation scripts (boot.sh for worktree validation)
.github/workflows CI definitions
```

## Key Rules

1. Run `make check` before submitting any PR. CI enforces the same checks.
2. All new code must have tests. Coverage gate is 75%.
3. Use `internal/` for all application packages. Do not create top-level packages.
4. Use `slog` for structured logging. No `fmt.Println` or `log.Printf`.
5. Errors must be returned, not logged-and-ignored. Wrap with context using `fmt.Errorf("context: %w", err)`.
6. HTTP handlers go in `internal/handler/`. Register them via `handler.Register(mux)`.
7. Configuration is via environment variables, loaded in `internal/config/`.
8. New or changed endpoints require updating `docs/api/openapi.yaml` and running `make docs-gen`.
9. Never edit `docs/user/api-reference.md` by hand — it is generated from the OpenAPI spec.

## Validation

To validate a change in an isolated worktree:

```bash
./scripts/boot.sh
```

This builds, tests, and starts the server. Use `curl localhost:8080/healthz` to verify.

## Documentation

See `docs/` for:
- `docs/architecture.md` — System design and package responsibilities
- `docs/development.md` — Development workflow and conventions
- `docs/testing.md` — Testing strategy and coverage requirements
- `docs/ci-cd.md` — CI/CD pipeline and deployment

User-facing docs:
- `docs/api/openapi.yaml` — API spec (source of truth)
- `docs/user/` — User documentation (served via mkdocs)
- `make docs-gen` — Regenerate API reference from spec
- `make docs-check` — Verify docs are in sync (runs in CI)
