# Skills Reference — 20 Slash Commands

Skills are slash commands that inject focused prompts directly into your Claude Code session. Faster than invoking an agent — no subprocess, instant output.

Install all skills by copying the `skills/` folder:

```bash
cp claude-agents/skills/*.md ~/.claude/commands/
```

---

## Code Quality

### `/review`
Full code review with severity ratings.
```
/review                          ← reviews current file in context
/review src/api/auth.ts          ← reviews specific file
```
Output: Issues rated CRITICAL / HIGH / MEDIUM / LOW with suggested fixes.

### `/review-ai`
AI-specific review — prompt injection, hallucination risks, PII leakage, token waste, eval gaps.
```
/review-ai                       ← reviews LLM code in context
/review-ai "check this system prompt for injection risks"
```
Output: AI risk report + token cost estimate + missing evals list.

### `/debug "symptom"`
Structured 6-step debugging: symptom → evidence → hypotheses → isolate → fix → verify.
```
/debug "TypeError: Cannot read properties of undefined (reading 'map')"
/debug "API returns 200 but response body is empty"
```

### `/test-plan "what to test"`
Complete test plan: unit, integration, E2E, edge cases, coverage targets.
```
/test-plan "user authentication with JWT refresh tokens"
/test-plan "the file upload and processing pipeline"
```

### `/explain`
Explains any code in plain language — what it does, why it exists, concrete example walkthrough.
```
/explain                         ← explains current file
/explain "what does this regex do: ^(?=.*[A-Z])(?=.*\d).{8,}$"
```

---

## Feature Development

### `/feature "name"`
Kick off a feature — classifies it, routes to the right specialist agents in parallel.
```
/feature "add JWT authentication to the API"
/feature "build a streaming chat interface with message history"
```
Output: Work breakdown, agent assignments, implementation order.

### `/prd "idea"`
Lean PRD: problem statement, user stories, acceptance criteria, success metrics, non-goals.
```
/prd "AI-powered code review that learns your team's style"
/prd "onboarding flow for new users"
```

### `/spec "component"`
Technical specification: interface design, behavior, error cases, data model, non-functional requirements.
```
/spec "rate limiter middleware"
/spec "the user session management service"
```

### `/estimate "task"`
T-shirt sizing with breakdown, risk multipliers, and unknowns that must be resolved.
```
/estimate "add full-text search to the product catalog"
/estimate "migrate from REST to GraphQL"
```
Output: S/M/L/XL size, day range, risk factors, open questions.

---

## AI / LLM Specific

### `/prompt "text"`
Full prompt optimization: diagnosis, rewritten version, diff of every change, edge case test inputs.
```
/prompt "You are a helpful assistant. Answer the user's question."
/prompt "Summarize the following document in 3 bullet points: {document}"
```
Output: Diagnosis + optimized prompt + what changed and why + token count comparison.

### `/eval "feature"`
Design a complete eval suite: 15+ test cases, scoring method, pass thresholds, regression strategy.
```
/eval "a chatbot that answers questions about our product docs"
/eval "the AI code review feature"
```

### `/rag-design`
RAG architecture decisions: chunking strategy, embedding model selection, vector DB recommendation, retrieval approach.
```
/rag-design "document Q&A over 50k PDFs, English only, <500ms latency"
/rag-design "code search across a large monorepo"
```
Output: Complete architecture recommendation with rationale for every component.

### `/cost-check`
Token cost estimate at different volumes + ranked optimization recommendations.
```
/cost-check "system prompt is 2000 tokens, expect 50k requests/day"
/cost-check                      ← analyzes current prompt in context
```
Output: Monthly cost table at 3 volumes + priority-ranked savings opportunities.

### `/agent-design "role"`
Design a new Claude Code agent — outputs a complete ready-to-use `.md` file.
```
/agent-design "a financial modeling specialist for startup fundraising"
/agent-design "a Kubernetes and infrastructure specialist"
```
Output: Complete agent file ready to drop into `~/.claude/agents/`.

---

## Docs & Communication

### `/docs`
Write documentation: docstrings, API endpoint docs, module docs, architecture docs.
```
/docs                            ← documents current file/function
/docs "the /api/chat endpoint"
```
Output: Language-appropriate docstrings + usage examples + edge case notes.

### `/changelog "version"`
Generate a CHANGELOG entry from recent git commits.
```
/changelog 1.2.0
/changelog                       ← auto-detects version from git tags
```
Output: Keep a Changelog formatted entry + one-sentence release summary.

### `/release "version"`
Full release notes: highlights, breaking changes, migration guide, upgrade steps.
```
/release "2.0.0 — new routing system"
/release 1.5.0
```

### `/standup`
Generate a standup update from recent git activity.
```
/standup
/standup "blocked on the auth API, team standup format"
```
Output: Yesterday / Today / Blockers in short or detailed format.

---

## Launch & Ops

### `/launch-check`
40-point pre-launch checklist: security, reliability, observability, deployment, docs, compliance, communication.
```
/launch-check "shipping the payments feature to production"
/launch-check "open-sourcing the claude-agents plugin"
```
Output: Checklist with ✅ / ⚠️ / ❌ status + GO / NO-GO / CONDITIONAL GO decision.

### `/incident "what broke"`
Structured incident response: severity triage, containment, 5-Whys root cause, postmortem template.
```
/incident "500 errors spiking on /api/chat since the last deploy"
/incident "database CPU at 100%, queries timing out"
```
Output: Severity classification, containment action, RCA structure, filled postmortem template.

---

## Routing Commands (from the plugin)

These come with the `founders-kit` plugin and route tasks to specialist agents:

| Command | Use When |
|---|---|
| `/founder "task"` | Any task — universal router across all 34 agents |
| `/engineering "task"` | Engineering tasks |
| `/product "task"` | Product, design, strategy tasks |
| `/business "task"` | Business, ops, compliance, data tasks |
