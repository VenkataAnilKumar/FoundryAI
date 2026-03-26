# CLAUDE.md — AI Project Configuration

This file tells Claude Code about this project and which agents to use for different tasks.
Place this file in your project root so all team members benefit from consistent agent routing.

---

## Project Overview

**Project name**: [Your project name]
**Type**: [e.g. AI SaaS product / internal AI tool / ML platform]
**Stack**: [e.g. Next.js + FastAPI + PostgreSQL + Claude API]
**Stage**: [e.g. MVP / Beta / Production]

---

## Agent Routing Guide

When delegating tasks in this project, prefer these agents:

### Planning & Design
- **New features or requirements** → `ai-product-manager`
- **Architecture decisions** → `ai-architect`
- **UX flows or wireframes** → `ai-ux-designer`

### Engineering
- **LLM integration, RAG, embeddings** → `ai-engineer`
- **Frontend components, streaming UI** → `ai-frontend-engineer`
- **API endpoints, DB, background jobs** → `ai-backend-engineer`
- **Full feature (front + back)** → `ai-fullstack-engineer`
- **iOS/Android/React Native/Flutter** → `ai-mobile-engineer`
- **Database schema, vector search, migrations** → `ai-database-engineer`
- **API design, OpenAPI specs, DX** → `ai-api-designer`
- **Agent/autonomous workflow** → `ai-agentic-autonomous-engineer`
- **CI/CD, deployment, infra** → `ai-devops-mlops-engineer`
- **Testing and evaluation** → `ai-qa-evaluation-engineer`

### Data & AI
- **Data pipelines, ETL** → `data-engineer`
- **Model evaluation, benchmarking** → `ai-qa-evaluation-engineer`
- **Prompt optimization** → `prompt-engineer`
- **Analytics, dashboards** → `analytics-insights-agent`

### Safety & Compliance
- **Bias or fairness review** → `responsible-ai-engineer`
- **Security threat review** → `ai-security-risk`
- **Legal / regulatory review** → `legal-compliance-agent`

### Business
- **Cost analysis** → `ai-finance-cost-optimization`
- **Technical documentation, API docs** → `ai-documentation-knowledge-engineer`
- **User guides, tutorials, SOPs** → `technical-writer`

### Multi-agent tasks
- **Any task needing strategic judgment + execution** → `founder` (thinks like a co-founder, delegates to the right team)
- **Complex multi-step projects** → `multi-agent-orchestrator` (pure coordination layer)

---

## Project-Specific Context

### Tech stack details
```
Frontend:   [e.g. Next.js 14, TypeScript, Tailwind, Vercel AI SDK]
Backend:    [e.g. FastAPI, SQLAlchemy, PostgreSQL, Redis]
AI layer:   [e.g. Anthropic Claude claude-sonnet-4-6, RAG with pgvector]
Deploy:     [e.g. Vercel (frontend), Railway (backend), Supabase (db)]
```

### Coding conventions
- [e.g. All functions typed with TypeScript — no `any`]
- [e.g. API routes follow REST conventions — nouns, not verbs]
- [e.g. Tests required for all business logic before PR merge]
- [e.g. Use Zod for all schema validation]

### AI-specific conventions
- [e.g. All prompts versioned in `/prompts/` directory]
- [e.g. LLM calls go through `/lib/llm.ts` wrapper — never call API directly]
- [e.g. Log all LLM inputs and outputs to Langsmith]
- [e.g. Max context window: 100k tokens. Summarize above that.]

### Known constraints
- [e.g. GDPR compliant — no PII in LLM prompts without explicit consent]
- [e.g. Rate limit: 100 req/min per user for AI endpoints]
- [e.g. Target latency: <2s for streaming first token]

---

## Agent Team Configurations

### Feature development team
```
Lead:   ai-product-manager (define requirements)
→       ai-architect (design approach)
→       ai-frontend-engineer + ai-backend-engineer (build in parallel)
→       ai-qa-evaluation-engineer (test and validate)
```

### AI quality review team
```
Lead:   ai-qa-evaluation-engineer
→       prompt-engineer (optimize prompts)
→       responsible-ai-engineer (fairness/safety check)
→       ai-security-risk (adversarial testing)
```

### Launch readiness team
```
Lead:   multi-agent-orchestrator
→       legal-compliance-agent (compliance review)
→       ai-documentation-knowledge-engineer (docs)
→       ai-devops-mlops-engineer (deployment checklist)
→       analytics-insights-agent (metrics setup)
```

---

## Frequently Delegated Tasks

```bash
# "Review this PR for AI-specific issues"
→ ai-qa-evaluation-engineer + ai-security-risk + responsible-ai-engineer

# "Optimize our LLM costs — we're at $15k/month"
→ ai-finance-cost-optimization + prompt-engineer

# "We need to be EU AI Act compliant before launch"
→ legal-compliance-agent + responsible-ai-engineer

# "Build the chat interface with streaming"
→ ai-frontend-engineer + ai-backend-engineer

# "Set up evaluation pipeline for our RAG system"
→ ai-qa-evaluation-engineer + ai-engineer + data-scientist
```
