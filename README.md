# Claude Agents — Your AI Team in a Box

> 34 specialized AI agents for Claude Code. Drop them in and get an entire product & engineering team available as subagents.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-blue)](https://claude.ai/code)
[![Agents](https://img.shields.io/badge/agents-34-green)](#agent-roster)

---

## What is this?

Instead of switching between AI tools, spinning up different ChatGPT conversations, or wondering which AI is best for your task — you get a full team of specialists that work together inside Claude Code.

**Ask `/team "build me a RAG-powered document search"` and get:**
- `ai-architect` designing the system
- `ai-engineer` implementing the embedding pipeline
- `ai-backend-engineer` building the API
- `ai-qa-evaluation-engineer` setting up evals

All coordinated. All specialists. No context switching.

---

## Quick Install

```bash
# 1. Clone to your Claude agents folder
git clone https://github.com/yourusername/claude-agents ~/.claude/agents-repo

# 2. Copy agents to Claude's agents directory
cp ~/.claude/agents-repo/agents/*.md ~/.claude/agents/

# 3. (Optional) Install the routing plugin
claude plugin add ./plugin
```

**That's it.** The agents are now available in every Claude Code session.

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
/team "build a RAG-powered document Q&A feature"
→ Routes to: ai-architect + ai-engineer + ai-backend-engineer (parallel)

/team "we need to be GDPR compliant before launch"
→ Routes to: legal-compliance-agent + responsible-ai-engineer (parallel)

/team "optimize our LLM costs, we're at $8k/month"
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

### Use the team-manager for complex projects
```
Use the team-manager agent to orchestrate building a complete AI SaaS product MVP.
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

## File Structure

```
claude-agents/
├── agents/                    ← 34 specialist agent definitions
│   ├── ai-architect.md
│   ├── ai-engineer.md
│   ├── team-manager.md        ← Master routing agent
│   └── ... (31 more)
├── plugin/                    ← Claude Code plugin (routing commands)
│   ├── .claude-plugin/
│   └── commands/
│       ├── team.md            ← /team command
│       ├── engineering.md     ← /engineering command
│       ├── product.md         ← /product command
│       └── business.md        ← /business command
├── templates/
│   ├── CLAUDE.md              ← Drop into your project root
│   └── WORKFLOWS.md           ← 15 pre-built team recipes
└── docs/
    └── agents.md              ← Full agent capability reference
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
