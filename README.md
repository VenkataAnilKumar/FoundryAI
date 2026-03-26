# Founders Kit — Your AI Team in a Box

> 38 specialist AI agents + 25 slash commands + hooks + MCP configs for Claude Code.
> One install. Your entire product, engineering, and business team — ready to ship.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-blue)](https://claude.ai/code)
[![Agents](https://img.shields.io/badge/agents-38-green)](#the-team--38-specialists)
[![Skills](https://img.shields.io/badge/skills-25-orange)](#skills--25-slash-commands)
[![Plugin](https://img.shields.io/badge/plugin-founders--kit-purple)](#routing-commands)

---

## What is this?

Instead of switching between AI tools, spinning up different ChatGPT conversations, or wondering which AI is best for your task — you get a full team of specialists that work together inside Claude Code.

**Type `/founder "build me a RAG-powered document search"` and get:**
- `ai-architect` designing the system
- `ai-engineer` implementing the embedding pipeline
- `ai-backend-engineer` building the API
- `ai-qa-engineer` setting up evals

All coordinated. All specialists. No context switching.

---

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/VenkataAnilKumar/FoundryAI

# Agents
cp FoundryAI/agents/*.md ~/.claude/agents/

# Skills (slash commands)
mkdir -p ~/.claude/commands
cp FoundryAI/skills/*.md ~/.claude/commands/

# Plugin (routing commands)
claude plugin add ./FoundryAI/plugin
```

---

## What's Included

| | Count | What |
|---|---|---|
| **Agents** | 38 | Specialist subagents across engineering, product, and business |
| **Skills** | 25 | Slash commands — `/review`, `/debug`, `/prd`, `/eval`, `/migrate`... |
| **Routing commands** | 4 | `/founder`, `/engineering`, `/product`, `/business` |
| **Project templates** | 4 | Stack-specific `CLAUDE.md` files for your project |
| **Workflow recipes** | 15 | Pre-built multi-agent team prompts |
| **Hooks** | 3 | Automated behaviors (logging, protection, notifications) |
| **MCP configs** | 3 | GitHub, PostgreSQL, full-stack server configs |

---

## The Team — 38 Specialists

### Leadership
| Agent | Best For |
|---|---|
| `founder` | Your AI co-founder — thinks strategically, delegates to the right team, ships |
| `cto-advisor` | Build-vs-buy decisions, hiring plans, tech debt strategy, scaling engineering teams |

### Engineering (14 agents)
| Agent | Best For |
|---|---|
| `ai-architect` | System design, tech stack decisions, architecture reviews, ADRs |
| `ai-engineer` | LLM integration, RAG pipelines, embeddings, Claude/OpenAI API |
| `ai-backend-engineer` | APIs, databases, async processing, microservices |
| `ai-frontend-engineer` | React/Next.js, streaming UI, AI chat interfaces |
| `ai-fullstack-engineer` | End-to-end features across the full stack |
| `ai-mobile-engineer` | React Native, Flutter, iOS/Android, on-device AI |
| `ai-database-engineer` | PostgreSQL, vector DBs, migrations, query optimization |
| `ai-api-designer` | REST/GraphQL/gRPC design, OpenAPI specs, DX |
| `ai-software-engineer` | General coding across any language/framework |
| `ai-agent-engineer` | Multi-agent systems, tool use, autonomous workflows |
| `ai-devops-engineer` | CI/CD, Docker/K8s, model deployment, MLOps |
| `ai-platform-engineer` | Internal AI platform, model serving, GPU infra |
| `ai-qa-engineer` | LLM evals, test frameworks, adversarial testing |
| `ai-research-engineer` | Paper implementation, experiments, new techniques |
| `ai-performance-engineer` | Core Web Vitals, API latency, DB query optimization, load testing |
| `ai-accessibility-engineer` | WCAG 2.2, screen readers, keyboard nav, ARIA patterns |

### Product (7 agents)
| Agent | Best For |
|---|---|
| `ai-product-manager` | PRDs, roadmaps, user stories, OKRs, GTM planning |
| `ai-product-builder` | Rapid prototyping, MVPs, demo building |
| `ai-ux-designer` | User flows, wireframes, AI UX patterns, onboarding design |
| `ai-solution-architect` | Client proposals, PoC design, feasibility assessment |
| `ai-strategy-engineer` | AI strategy docs, competitive analysis, 3-year roadmaps |
| `ai-prompt-engineer` | Prompt design, optimization, evaluation, few-shot examples |
| `ai-orchestrator` | Complex multi-agent workflow coordination |

### Business (13 agents)
| Agent | Best For |
|---|---|
| `ai-finance-engineer` | LLM cost reduction, unit economics, ROI analysis |
| `ai-sales-engineer` | Sales playbooks, demo scripts, churn reduction |
| `ai-growth-engineer` | Content strategy, SEO, AI-powered growth experiments |
| `ai-security-engineer` | Threat modeling, prompt injection, red teaming |
| `ai-responsible-engineer` | Bias audits, fairness, safety, EU AI Act compliance |
| `ai-legal-engineer` | GDPR, IP, contracts, regulatory analysis |
| `ai-analytics-engineer` | KPI dashboards, funnel analysis, BI reporting |
| `ai-ops-engineer` | Incident response, monitoring, runbooks |
| `ai-data-scientist` | Statistical analysis, ML modeling, A/B testing |
| `ai-data-engineer` | ETL pipelines, data warehouse, stream processing |
| `ai-domain-expert` | Deep domain knowledge and expert validation |
| `ai-docs-engineer` | API docs, architecture docs, knowledge bases |
| `ai-technical-writer` | User guides, tutorials, SOPs, release notes |

---

## Routing Commands

```
/founder "build a RAG-powered document Q&A feature"
→ Thinks strategically, routes to: ai-architect + ai-engineer + ai-backend-engineer

/founder "we need to be GDPR compliant before launch"
→ Routes to: ai-legal-engineer + ai-responsible-engineer (parallel)

/founder "our API latency is 2 seconds — fix it"
→ Routes to: ai-performance-engineer + ai-database-engineer

/engineering "design the database schema for conversation history"
→ Routes to: ai-database-engineer

/product "write a PRD for AI-powered search"
→ Routes to: ai-product-manager

/business "set up a security review for our AI API"
→ Routes to: ai-security-engineer
```

---

## Skills — 25 Slash Commands

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

### Feature Development
| Command | What it does |
|---|---|
| `/feature "name"` | Classifies feature, routes to right agents in parallel |
| `/prd "idea"` | Lean PRD: user stories, acceptance criteria, success metrics |
| `/spec "component"` | Technical spec: interface, behavior, error cases, data model |
| `/estimate "task"` | T-shirt sizing with breakdown, risk multipliers, unknowns |

### AI / LLM Specific
| Command | What it does |
|---|---|
| `/prompt "text"` | Optimize any prompt — diagnosis, rewrite, diff of changes |
| `/eval "feature"` | Design an eval suite — 15+ test cases, scoring, regression strategy |
| `/rag-design` | RAG architecture: chunking, embeddings, vector DB, retrieval |
| `/cost-check` | Token cost estimate at scale + ranked optimization recommendations |
| `/agent-design "role"` | Design a new agent — outputs a complete ready-to-use `.md` file |

### Docs & Communication
| Command | What it does |
|---|---|
| `/docs` | Docstrings, API docs, architecture docs |
| `/changelog "v1.2.0"` | CHANGELOG entry from recent git commits |
| `/release "v2.0.0"` | Release notes: highlights, breaking changes, upgrade steps |
| `/standup` | Standup update from recent git activity |
| `/onboard` | 30-day engineer onboarding guide for your codebase |

### Launch & Ops
| Command | What it does |
|---|---|
| `/launch-check` | 40-point pre-launch checklist — security, ops, compliance, comms |
| `/incident "error"` | Incident response: severity triage, RCA, postmortem template |
| `/migrate` | Migration plan: zero-downtime strategy, rollback, data safety |
| `/api-test` | Full API test suite from endpoint description or OpenAPI spec |

→ Full reference: [`docs/skills.md`](docs/skills.md)

---

## Project Templates

Drop a stack-specific `CLAUDE.md` into your project root — it configures agent routing for your exact setup.

| Template | Stack |
|---|---|
| [`CLAUDE.md`](templates/CLAUDE.md) | Generic — works for any project |
| [`CLAUDE-nextjs-saas.md`](templates/CLAUDE-nextjs-saas.md) | Next.js 14 + FastAPI + PostgreSQL + Claude API |
| [`CLAUDE-python-ml.md`](templates/CLAUDE-python-ml.md) | PyTorch / HuggingFace + MLflow + FastAPI |
| [`CLAUDE-react-native.md`](templates/CLAUDE-react-native.md) | Expo + FastAPI + EAS Build |

```bash
# Example: Next.js SaaS project
cp FoundryAI/templates/CLAUDE-nextjs-saas.md ./CLAUDE.md
# Edit with your project name, stage, and any custom conventions
```

---

## Hooks & MCP

### Hooks — Automate Claude Code behaviors

```bash
cp FoundryAI/templates/hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

| Hook | Trigger | Does |
|---|---|---|
| `log-agent-usage.sh` | After every agent call | Logs to `~/.claude/logs/agent-usage.log` |
| `protect-env-files.sh` | Before any file write | Blocks writes to `.env`, `.pem`, `secrets.*` |
| `notify-on-complete.sh` | Task complete | Desktop notification (Windows/Mac/Linux) |

### MCP Servers — Connect Claude to your infrastructure

```bash
# GitHub (issues, PRs, code search)
cp FoundryAI/templates/mcp-github.json ./.mcp.json

# PostgreSQL (query your DB directly)
cp FoundryAI/templates/mcp-postgres.json ./.mcp.json

# Full stack (GitHub + PostgreSQL + Filesystem)
cp FoundryAI/templates/mcp-full-stack.json ./.mcp.json
```

See [`templates/hooks-setup.md`](templates/hooks-setup.md) for full setup instructions.

---

## Usage Examples

### Single agent
```
Use the ai-architect agent to review our system design and identify scaling risks.
```

### Parallel agents
```
Use ai-frontend-engineer and ai-backend-engineer in parallel to build
user authentication — frontend handles the UI, backend handles the JWT API.
```

### Full project with the founder
```
Use the founder agent to plan and execute our AI product launch —
architecture, engineering, compliance, docs, and marketing.
```

### Workflow recipe
Copy any recipe from [`templates/WORKFLOWS.md`](templates/WORKFLOWS.md) and paste into Claude Code to launch a pre-configured team for 15 common scenarios.

---

## File Structure

```
FoundryAI/
├── install.sh                       ← one-liner installer
├── agents/                          ← 38 agent definitions
│   ├── founder.md                   ← AI co-founder (master orchestrator)
│   ├── cto-advisor.md               ← Technical leadership advisor
│   ├── ai-architect.md
│   └── ... (35 more specialists)
├── skills/                          ← 25 slash commands
│   ├── review.md                    ← /review
│   ├── debug.md                     ← /debug
│   ├── prd.md                       ← /prd
│   └── ... (22 more)
├── plugin/                          ← founders-kit plugin
│   ├── .claude-plugin/
│   └── commands/                    ← /founder + domain commands
├── templates/
│   ├── CLAUDE.md                    ← Generic project config
│   ├── CLAUDE-nextjs-saas.md        ← Next.js + FastAPI template
│   ├── CLAUDE-python-ml.md          ← Python ML project template
│   ├── CLAUDE-react-native.md       ← React Native mobile template
│   ├── WORKFLOWS.md                 ← 15 pre-built team recipes
│   ├── hooks/                       ← 3 automation hook scripts
│   ├── mcp-github.json              ← GitHub MCP config
│   ├── mcp-postgres.json            ← PostgreSQL MCP config
│   └── mcp-full-stack.json          ← Combined MCP config
└── docs/
    ├── agents.md                    ← Full agent reference
    └── skills.md                    ← Full skills reference
```

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- Anthropic API access
- Agent Teams enabled: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in Claude Code settings

---

## Contributing

PRs welcome. To add a new agent, see [`CONTRIBUTING.md`](CONTRIBUTING.md).
The quality bar: every agent should be specific enough that a developer knows exactly when to use it and what to expect back.

---

## License

MIT — use freely, build products, ship it.

---

*Built by [VenkataAnilKumar](https://github.com/VenkataAnilKumar) · Powered by [Claude Code](https://claude.ai/code)*
