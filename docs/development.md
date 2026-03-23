# Development Workflow

## Setup

```bash
# Requires Go 1.23+
go version

# Install linter
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
```

## Day-to-Day

```bash
make run          # Build and start server
make test         # Run tests
make check        # Run all CI checks locally
```

## Branch Strategy

- `main` is protected. All changes via PR.
- Branch naming: `feat/description`, `fix/description`, `refactor/description`.
- PRs require CI to pass. Agent review runs automatically on PRs.

## Code Review

PRs go through two review stages:

1. **Automated agent review** — CI triggers an AI agent review step on every PR. This catches style violations, missing tests, and common issues.
2. **Human review** — Required for architectural changes, security-sensitive code, and new dependencies. Optional for agent-validated routine changes.

The goal is to shift routine review to agents, freeing human reviewers for judgment calls that require context agents don't have.

## Worktree Validation

Each change can be validated in isolation using git worktrees:

```bash
git worktree add ../review-branch feature-branch
cd ../review-branch
./scripts/boot.sh
# Validate the running server
git worktree remove ../review-branch
```

This enables agents to boot one instance per change without affecting the main checkout.
