# Paper: Evaluating AGENTS.md (arxiv 2602.11988v1)

Authors: Gloaguen, Mündler, Müller, Raychev, Vechev (ETH Zurich / DeepCode AI)

## What they tested
- AGENTbench: 138 tasks from 12 Python repos
- 4 agents: Claude Code/Sonnet 4.5, Codex/GPT-5.2, Codex/GPT-5.1-mini, Qwen Code
- 3 conditions: no context file, LLM-generated, developer-written

## Key findings
- LLM-generated context files **decrease** success: -2% (AGENTbench), -0.5% (SWE-bench)
- Developer-written context files: +4% avg, but only 3 of 4 agents improved
- Any context file increases inference cost ~20-23%
- LLM-generated files add +14-22% reasoning tokens
- Agents follow tool instructions near-perfectly (mentioning `uv` → usage jumps from <0.01 to 1.6/instance)
- Context files do NOT help agents find relevant files faster
- Context files help only in niche repos with minimal existing docs
- 100% of LLM-generated files included codebase overviews (unhelpful)

## Recommendations
1. Include only essential tooling/build instructions in context files
2. Avoid auto-generating context files — they hurt performance
3. Don't duplicate existing README/docs content
4. Codebase overviews don't help — agents discover code on their own

## Impact on our repo
- AGENTS.md kept minimal (~50 lines), no codebase overviews
- Only concrete tool commands and hard rules in context files
- All context files human-written, not auto-generated
- Enforcement via CI (coverage gates, docs-check) rather than prose guidance
- docs/ is separate from agent instructions to avoid redundancy
- Watch: don't let AGENTS.md grow; audit context files if agent costs spike
