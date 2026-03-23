# Claude Code Instructions

## Build & Test Commands

- Build: `make build`
- Test: `make test`
- Test with coverage: `make test-cover`
- Lint: `make lint`
- Format: `make fmt`
- All checks (CI parity): `make check`
- Single package test: `go test ./internal/handler/ -race -v`
- Generate API docs: `make docs-gen`
- Check docs in sync: `make docs-check`

## Conventions

- Use Go stdlib where possible. Avoid unnecessary dependencies.
- All packages go under `internal/`.
- Use `slog` for logging, never `fmt.Println`.
- Return errors with context: `fmt.Errorf("doing thing: %w", err)`.
- Test files sit next to the code they test: `foo.go` → `foo_test.go`.
- Use table-driven tests for multiple cases.
- HTTP handlers in `internal/handler/`, registered via `Register(mux)`.
- Config via env vars, loaded in `internal/config/`.

## Docs Workflow

- API spec lives at `docs/api/openapi.yaml` — update this when adding/changing endpoints.
- Run `make docs-gen` to regenerate `docs/user/api-reference.md` from the spec.
- Never edit `docs/user/api-reference.md` by hand.
- `make check` includes `docs-check` so you can't forget.

## Before Submitting

Always run `make check` before considering work complete.
