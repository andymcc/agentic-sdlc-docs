# Testing Strategy

## Coverage Requirements

- **Minimum**: 75% line coverage enforced in CI.
- Coverage is measured per PR. The gate applies to the total project coverage.

## Test Types

### Unit Tests
- Live next to the code: `foo.go` → `foo_test.go`
- Use table-driven tests for multiple input/output cases.
- Use `testing.T` helpers, not assertion libraries.
- No external dependencies — unit tests must run offline.

### Integration Tests
- Use build tag `//go:build integration` to separate from unit tests.
- Run with `go test -tags=integration ./...`
- May start real HTTP servers using `httptest.NewServer`.
- May use testcontainers for database/service dependencies.

## Conventions

- Always use `-race` flag: `go test -race ./...`
- Use `t.Parallel()` where tests are independent.
- Use `t.Helper()` in test helper functions.
- Prefer `t.Setenv()` over `os.Setenv()` for env-based config tests.
- Name test functions `TestXxx_description` for clarity.

## Running Tests

```bash
make test               # Unit tests with race detector
make test-cover         # Unit tests with coverage report
go test -tags=integration ./...  # Integration tests
```
