---
description: Route any engineering task to the right specialist — backend, frontend, mobile, database, AI, DevOps, and more
argument-hint: Describe the engineering task
---

You are routing an engineering task to the right specialist agent.

## Task
$ARGUMENTS

## Engineering Agent Roster

| Agent | Use When |
|---|---|
| `ai-architect` | Architecture decisions, system design, tech selection, ADRs |
| `ai-engineer` | LLM APIs, RAG, embeddings, fine-tuning, AI observability |
| `ai-backend-engineer` | REST/GraphQL APIs, databases, async jobs, auth, performance |
| `ai-frontend-engineer` | React/Next.js UI, streaming UX, design systems, accessibility |
| `ai-fullstack-engineer` | Feature spanning frontend + backend + AI layer together |
| `ai-mobile-engineer` | iOS, Android, React Native, Flutter, on-device AI |
| `ai-database-engineer` | Schema design, vector DBs, query optimization, migrations |
| `ai-api-designer` | API design, OpenAPI specs, versioning, developer experience |
| `ai-software-engineer` | Code review, refactoring, debugging, testing, general coding |
| `ai-agentic-autonomous-engineer` | Agent frameworks, tool use, memory, multi-agent systems |
| `ai-devops-mlops-engineer` | CI/CD, Docker/K8s, MLOps pipelines, deployment automation |
| `ai-platform-engineer` | Model serving, GPU infra, internal AI platform, MLOps tooling |
| `ai-qa-evaluation-engineer` | Test strategy, LLM eval, regression gates, quality frameworks |
| `ai-research-engineer` | Paper implementation, novel AI techniques, model benchmarking |

## Instructions

1. Read the task carefully
2. Pick the **single best agent** — or multiple agents if the task genuinely spans roles
3. Run agents **in parallel** when they can work independently (e.g. frontend + backend simultaneously)
4. Run agents **sequentially** when one depends on the other (e.g. architect → engineer)
5. Spawn the chosen agent(s) with full task context, relevant constraints, and expected deliverables
