# Agentic SDLC App

A Go HTTP server scaffolded using agentic Software Delivery Lifecycle principles, informed by [OpenAI's Harness Engineering](https://openai.com/index/harness-engineering/) methodology and the [ETH Zurich AGENTS.md evaluation paper](https://arxiv.org/html/2602.11988v1).

## What is this?

A reference implementation demonstrating how to structure a repository for agent-driven development. The repo is designed so that AI coding agents can reliably build features, write tests, generate docs, and validate their own work — with CI enforcing the constraints that matter.

## Key design principles

- **Minimal agent context files** — `AGENTS.md` and `CLAUDE.md` are short, requirement-focused, and human-written. No codebase overviews, no auto-generated content ([why](docs/memory/agents-md-paper.md)).
- **Docs as system of record** — `docs/` contains the real knowledge. Agent context files point to it rather than duplicating it.
- **CI enforces, prose suggests** — Coverage gates, lint rules, and docs sync checks catch what instructions alone can't.
- **Worktree-bootable** — Agents can launch an isolated instance per change via `scripts/boot.sh`.
- **Docs ship with features** — API reference is generated from an OpenAPI spec. CI fails if they drift out of sync.

## Quick start

```bash
# Prerequisites: Go 1.23+
make run            # Build and start server on :8080
curl localhost:8080/healthz
```

## Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the binary to `bin/server` |
| `make run` | Build and start the server |
| `make test` | Run tests with race detector |
| `make test-cover` | Run tests with coverage report |
| `make lint` | Run golangci-lint |
| `make fmt` | Format code (gofmt + goimports) |
| `make check` | Run all CI checks locally |
| `make docs-gen` | Regenerate API reference from OpenAPI spec |
| `make docs-check` | Verify generated docs are in sync |
| `make docs-serve` | Serve user docs locally (requires mkdocs) |

## Project structure

```
cmd/server/           Entry point with graceful shutdown
internal/             Application packages (config, handler, middleware)
docs/                 System of record
  ├── architecture.md   System design and package responsibilities
  ├── development.md    Development workflow and conventions
  ├── testing.md        Testing strategy and coverage requirements
  ├── ci-cd.md          CI/CD pipeline
  ├── api/openapi.yaml  API spec (source of truth)
  ├── user/             User-facing documentation
  └── memory/           Research notes and design decisions
scripts/              Automation (boot, doc generation, sync checks)
.github/workflows/    CI with coverage gate and agent review placeholder
```

## Research background

This repo's approach is shaped by two sources:

- **[Harness Engineering](https://openai.com/index/harness-engineering/)** — OpenAI's methodology for agent-first development. Key takeaway: treat AGENTS.md as a table of contents, not an encyclopedia. Make constraints enforceable, not just documented.

- **[Evaluating AGENTS.md](https://arxiv.org/html/2602.11988v1)** (Gloaguen et al.) — Found that LLM-generated context files decrease agent success rates by 2% while increasing costs by 20%+. Developer-written files help modestly (+4%) only when kept minimal and focused on tooling instructions. See [detailed summary](docs/memory/agents-md-paper.md).
