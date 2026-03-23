# CI/CD Pipeline

## GitHub Actions

CI runs on every push to `main` and on all PRs. Defined in `.github/workflows/ci.yml`.

### Pipeline Stages

| Stage | What it does |
|-------|-------------|
| Format check | Verifies `gofmt` produces no diffs |
| Vet | Runs `go vet` for correctness issues |
| Lint | Runs golangci-lint with project config |
| Test | Runs all tests with race detector and coverage |
| Coverage gate | Fails if coverage drops below 75% |
| Build | Compiles the binary to verify it links |
| Agent review | AI-powered PR review (on PRs only, after checks pass) |

### Agent Review

The agent review step runs after all checks pass. It is a placeholder — configure it with your preferred AI review tool. The intent is that routine PRs can be reviewed entirely by agents, with humans reviewing only when:

- New dependencies are added
- Security-sensitive code is changed
- Architectural patterns are introduced or modified
- The agent flags something for human attention

## Local CI Parity

Run `make check` locally to mirror the CI pipeline before pushing. This runs format, vet, lint, and test in sequence.

## Deployment

Deployment configuration is not yet set up. When ready, add a deploy job to the CI workflow that triggers on merges to `main`.
