---
name: engineering
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
| `ai-engineer` | LLM APIs, RAG, embeddings, AI observability |
| `ai-backend-engineer` | REST/GraphQL APIs, databases, async jobs, auth, performance |
| `ai-frontend-engineer` | React/Next.js UI, streaming UX, design systems, accessibility |
| `ai-fullstack-engineer` | Feature spanning frontend + backend + AI layer together |
| `ai-mobile-engineer` | iOS, Android, React Native, Flutter, on-device AI |
| `ai-database-engineer` | Schema design, vector DBs, query optimization, migrations |
| `ai-api-designer` | API design, OpenAPI specs, versioning, developer experience |
| `ai-software-engineer` | Code review, refactoring, debugging, testing, general coding |
| `ai-agent-engineer` | Agent frameworks, tool use, memory, multi-agent systems |
| `ai-devops-engineer` | CI/CD, Docker/K8s, MLOps pipelines, deployment automation |
| `ai-platform-engineer` | Model serving, GPU infra, internal AI platform, MLOps tooling |
| `ai-qa-engineer` | Test strategy, LLM eval, regression gates, quality frameworks |
| `ai-research-engineer` | Paper implementation, novel AI techniques, model benchmarking |
| `ai-voice-engineer` | Real-time voice agents, phone bots, STT/TTS, latency and turn-taking |
| `ai-vision-engineer` | Detection, segmentation, document AI, VLMs, edge vision |
| `ai-generative-media-engineer` | Image/video/audio generation, style fine-tuning, GPU serving, content safety |
| `ai-robotics-engineer` | ROS 2, simulation and sim-to-real, imitation learning, robot safety |
| `ai-model-training-engineer` | Fine-tuning, post-training, distillation, pretraining, GPU compute plans |
| `ai-performance-engineer` | Latency, throughput, query tuning, load testing |

## Instructions

1. Read the task carefully
2. Pick the **single best agent** — or multiple agents if the task genuinely spans roles
3. Run agents **in parallel** when they can work independently (e.g. frontend + backend simultaneously)
4. Run agents **sequentially** when one depends on the other (e.g. architect → engineer)
5. Spawn the chosen agent(s) with full task context, relevant constraints, and expected deliverables
