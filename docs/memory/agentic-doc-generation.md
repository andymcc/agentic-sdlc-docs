# Agentic User Doc Generation

## Core principle
Docs are a deliverable of the same PR that ships the feature — written by the same agent, validated by CI, reviewed by another agent or human.

## Three types of user docs

### 1. Reference docs (API, config, CLI flags)
- Generate, don't author
- Source of truth (OpenAPI spec, struct tags, CLI flags) → script generates docs
- Agent updates the spec, not the docs
- CI verifies sync

### 2. Task-oriented docs (guides, tutorials, how-tos)
- Agent drafts as part of the feature PR
- Agent has perfect recall of every code path it just wrote — ideal moment to write the guide
- CI checks structurally (doc exists, builds, renders)
- Agent reviewer checks accuracy (doc matches code)
- Human reviews judgment calls (is this the right explanation for users)

### 3. Conceptual docs (architecture overviews, "why" explanations)
- Human-written or human-directed, agents assist
- Requires product/design judgment agents don't have

## Harness enforcement layers

| Layer | Catches | How |
|-------|---------|-----|
| Spec sync check | Generated docs out of date | `docs-check` diffs regenerated vs committed |
| Docs gate | Feature shipped without docs | CI checks handler changes have doc changes |
| Doc build | Broken links, bad markdown | `mkdocs build --strict` fails on warnings |
| Agent review | Inaccurate content | AI reads diff, flags code/doc mismatches |
| Coverage metric | Undocumented endpoints | Compare spec endpoints to documented ones |

## What an agent's feature PR looks like
```
feat/add-user-api
├── internal/handler/user.go          # implementation
├── internal/handler/user_test.go     # tests
├── docs/api/openapi.yaml             # spec updated
├── docs/user/api-reference.md        # regenerated
└── docs/user/managing-users.md       # new guide written by agent
```

One PR, one review. Docs ship with code.

## Cost tradeoff
- Agents cost ~20% more per PR with docs work
- But: docs ship with the feature instead of sitting in backlog with lost context
- Harness engineering team shipped 3.5 PRs/engineer/day including docs
- Docs aren't extra work — they're part of the definition of done that CI enforces

## What our repo still needs
1. Docs gate in CI — fail if handler changes lack doc changes
2. mkdocs strict build — catch broken docs at PR time
3. AGENTS.md rule — "every new user-facing feature requires a guide in docs/user/"
4. PR template — checklist including "docs updated"
