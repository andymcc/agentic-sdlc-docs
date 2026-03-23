# Docs Structure & Operation

## Layout

```
docs/
├── architecture.md      # Internal: system design, package responsibilities
├── development.md       # Internal: dev workflow, branch strategy, review process
├── testing.md           # Internal: test types, conventions, coverage requirements
├── ci-cd.md             # Internal: pipeline stages, agent review, deployment
├── api/
│   └── openapi.yaml     # Source of truth for the API surface
└── user/
    ├── getting-started.md    # User-facing: setup and first run
    └── api-reference.md      # GENERATED from openapi.yaml — never edit by hand
```

## Two audiences
- `docs/*.md` — Internal engineering docs (system of record). AGENTS.md points here. Agents discover these on their own.
- `docs/user/` — External user-facing docs. Served via mkdocs.

## Generation loop
1. Agent updates endpoint in `internal/handler/`
2. AGENTS.md rule 8 tells agent to update `docs/api/openapi.yaml`
3. Agent runs `make docs-gen` → `scripts/gen-api-docs.sh` parses spec with yq → generates `docs/user/api-reference.md`
4. `make check` runs `docs-check` → `scripts/docs-check.sh` regenerates and diffs against committed version. Mismatch = build failure.
5. User-facing prose docs written by agents as part of feature PRs, reviewed by humans for accuracy.

## Commands
- `make docs-gen` — Regenerate api-reference.md from OpenAPI spec
- `make docs-check` — Verify generated docs match spec (included in `make check`)
- `make docs-serve` — Serve user docs locally via mkdocs

## Core principle
OpenAPI spec is single source of truth. Generation is automated. CI enforces sync.
