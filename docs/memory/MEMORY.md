# Project Memory

## Project
Go HTTP server scaffolded with agentic SDLC principles. Repo at `/Users/amccrae/repos/agentic_sdlc_docs`.

## Key References
- [OpenAI Harness Engineering](https://openai.com/index/harness-engineering/) — see `harness-engineering.md`
- [arxiv 2602.11988v1 - Evaluating AGENTS.md](https://arxiv.org/html/2602.11988v1) — see `agents-md-paper.md`
- Docs structure and generation loop — see `docs-structure.md`

## Design Decisions
- AGENTS.md is a minimal table of contents (~50 lines), not an encyclopedia
- CLAUDE.md is human-written, requirement-focused, no codebase overviews
- `docs/` is the system of record; agent context files point to it, don't duplicate it
- CI enforces constraints (coverage gate 75%, docs sync check) rather than relying on prose guidance
- API docs generated from `docs/api/openapi.yaml` via `scripts/gen-api-docs.sh`
- App is worktree-bootable via `scripts/boot.sh`
