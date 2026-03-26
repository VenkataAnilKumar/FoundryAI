# Claude Agents — Your AI Team in a Box

> 34 specialized AI agents + 20 slash commands for Claude Code. Drop them in and get an entire product & engineering team — plus a full developer toolkit.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-blue)](https://claude.ai/code)
[![Agents](https://img.shields.io/badge/agents-34-green)](#agent-roster)
[![Skills](https://img.shields.io/badge/skills-20-orange)](#skills--slash-commands)

---

## What is this?

Instead of switching between AI tools, spinning up different ChatGPT conversations, or wondering which AI is best for your task — you get a full team of specialists that work together inside Claude Code.

**Ask `/founder "build me a RAG-powered document search"` and get:**
- `ai-architect` designing the system
- `ai-engineer` implementing the embedding pipeline
- `ai-backend-engineer` building the API
- `ai-qa-evaluation-engineer` setting up evals

All coordinated. All specialists. No context switching.

---

## What's Included

| | Count | What |
|---|---|---|
| **Agents** | 34 | Specialist subagents (architect, PM, security, data scientist...) |
| **Skills** | 20 | Slash commands (`/review`, `/debug`, `/prd`, `/eval`...) |
| **Routing commands** | 4 | `/founder`, `/engineering`, `/product`, `/business` |
| **Workflow recipes** | 15 | Pre-built multi-agent team prompts |
| **Project template** | 1 | `CLAUDE.md` drop-in for any project |

---

## Quick Install

```bash
# 1. Clone the repo
git clone https://github.com/yourusername/claude-agents

# 2. Install agents (specialist subagents)
cp claude-agents/agents/*.md ~/.claude/agents/

# 3. Install skills (slash commands)
cp claude-agents/skills/*.md ~/.claude/commands/

# 4. (Optional) Install the routing plugin
claude plugin add ./claude-agents/plugin
```

**That's it.** Agents and skills are available in every Claude Code session immediately.

---

## The Team — 34 Specialists

### Engineering (14 agents)
| Agent | Best For |
|---|---|
| `ai-architect` | System design, tech stack decisions, architecture reviews |
| `ai-engineer` | LLM integration, RAG pipelines, embeddings, AI APIs |
| `ai-backend-engineer` | APIs, databases, async processing, microservices |
| `ai-frontend-engineer` | React/Next.js, streaming UI, AI chat interfaces |
| `ai-fullstack-engineer` | End-to-end features across the full stack |
| `ai-mobile-engineer` | React Native, Flutter, iOS/Android, on-device AI |
| `ai-database-engineer` | PostgreSQL, vector DBs, migrations, query optimization |
| `ai-api-designer` | REST/GraphQL/gRPC design, OpenAPI specs, DX |
| `ai-software-engineer` | General coding across any language/framework |
| `ai-agentic-autonomous-engineer` | Multi-agent systems, tool use, autonomous workflows |
| `ai-devops-mlops-engineer` | CI/CD, Docker/K8s, model deployment, MLOps |
| `ai-platform-engineer` | Internal AI platform, model serving, GPU infra |
| `ai-qa-evaluation-engineer` | LLM evals, test frameworks, adversarial testing |
| `ai-research-engineer` | Paper implementation, experiments, new techniques |

### Product (7 agents)
| Agent | Best For |
|---|---|
| `ai-product-manager` | PRDs, roadmaps, user stories, OKRs, GTM |
| `ai-product-builder` | Rapid prototyping, MVPs, demo building |
| `ai-ux-designer` | User flows, wireframes, AI UX patterns |
| `ai-solution-architect` | Client proposals, PoC design, feasibility assessment |
| `ai-strategy-engineer` | AI strategy docs, roadmaps, competitive analysis |
| `prompt-engineer` | Prompt design, optimization, evaluation, few-shot |
| `multi-agent-orchestrator` | Complex multi-agent workflow coordination |

### Business (13 agents)
| Agent | Best For |
|---|---|
| `ai-finance-cost-optimization` | LLM cost reduction, unit economics, ROI analysis |
| `ai-sales-customer-success` | Sales playbooks, demo scripts, churn reduction |
| `ai-growth-marketing` | Content strategy, SEO, AI-powered growth |
| `ai-security-risk` | Threat modeling, prompt injection, red teaming |
| `responsible-ai-engineer` | Bias audits, fairness, safety, EU AI Act |
| `legal-compliance-agent` | GDPR, IP, contracts, regulatory analysis |
| `analytics-insights-agent` | KPI dashboards, funnel analysis, BI reporting |
| `autonomous-ops-agent` | Incident response, monitoring, runbooks |
| `data-scientist` | Statistical analysis, ML modeling, A/B testing |
| `data-engineer` | ETL pipelines, data warehouse, stream processing |
| `domain-expert` | Deep domain knowledge and expert validation |
| `ai-documentation-knowledge-engineer` | API docs, architecture docs, knowledge bases |
| `technical-writer` | User guides, tutorials, SOPs, release notes |

---

## Routing Commands

Install the plugin to get smart routing slash commands:

```
/founder "build a RAG-powered document Q&A feature"
→ Routes to: ai-architect + ai-engineer + ai-backend-engineer (parallel)

/founder "we need to be GDPR compliant before launch"
→ Routes to: legal-compliance-agent + responsible-ai-engineer (parallel)

/founder "optimize our LLM costs, we're at $8k/month"
→ Routes to: ai-finance-cost-optimization + prompt-engineer

/engineering "design the database schema for conversation history"
→ Routes to: ai-database-engineer

/product "write a PRD for AI-powered search"
→ Routes to: ai-product-manager

/business "set up a security review for our AI API"
→ Routes to: ai-security-risk
```

---

## Usage Examples

### Use a single agent
In Claude Code, just mention the agent by name:

```
Use the ai-architect agent to review our system design and identify scaling risks.
```

### Use multiple agents in parallel
```
Use ai-frontend-engineer and ai-backend-engineer in parallel to build the
user authentication flow — frontend handles the UI, backend handles the JWT API.
```

### Use the founder for complex projects
```
Use the founder agent to orchestrate building a complete AI SaaS product MVP.
Include: architecture, frontend, backend, deployment, and an eval framework.
```

### Use workflow recipes
Copy a recipe from [`templates/WORKFLOWS.md`](templates/WORKFLOWS.md) and paste it into Claude Code to launch a pre-configured team.

---

## Project Template

Add the included [`templates/CLAUDE.md`](templates/CLAUDE.md) to your project root. It tells Claude Code which agents to use for each type of task in your specific project.

```bash
cp ~/.claude/agents-repo/templates/CLAUDE.md ./CLAUDE.md
# Edit with your project's tech stack and conventions
```

---

## Skills — Slash Commands

20 slash commands for common developer tasks. Instant, no subprocess.

### Code Quality
| Command | What it does |
|---|---|
| `/review` | Code review: logic, security, performance — CRITICAL/HIGH/MEDIUM/LOW severity |
| `/review-ai` | AI-specific: prompt injection, hallucination risks, PII leakage, token cost |
| `/debug "error"` | 6-step structured debugging: symptom → evidence → hypotheses → fix → verify |
| `/test-plan "feature"` | Complete test plan: unit, integration, E2E, edge cases, coverage targets |
| `/explain` | Plain-language explanation of any code with examples and analogies |

### Feature Development
| Command | What it does |
|---|---|
| `/feature "name"` | Classifies feature, routes to the right agents in parallel automatically |
| `/prd "idea"` | Lean PRD: user stories, acceptance criteria, success metrics, non-goals |
| `/spec "component"` | Technical spec: interface, behavior, error cases, data model |
| `/estimate "task"` | T-shirt sizing with breakdown, risk multipliers, unknowns |

### AI / LLM Specific
| Command | What it does |
|---|---|
| `/prompt "text"` | Optimize any prompt — diagnosis, rewrite, diff of changes, edge cases |
| `/eval "feature"` | Design an eval suite — 15+ test cases, scoring, regression strategy |
| `/rag-design` | RAG architecture: chunking, embeddings, vector DB, retrieval approach |
| `/cost-check` | Token cost estimate at scale + ranked optimization recommendations |
| `/agent-design "role"` | Design a new agent — outputs a complete ready-to-use `.md` file |

### Docs & Communication
| Command | What it does |
|---|---|
| `/docs` | Docstrings, API docs, architecture docs — language-appropriate format |
| `/changelog "v1.2.0"` | CHANGELOG entry from recent git commits |
| `/release "v2.0.0"` | Release notes with highlights, breaking changes, upgrade steps |
| `/standup` | Standup update from recent git activity |

### Launch & Ops
| Command | What it does |
|---|---|
| `/launch-check` | 40-point pre-launch checklist — security, ops, compliance, comms |
| `/incident "error"` | Incident response: severity triage, containment, RCA, postmortem |

→ Full reference: [`docs/skills.md`](docs/skills.md)

---

## File Structure

```
claude-agents/
├── agents/                    ← 34 specialist agent definitions
│   ├── ai-architect.md
│   ├── ai-engineer.md
│   ├── founder.md        ← Master routing agent
│   └── ... (31 more)
├── skills/                    ← 20 slash commands (~/.claude/commands/)
│   ├── review.md              ← /review
│   ├── review-ai.md           ← /review-ai
│   ├── debug.md               ← /debug
│   ├── feature.md             ← /feature
│   ├── prd.md                 ← /prd
│   ├── prompt.md              ← /prompt
│   ├── eval.md                ← /eval
│   ├── rag-design.md          ← /rag-design
│   ├── cost-check.md          ← /cost-check
│   ├── agent-design.md        ← /agent-design
│   ├── docs.md                ← /docs
│   ├── changelog.md           ← /changelog
│   ├── release.md             ← /release
│   ├── standup.md             ← /standup
│   ├── launch-check.md        ← /launch-check
│   ├── incident.md            ← /incident
│   ├── spec.md                ← /spec
│   ├── estimate.md            ← /estimate
│   ├── test-plan.md           ← /test-plan
│   └── explain.md             ← /explain
├── plugin/                    ← Claude Code plugin (routing + AI skills)
│   ├── .claude-plugin/
│   └── commands/
│       ├── team.md            ← /team (universal router)
│       ├── engineering.md     ← /engineering
│       ├── product.md         ← /product
│       ├── business.md        ← /business
│       ├── feature.md         ← /feature
│       ├── prompt.md          ← /prompt
│       ├── review-ai.md       ← /review-ai
│       ├── eval.md            ← /eval
│       ├── rag-design.md      ← /rag-design
│       └── ... (more AI skills)
├── templates/
│   ├── CLAUDE.md              ← Drop into your project root
│   └── WORKFLOWS.md           ← 15 pre-built team recipes
└── docs/
    ├── agents.md              ← Full agent capability reference
    └── skills.md              ← Full skills reference
```

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- Claude API access (Anthropic account)
- Agent Teams feature enabled in Claude Code settings

---

## Contributing

PRs welcome! If you build a useful agent, submit it. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

MIT — use freely, build products, ship it.

---

*Built by [venka](https://github.com/venka) · Powered by [Claude Code](https://claude.ai/code)*
