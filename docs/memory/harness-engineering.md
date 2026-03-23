# OpenAI Harness Engineering

Source: https://openai.com/index/harness-engineering/

## Key principles
- AGENTS.md as table of contents (~100 lines), not encyclopedia
- Repository knowledge lives in structured `docs/` directory as system of record
- When something fails, ask "what capability is missing and how to make it legible/enforceable for the agent?" — don't just "try harder"
- App must be bootable per git worktree so agents can launch one instance per change
- Push review effort toward agent-to-agent; humans review only judgment calls
- Enforceable constraints (linters, CI, coverage gates) over prose guidance

## Scale evidence
- 3 engineers built ~1M lines in 5 months, zero hand-written code
- 3.5 PRs per engineer per day, throughput increased as team grew
- Estimated 1/10th the time of manual development

## What we adopted
- Minimal AGENTS.md pointing to docs/
- Worktree-bootable app via scripts/boot.sh
- CI with agent review placeholder step
- `make check` mirrors CI exactly for local validation
- Structured docs/ as the real knowledge base
