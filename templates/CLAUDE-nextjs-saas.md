# CLAUDE.md — Next.js AI SaaS

Drop this file into your project root. It tells Claude Code your stack and how to use the agent team.

---

## Project Overview

**Type**: AI SaaS product
**Stack**: Next.js 14 + FastAPI + PostgreSQL + Claude API
**Stage**: [MVP / Beta / Production]

---

## Tech Stack

```
Frontend:   Next.js 14 (App Router), TypeScript, Tailwind CSS, Vercel AI SDK
Backend:    FastAPI, SQLAlchemy, Alembic, PostgreSQL, Redis
AI layer:   Anthropic Claude API, pgvector for embeddings
Auth:       Clerk / NextAuth / Supabase Auth
Deploy:     Vercel (frontend), Railway / Fly.io (backend), Supabase (db)
```

---

## Agent Routing

### Planning
- New features → `ai-product-manager` (PRD first, then build)
- Architecture decisions → `ai-architect`
- UX flows → `ai-ux-designer`

### Engineering
- LLM features, RAG, embeddings → `ai-engineer`
- Next.js pages, components, streaming UI → `ai-frontend-engineer`
- FastAPI endpoints, background jobs → `ai-backend-engineer`
- Full feature end-to-end → `ai-fullstack-engineer`
- DB schema, pgvector, migrations → `ai-database-engineer`
- API contracts, OpenAPI spec → `ai-api-designer`
- CI/CD, Vercel config, Docker → `ai-devops-engineer`
- LLM eval, prompt testing → `ai-qa-engineer`

### Quality & Safety
- Prompt review, optimization → `ai-prompt-engineer`
- Security review → `ai-security-engineer`
- AI bias / safety → `ai-responsible-engineer`
- GDPR, ToS, privacy policy → `ai-legal-engineer`

### Launch
- Cost analysis → `ai-finance-engineer`
- Docs, API reference → `ai-docs-engineer`
- Analytics setup → `ai-analytics-engineer`

### Everything else
- `/founder "describe task"` — routes to the right agent automatically

---

## Coding Conventions

```
- TypeScript strict mode — no `any`
- All API routes in /app/api/, typed with Zod schemas
- All LLM calls through /lib/llm.ts — never call Anthropic SDK directly
- All prompts in /prompts/*.ts — versioned, never inline
- Server components by default — client components only when needed
- Error boundaries on all AI-powered components
- All DB queries through SQLAlchemy ORM — no raw SQL except in migrations
```

## AI-Specific Conventions
```
- System prompts versioned in /prompts/ with semantic version comments
- All LLM responses validated with Zod before use
- Streaming via Vercel AI SDK useChat / useCompletion hooks
- Token budgets defined per feature in /lib/llm.ts
- Evals in /evals/ — run before any prompt change
- Log all LLM inputs/outputs to Langsmith in production
```

## Directory Structure
```
app/
  (auth)/          ← auth pages
  (dashboard)/     ← protected app pages
  api/             ← API routes
components/
  ui/              ← shadcn/ui components
  ai/              ← AI-specific components (chat, streaming, etc.)
lib/
  llm.ts           ← Anthropic SDK wrapper — all AI calls go here
  db.ts            ← Database client
  auth.ts          ← Auth utilities
prompts/           ← All LLM prompts, versioned
evals/             ← LLM evaluation suite
backend/
  app/
    api/           ← FastAPI routers
    services/      ← Business logic
    models/        ← SQLAlchemy models
  alembic/         ← DB migrations
```

## Common Tasks

```bash
# Start dev
npm run dev              # Next.js on :3000
uvicorn app.main:app --reload  # FastAPI on :8000

# Database
alembic upgrade head     # Run migrations
alembic revision --autogenerate -m "description"  # New migration

# Tests
npm test                 # Frontend tests
pytest                   # Backend tests
python -m evals.run      # LLM evals

# Deploy
git push origin main     # Auto-deploys frontend to Vercel
railway up               # Deploy backend
```
