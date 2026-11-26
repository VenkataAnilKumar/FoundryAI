# FoundryAI — The AI Startup Team for Any AI Workspace

> 58 specialist agents + 9 team coordinators + 54 skills for **every kind of AI startup**, from LLM apps and agents to voice, vision, generative media, robotics, model training and vertical AI.
> Works in **Claude Code, Cursor, GitHub Copilot, Codex and Gemini CLI**, in any `AGENTS.md`/Agent Skills–compatible agent, and in chat workspaces like ChatGPT, Claude and Gemini projects.

[![validate](https://github.com/VenkataAnilKumar/FoundryAI/actions/workflows/validate.yml/badge.svg)](https://github.com/VenkataAnilKumar/FoundryAI/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Agents](https://img.shields.io/badge/agents-58-green)](#the-team--58-specialists)
[![Skills](https://img.shields.io/badge/skills-54-orange)](#skills--54-skills)
[![Workspaces](https://img.shields.io/badge/workspaces-Claude%20%C2%B7%20Cursor%20%C2%B7%20Copilot%20%C2%B7%20Codex%20%C2%B7%20Gemini-blue)](#works-in-any-ai-workspace)

![FoundryAI Demo](demo.svg)

An AI startup needs architects, engineers, product people, growth, security, legal and fundraising help long before it can hire them. FoundryAI gives you that team as specialist agents and reusable skills, inside the AI workspace you already use.

---

## Quick Start

**1. Install** — the installer detects your AI workspaces and installs into each one (needs `python3` and `git`):

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

**2. Tell it about your startup** — copy a [project template](#project-templates) into your repo as `AGENTS.md` and fill in your AI startup type and stage.

**3. Ask for help:**

| In… | Try |
|---|---|
| Claude Code, Copilot, Gemini CLI, Cursor | `/cofounder "plan the MVP for our AI support agent"` |
| Any agent | *"Use the ai-architect agent to design our RAG pipeline"* |
| Codex | *"Use the founder agent to plan our seed raise"* |
| ChatGPT / Claude / Gemini projects | `./install.sh --target chat`, then paste `~/FoundryAI-chat-prompts/agents/founder.md` into the project instructions |

Not sure where to start? `/cofounder` figures out the right specialists for you.

---

## Why FoundryAI

- **Built for every AI startup** — specialists for LLM apps, agents, devtools, voice, vision, generative media, robotics and model training, plus regulated verticals (health, finance, legal).
- **Advice that fits your stage** — every agent first works out your startup type and stage, then recommends the simplest thing that works now (no Kubernetes before product-market fit) and says what would justify the next step.
- **Engineering *and* business** — architecture, code, evals and security alongside fundraising, pricing, enterprise sales and product-market fit.
- **Any AI workspace** — one source, built into each workspace's native format. Switch tools without losing your team.
- **Consistent, checkable output** — every agent has a defined output format and says when to use a different specialist instead.

---

## How It Works

```
agents/*.md          neutral agents (tier + capabilities)  ─┐
skills/*/SKILL.md    Agent Skills standard                  ├─▶  scripts/build.py
agents/_shared/      stage-aware operating principles       ─┘          │
                                                                        ▼
        Claude Code · Cursor · Copilot · Codex · Gemini CLI · chat prompts
```

- **Agents** declare a *tier* (`deep` / `standard` / `fast`) and *capabilities* (`read`, `edit`, `shell`, `web`, `delegate`); the build maps them to each workspace's models and tools.
- **Coordinators** (`founder`, `team-*`) run other agents as subagents where the workspace supports it, and otherwise tell you which specialist to use next.
- **Skills** are reusable workflows (`/prd`, `/eval`, `/pitch-deck`…) any agent — or you — can invoke.

---

## Works in Any AI Workspace

| Workspace | `--target` | Agents | Skills |
|---|---|---|---|
| **Claude Code** | `claude` | `~/.claude/agents/` | `~/.claude/skills/` |
| **Cursor** | `cursor` | `~/.cursor/agents/` | `~/.agents/skills/` |
| **GitHub Copilot / VS Code** | `copilot` | `~/.copilot/agents/*.agent.md` | `~/.copilot/skills/` |
| **OpenAI Codex CLI** | `codex` | `~/.codex/agents/*.toml` | `~/.agents/skills/` |
| **Gemini CLI** | `gemini` | `~/.gemini/agents/` | `~/.agents/skills/` |
| **Other agents** (Windsurf, Cline, Roo, Zed, Amp, Junie, …) | `cursor` or `codex` | — | `~/.agents/skills/` ([Agent Skills](https://agentskills.io)) |
| **Chat workspaces** (ChatGPT, Claude, Gemini projects) | `chat` | `~/FoundryAI-chat-prompts/` | same folder |

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash -s -- --target cursor --target codex
./install.sh --dry-run        # from a clone: preview changes
./install.sh --target all     # every workspace, including chat prompts
```

The installer backs up any file it would overwrite and records what it installed. Remove everything with:

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash
```

**Claude Code plugin:** `/plugin marketplace add VenkataAnilKumar/FoundryAI` then `/plugin install founders-kit@foundryai` (use the plugin *or* `install.sh --target claude`, not both). See [INSTALL.md](INSTALL.md) for every option.

---

## The Team — 58 Specialists

| Group | Specialists |
|---|---|
| Leadership | founder, cto-advisor, engineering-manager, technical-program-manager, ai-orchestrator, ai-fundraising-advisor |
| Architecture | ai-architect, cloud-architect, data-architect, integration-architect, security-architect, software-architect, staff-engineer |
| Engineering | ai-engineer, ai-backend-engineer, ai-frontend-engineer, ai-fullstack-engineer, ai-mobile-engineer, ai-database-engineer, ai-api-designer, ai-software-engineer, ai-agent-engineer, ai-devops-engineer, ai-qa-engineer, ai-performance-engineer |
| AI Modalities | ai-voice-engineer, ai-vision-engineer, ai-generative-media-engineer, ai-robotics-engineer |
| Data & AI | ai-data-engineer, ai-data-scientist, ai-analytics-engineer, ai-domain-expert, ai-prompt-engineer, ai-research-engineer, ai-model-training-engineer |
| Platform | ai-platform-engineer, ml-engineer, site-reliability-engineer, release-manager |
| Product | ai-product-manager, ai-ux-designer, ux-researcher, product-designer, product-marketing-manager, product-analyst, technical-product-manager, ai-strategy-engineer |
| Growth | ai-finance-engineer, ai-sales-engineer, ai-growth-engineer, developer-advocate |
| Knowledge | ai-technical-writer, ai-accessibility-engineer, content-designer |
| Safety | ai-security-engineer, ai-responsible-engineer, ai-legal-engineer |

Plus **9 team coordinators** (`team-leadership`, `team-architecture`, `team-engineering`, `team-platform`, `team-product`, `team-data-ai`, `team-growth`, `team-knowledge`, `team-safety`) that run a whole team on one problem.

Expand a group for what each specialist is best at, or see the full reference in [`docs/agents.md`](docs/agents.md).

<details>
<summary><b>Leadership (6)</b></summary>

### Leadership (6)
| Agent | Best For |
|---|---|
| `founder` | Your AI co-founder — thinks strategically, delegates to the right team, ships |
| `cto-advisor` | Build-vs-buy decisions, hiring plans, tech debt strategy, scaling engineering teams |
| `engineering-manager` | Team health, delivery cadence, performance reviews, hiring |
| `technical-program-manager` | Cross-team coordination, OKRs, program tracking |
| `ai-orchestrator` | Complex multi-agent workflow coordination |
| `ai-fundraising-advisor` | Raise strategy, pitch deck, AI investor metrics, data room, term sheets, investor updates |

</details>

<details>
<summary><b>Architecture (7)</b></summary>

### Architecture (7)
| Agent | Best For |
|---|---|
| `ai-architect` | AI system design, LLM/RAG architecture, tech stack decisions |
| `cloud-architect` | AWS/GCP/Azure infrastructure, multi-cloud, IaC |
| `data-architect` | Data lakehouse, warehouse, modeling, lineage |
| `integration-architect` | API gateways, event mesh, microservices integration |
| `security-architect` | Threat modeling, zero-trust, security frameworks |
| `software-architect` | Application architecture, DDD, ADRs, hexagonal design |
| `staff-engineer` | Cross-team technical leadership, engineering standards |

</details>

<details>
<summary><b>Engineering (12)</b></summary>

### Engineering (12)
| Agent | Best For |
|---|---|
| `ai-engineer` | LLM integration, RAG pipelines, embeddings, any model provider |
| `ai-backend-engineer` | APIs, databases, async processing, microservices |
| `ai-frontend-engineer` | React/Next.js, streaming UI, AI chat interfaces |
| `ai-fullstack-engineer` | End-to-end features across the full stack |
| `ai-mobile-engineer` | React Native, Flutter, iOS/Android, on-device AI |
| `ai-database-engineer` | PostgreSQL, vector DBs, migrations, query optimization |
| `ai-api-designer` | REST/GraphQL/gRPC design, OpenAPI specs, DX |
| `ai-software-engineer` | General coding across any language/framework |
| `ai-agent-engineer` | Multi-agent systems, tool use, autonomous workflows |
| `ai-devops-engineer` | CI/CD, Docker/K8s, model deployment, MLOps |
| `ai-qa-engineer` | LLM evals, test frameworks, adversarial testing |
| `ai-performance-engineer` | Latency, throughput, Core Web Vitals, load testing, query tuning |

</details>

<details>
<summary><b>Platform (4)</b></summary>

### Platform (4)
| Agent | Best For |
|---|---|
| `ai-platform-engineer` | Internal AI platform, model serving, GPU infra |
| `ml-engineer` | Classic ML: training pipelines, feature stores, serving, drift monitoring |
| `site-reliability-engineer` | SLOs, incident response, reliability engineering |
| `release-manager` | Release coordination, rollout strategy, feature flags |

</details>

<details>
<summary><b>Product (8)</b></summary>

### Product (8)
| Agent | Best For |
|---|---|
| `ai-product-manager` | PRDs, roadmaps, user stories, OKRs, GTM planning |
| `ai-ux-designer` | User flows, wireframes, AI UX patterns, onboarding design |
| `ux-researcher` | User interviews, usability testing, JTBD, personas |
| `product-designer` | Hi-fi designs, design systems, Figma handoff |
| `product-marketing-manager` | Positioning, launch plans, competitive intel, battlecards |
| `product-analyst` | Funnel analysis, cohort retention, A/B testing |
| `technical-product-manager` | Developer-facing products, APIs/SDKs, DX metrics |
| `ai-strategy-engineer` | AI strategy docs, competitive analysis, 3-year roadmaps |

</details>

<details>
<summary><b>Data & AI (7)</b></summary>

### Data & AI (7)
| Agent | Best For |
|---|---|
| `ai-data-engineer` | ETL pipelines, data warehouse, stream processing |
| `ai-data-scientist` | Statistical analysis, ML modeling, A/B testing |
| `ai-analytics-engineer` | KPI dashboards, funnel analysis, BI reporting |
| `ai-domain-expert` | Deep domain knowledge and expert validation |
| `ai-prompt-engineer` | Prompt design, optimization, evaluation, few-shot examples |
| `ai-research-engineer` | Paper implementation, experiments, new techniques |
| `ai-model-training-engineer` | Fine-tuning, post-training (DPO/RL), distillation, pretraining, GPU compute plans |

</details>

<details>
<summary><b>AI Modalities (4)</b></summary>

### AI Modalities (4)
| Agent | Best For |
|---|---|
| `ai-voice-engineer` | Real-time voice agents, phone bots, STT/TTS, latency and turn-taking |
| `ai-vision-engineer` | Detection, segmentation, document AI, vision-language models, edge vision |
| `ai-generative-media-engineer` | Image, video and audio generation, style fine-tuning, GPU serving, content safety |
| `ai-robotics-engineer` | ROS 2, simulation and sim-to-real, imitation learning, VLA policies, robot safety |

</details>

<details>
<summary><b>Growth (4)</b></summary>

### Growth (4)
| Agent | Best For |
|---|---|
| `ai-finance-engineer` | Runway and burn, financial models, AI gross margin, GPU/LLM spend, credits |
| `ai-sales-engineer` | Founder-led and enterprise AI sales, pilots that convert, security reviews, retention |
| `ai-growth-engineer` | Content strategy, SEO, AI-powered growth experiments |
| `developer-advocate` | DevRel, DX, community, technical content |

</details>

<details>
<summary><b>Knowledge (3)</b></summary>

### Knowledge (3)
| Agent | Best For |
|---|---|
| `ai-technical-writer` | API docs, architecture docs, knowledge bases |
| `ai-accessibility-engineer` | WCAG 2.2, screen readers, keyboard nav, ARIA patterns |
| `content-designer` | UX writing, microcopy, content strategy |

</details>

<details>
<summary><b>Safety (3)</b></summary>

### Safety (3)
| Agent | Best For |
|---|---|
| `ai-security-engineer` | Threat modeling, prompt injection, red teaming |
| `ai-responsible-engineer` | Bias audits, fairness, safety, EU AI Act compliance |
| `ai-legal-engineer` | GDPR, IP, contracts, regulatory analysis |

</details>

<details>
<summary><b>Team Coordinators (9)</b></summary>

### Team Coordinators (9)
Use a team coordinator when you want the whole team to work together on a problem.

| Coordinator | Delegates To |
|---|---|
| `team-leadership` | founder, cto-advisor, engineering-manager, technical-program-manager, ai-orchestrator, ai-fundraising-advisor |
| `team-architecture` | ai-architect, cloud-architect, data-architect, integration-architect, security-architect, software-architect, staff-engineer |
| `team-engineering` | The engineering and AI modality specialists (voice, vision, generative media, robotics) |
| `team-platform` | ai-platform-engineer, ml-engineer, site-reliability-engineer, release-manager, ai-performance-engineer |
| `team-product` | All 8 product specialists |
| `team-data-ai` | All 7 data & AI specialists |
| `team-growth` | ai-finance-engineer, ai-sales-engineer, ai-growth-engineer, developer-advocate |
| `team-knowledge` | ai-technical-writer, ai-accessibility-engineer, content-designer |
| `team-safety` | ai-security-engineer, ai-responsible-engineer, ai-legal-engineer |

</details>

---

## Routing

Not sure who to ask? The routing skills pick the specialists for you, based on the task and your startup's type and stage:

```
/cofounder "we're a voice AI startup at MVP — our calls feel slow"
→ ai-voice-engineer (latency budget) + ai-finance-engineer (cost per minute)

/cofounder "we want to raise our seed round next quarter"
→ ai-fundraising-advisor + ai-finance-engineer   (/pitch-deck, /pmf-check, /moat)

/cofounder "should we fine-tune our own model?"
→ ai-model-training-engineer + ai-finance-engineer   (/model-strategy)

/cofounder "a bank sent us a security questionnaire"
→ ai-sales-engineer + ai-security-engineer   (/security-questionnaire)

/engineering "design the database schema for conversation history"   → ai-database-engineer
/product "write a PRD for AI-powered search"                          → ai-product-manager
/business "we need to be GDPR compliant before launch"                → ai-legal-engineer + ai-responsible-engineer
```

The full routing guide — every specialist by task, plus routing by AI startup type — is in [`docs/routing.md`](docs/routing.md).

---

## Skills — 54 Skills

Skills follow the open [Agent Skills](https://agentskills.io) standard. Invoke them as `/name` where your workspace supports it, or just describe the task and the agent picks the skill.

| Group | Highlights |
|---|---|
| Routing | `/cofounder` · `/engineering` · `/product` · `/business` |
| AI Startup Business | `/pitch-deck` · `/investor-update` · `/pmf-check` · `/moat` · `/ai-pricing` · `/security-questionnaire` · `/data-rights` |
| AI / LLM | `/model-strategy` · `/rag-design` · `/eval` · `/prompt` · `/cost-check` · `/agent-systems` · `/responsible-ai` |
| Build | `/feature` · `/prd` · `/spec` · `/architect` · `/design` · `/estimate` |
| Code quality | `/review` · `/review-ai` · `/security-scan` · `/debug` · `/refactor` · `/test-plan` |
| Launch & ops | `/launch-check` · `/release-plan` · `/incident` · `/migrate` · `/compliance` |

Expand a group for every skill, or see [`docs/skills.md`](docs/skills.md).

<details>
<summary><b>Routing</b></summary>

### Routing
| Command | What it does |
|---|---|
| `/cofounder "task"` | Your AI co-founder — thinks strategically, routes to the right specialists |
| `/engineering "task"` | Routes an engineering task to the right engineer(s) |
| `/product "task"` | Routes a product, design or strategy task |
| `/business "task"` | Routes a business, data, ops or compliance task |

</details>

<details>
<summary><b>Code Quality</b></summary>

### Code Quality
| Command | What it does |
|---|---|
| `/review` | Code review: logic, security, performance — CRITICAL/HIGH/MEDIUM/LOW |
| `/review-ai` | AI-specific: prompt injection, hallucination risks, PII leakage, token cost |
| `/refactor` | Structured refactoring with safety checklist — no behavior changes |
| `/debug "error"` | 6-step debugging: symptom → evidence → hypotheses → fix → verify |
| `/security-scan` | Fast OWASP top 10 triage scan of any file |
| `/test-plan "feature"` | Complete test plan: unit, integration, E2E, edge cases |
| `/explain` | Plain-language explanation of any code with examples |

</details>

<details>
<summary><b>Feature Development</b></summary>

### Feature Development
| Command | What it does |
|---|---|
| `/feature "name"` | Classifies feature, routes to right agents in parallel |
| `/architect "challenge"` | Routes to the right architect specialist (AI, cloud, data, integration, security, app) |
| `/design "challenge"` | Routes to the right design/UX specialist (research, UX, visual, content, metrics) |
| `/prd "idea"` | Lean PRD: user stories, acceptance criteria, success metrics |
| `/spec "component"` | Technical spec: interface, behavior, error cases, data model |
| `/estimate "task"` | T-shirt sizing with breakdown, risk multipliers, unknowns |

</details>

<details>
<summary><b>AI / LLM Specific</b></summary>

### AI / LLM Specific
| Command | What it does |
|---|---|
| `/prompt "text"` | Optimize any prompt — diagnosis, rewrite, diff of changes |
| `/eval "feature"` | Design an eval suite — 15+ test cases, scoring, regression strategy |
| `/rag-design` | RAG architecture: chunking, embeddings, vector DB, retrieval |
| `/cost-check` | Token cost estimate at scale + ranked optimization recommendations |
| `/agent-design "role"` | Design a new agent — outputs a complete ready-to-use `.md` file |
| `/agent-systems "system"` | Design multi-agent orchestration, tool use, memory, failure handling |
| `/mlops` | ML training pipelines, fine-tuning, model serving, drift monitoring |
| `/responsible-ai` | Bias audit, fairness eval, red-team checklist, explainability |
| `/experiment "hypothesis"` | A/B test design, statistical analysis, ML model evaluation |
| `/model-strategy` | API vs open-weight vs fine-tune vs train — providers, cost, lock-in, switching triggers |

</details>

<details>
<summary><b>AI Startup Business</b></summary>

### AI Startup Business
| Command | What it does |
|---|---|
| `/pitch-deck` | Slide-by-slide AI pitch deck, answers to "isn't this a wrapper?", skeptical-investor teardown |
| `/investor-update` | Monthly investor update with metrics, AI cost and quality, and asks |
| `/pmf-check` | Product-market fit scorecard with AI-specific traps (novelty usage, pilot purgatory) |
| `/moat` | Defensibility assessment: data flywheel, workflow depth, distribution, switching costs |
| `/ai-pricing` | Seat vs usage vs credits vs outcome pricing, tiers, gross margin after inference |
| `/security-questionnaire` | Answer enterprise security and AI-governance reviews; close deal-blocking gaps |
| `/data-rights` | Rights to train on / use customer, scraped, licensed and synthetic data |

</details>

<details>
<summary><b>Product & Design</b></summary>

### Product & Design
| Command | What it does |
|---|---|
| `/metrics "product"` | Define north star, funnel, A/B test plan, dashboard design |
| `/gtm "launch"` | Go-to-market: positioning, messaging, launch plan, competitive battlecards |
| `/growth "product"` | Growth strategy: acquisition funnels, retention levers, viral loops |
| `/ai-strategy` | AI opportunity assessment, build-vs-buy, competitive landscape, roadmap |

</details>

<details>
<summary><b>Platform & Infrastructure</b></summary>

### Platform & Infrastructure
| Command | What it does |
|---|---|
| `/data-pipeline` | ETL/ELT design, streaming vs batch, data quality gates, lineage |
| `/performance` | Diagnose latency, Core Web Vitals, DB query tuning, load testing |
| `/mobile` | iOS/Android/RN/Flutter patterns, on-device AI, app store prep |
| `/release-plan` | Rollout strategy: canary, feature flags, phased launch, rollback |

</details>

<details>
<summary><b>Safety, Compliance & Accessibility</b></summary>

### Safety, Compliance & Accessibility
| Command | What it does |
|---|---|
| `/compliance` | GDPR/CCPA/EU AI Act, data privacy, AI risk register |
| `/accessibility` | WCAG 2.2 audit, screen readers, keyboard nav, ARIA patterns |

</details>

<details>
<summary><b>Docs & Community</b></summary>

### Docs & Community
| Command | What it does |
|---|---|
| `/docs` | Docstrings, API docs, architecture docs |
| `/changelog "v1.2.0"` | CHANGELOG entry from recent git commits |
| `/release "v2.0.0"` | Release notes: highlights, breaking changes, upgrade steps |
| `/standup` | Standup update from recent git activity |
| `/onboard` | 30-day engineer onboarding guide for your codebase |
| `/devrel` | DevRel strategy: DX audit, community, technical content, OSS |

</details>

<details>
<summary><b>Launch & Ops</b></summary>

### Launch & Ops
| Command | What it does |
|---|---|
| `/launch-check` | 40-point pre-launch checklist — security, ops, compliance, comms |
| `/incident "error"` | Incident response: severity triage, RCA, postmortem template |
| `/migrate` | Migration plan: zero-downtime strategy, rollback, data safety |
| `/api-test` | Full API test suite from endpoint description or OpenAPI spec |

</details>

---

## Project Templates

Copy one into your project root as `AGENTS.md`. It records your AI startup type, stage and stack, and tells every agent how to work in your project.

| Template | Stack |
|---|---|
| [`AGENTS.md`](templates/AGENTS.md) | Generic — works for any project |
| [`AGENTS-nextjs-saas.md`](templates/AGENTS-nextjs-saas.md) | LLM app / copilot: Next.js 14 + FastAPI + PostgreSQL + LLM API |
| [`AGENTS-python-ml.md`](templates/AGENTS-python-ml.md) | PyTorch / HuggingFace + MLflow + FastAPI |
| [`AGENTS-react-native.md`](templates/AGENTS-react-native.md) | Expo + FastAPI + EAS Build |

**By AI startup type** — routing, stage guidance, key metrics and conventions for each:

| Template | For |
|---|---|
| [`AGENTS-agent-product.md`](templates/AGENTS-agent-product.md) | Agents that take actions with tools — permissions, approvals, evals |
| [`AGENTS-voice-ai.md`](templates/AGENTS-voice-ai.md) | Voice agents and phone bots — latency budget, turn-taking, consent |
| [`AGENTS-vision-ai.md`](templates/AGENTS-vision-ai.md) | Vision, multimodal and document AI — labeling loop, slices, edge |
| [`AGENTS-generative-media.md`](templates/AGENTS-generative-media.md) | Image/video/audio generation — GPU cost, licenses, content safety |
| [`AGENTS-robotics.md`](templates/AGENTS-robotics.md) | Robotics and embodied AI — sim-to-real, safety envelope, fleet ops |
| [`AGENTS-python-ml.md`](templates/AGENTS-python-ml.md) | Model training and research — also the start for model companies |
| [`AGENTS-healthtech-ai.md`](templates/AGENTS-healthtech-ai.md) | Healthcare AI — HIPAA/GDPR, intended use and device status, clinical safety |
| [`AGENTS-fintech-ai.md`](templates/AGENTS-fintech-ai.md) | Financial services AI — licensing, KYC/AML, fair lending, model risk |
| [`AGENTS-legaltech-ai.md`](templates/AGENTS-legaltech-ai.md) | Legal AI — confidentiality, citations, supervision, UPL |

```bash
cp FoundryAI/templates/AGENTS-voice-ai.md ./AGENTS.md
```

- **Codex, Cursor, Copilot, Windsurf, Zed, Amp…** read `AGENTS.md` directly.
- **Claude Code:** `echo '@AGENTS.md' > CLAUDE.md`
- **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
- **Chat workspaces:** upload it as project knowledge.

---

## Workflow Recipes

[`templates/WORKFLOWS.md`](templates/WORKFLOWS.md) has **23 copy-paste team recipes** — production RAG, AI MVP, launch readiness, cost sprint, voice product, fine-tune-or-not, fundraising sprint, enterprise deal readiness, incident postmortem and more. Paste one into your workspace, fill in the placeholders, and the team runs it.

---

## Hooks & MCP

- **Hooks (Claude Code):** `./install.sh --hooks` adds secret-file write protection (fails closed), subagent usage logging and long-task notifications. Register them with the snippet in [`templates/hooks-setup.md`](templates/hooks-setup.md).
- **MCP servers:** starter configs for GitHub (official remote server), PostgreSQL (read-only) and the filesystem in `templates/mcp-*.json`, with setup for every workspace in [`docs/mcp.md`](docs/mcp.md).

---

## FAQ

**Does FoundryAI send my code or data anywhere?**
No. FoundryAI is prompt files — agents, skills and templates. Your AI workspace runs them with whatever model and data settings you already use.

**What does it cost?**
FoundryAI is free (MIT). You pay your AI workspace or model provider as usual. Agents use a `deep` tier only where reasoning quality matters; coordinators and most specialists use `standard`.

**My workspace can't run subagents.**
Everything still works: coordinators name the right specialist and, if you ask, take on that role themselves.

**Why is the Claude Code plugin called `founders-kit`?**
That's the project's original name, kept so existing plugin installs keep updating.

**I see some agents or skills twice.**
Cursor and VS Code also read Claude Code's folders (`~/.claude/agents`, `~/.claude/skills`) for compatibility. If you install for Claude Code *and* Cursor or Copilot on the same machine, the same FoundryAI agent can appear from both places — they're identical, so use either. Cursor prefers its own copy when names match.

**I installed version 2.x.**
Re-run the installer — it migrates old slash commands to skills and backs up anything you changed. See [CHANGELOG.md](CHANGELOG.md) for what changed.

---

## Contributing

PRs welcome — see [`CONTRIBUTING.md`](CONTRIBUTING.md). Write agents and skills once in the neutral format; `scripts/validate.sh` (run in CI) checks references, counts, output formats and every workspace build. The bar: every agent should be specific enough that a founder knows exactly when to use it and what they'll get back.

## License

MIT — use freely, build products, ship it.

---

*Built by [VenkataAnilKumar](https://github.com/VenkataAnilKumar) · Works with Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI and more*
