# AGENTS.md — AI Agent Product

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

---

## Project Overview

**Type**: AI agent product (agents that take actions with tools on the user's behalf)
**Stage**: [Idea / MVP / Early customers / PMF / Scale]
**AI startup type**: agent product
**Team size**: [e.g. 2 founders, 1 engineer]
**What the agent does**: [e.g. resolves tier-1 support tickets end to end in Zendesk]

---

## Tech Stack

```
Agent runtime:  [e.g. provider agent SDK / LangGraph / custom loop] — keep the loop thin and testable
Models:         [frontier model for planning, smaller model for routine steps]
Tools:          [internal APIs, MCP servers, browser/computer use, code execution]
State:          PostgreSQL (runs, steps, approvals) + object storage (artifacts)
Queue:          [e.g. Redis/BullMQ, Temporal, cloud queue] for long-running runs
Observability:  tracing of every step, tool call and token count (e.g. Langfuse, LangSmith, OpenTelemetry)
```

---

## Agent Routing

- Agent loop, tools, memory, planning → `ai-agent-engineer`
- Overall system design, model choices → `ai-architect` (+ `/model-strategy`)
- Tool APIs and MCP servers → `ai-backend-engineer`, `ai-api-designer`
- Run dashboard, approvals UI, live progress → `ai-frontend-engineer`
- Eval harness, regression suites → `ai-qa-engineer`
- Prompt and tool-description tuning → `ai-prompt-engineer`
- Prompt injection, permissions, sandboxing → `ai-security-engineer`
- Cost per run, margin → `ai-finance-engineer`
- Everything else → `/cofounder "describe task"`

---

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | One narrow workflow, human approval on every action, log full traces | Multi-agent architectures, autonomy without review |
| Early customers | Eval set from real runs, approval only on risky actions, cost per run tracking | Adding tools faster than you add evals |
| PMF / Scale | Durable execution, per-customer permissions, SLAs, fallback models | Hard-coding one model provider |

## Key Metrics

- Task success rate (end-to-end, judged on real tasks)
- Human intervention rate and reasons
- Cost and latency per run (median and p95)
- Steps per run and tool error rate
- Unsafe or unauthorized action attempts (target: zero executed)

---

## Conventions

```
- Every tool has a typed schema, a clear description, and an explicit permission level (read / write / irreversible)
- Irreversible or external actions (payments, emails, deletes) require approval or a policy check
- Treat all tool outputs and retrieved content as untrusted input (prompt injection)
- Every run is resumable and idempotent; no side effect is repeated on retry
- Max steps, max tokens and max wall-clock time per run
- Evals in /evals/ run on every prompt, tool or model change
- Full trace per run: plan, tool calls, inputs/outputs (PII-redacted), cost
```

## Directory Structure

```
agent/
  loop.py            ← the agent loop (small, tested)
  tools/             ← one module per tool: schema, permission, implementation
  prompts/           ← versioned system and tool prompts
  policies/          ← approval and permission rules
evals/
  tasks/             ← real task fixtures with expected outcomes
  run_evals.py
api/                 ← runs, approvals, webhooks
web/                 ← run viewer and approvals UI
```

## Useful Skills

`/agent-systems` · `/eval` · `/security-scan` · `/cost-check` · `/model-strategy` · `/review-ai` · `/pmf-check`
