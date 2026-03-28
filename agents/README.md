# Claude Code AI Agent Pack — Full Team (52 Agents + 9 Team Coordinators)

A complete set of **52 specialist AI agents** and **9 team coordinators** covering every role across a modern AI product organization. Drop them into `~/.claude/agents/` for instant access in Claude Code.

---

## Agent Roster

### Architecture Team (7)
| Agent | File |
|-------|------|
| AI Architect | `ai-architect.md` |
| Cloud Architect | `cloud-architect.md` |
| Data Architect | `data-architect.md` |
| Integration Architect | `integration-architect.md` |
| Security Architect | `security-architect.md` |
| Software Architect | `software-architect.md` |
| Staff Engineer | `staff-engineer.md` |

### Data & AI Team (6)
| Agent | File |
|-------|------|
| AI Analytics Engineer | `ai-analytics-engineer.md` |
| AI Data Engineer | `ai-data-engineer.md` |
| AI Data Scientist | `ai-data-scientist.md` |
| AI Domain Expert | `ai-domain-expert.md` |
| AI Prompt Engineer | `ai-prompt-engineer.md` |
| AI Research Engineer | `ai-research-engineer.md` |

### Engineering Team (12)
| Agent | File |
|-------|------|
| AI Agent Engineer | `ai-agent-engineer.md` |
| AI API Designer | `ai-api-designer.md` |
| AI Backend Engineer | `ai-backend-engineer.md` |
| AI Database Engineer | `ai-database-engineer.md` |
| AI DevOps Engineer | `ai-devops-engineer.md` |
| AI Engineer | `ai-engineer.md` |
| AI Frontend Engineer | `ai-frontend-engineer.md` |
| AI Full Stack Engineer | `ai-fullstack-engineer.md` |
| AI Mobile Engineer | `ai-mobile-engineer.md` |
| AI Performance Engineer | `ai-performance-engineer.md` |
| AI QA Engineer | `ai-qa-engineer.md` |
| AI Software Engineer | `ai-software-engineer.md` |

### Growth Team (4)
| Agent | File |
|-------|------|
| AI Finance Engineer | `ai-finance-engineer.md` |
| AI Growth Engineer | `ai-growth-engineer.md` |
| AI Sales Engineer | `ai-sales-engineer.md` |
| Developer Advocate | `developer-advocate.md` |

### Knowledge Team (3)
| Agent | File |
|-------|------|
| AI Accessibility Engineer | `ai-accessibility-engineer.md` |
| AI Technical Writer | `ai-technical-writer.md` |
| Content Designer | `content-designer.md` |

### Leadership Team (5)
| Agent | File |
|-------|------|
| AI Orchestrator | `ai-orchestrator.md` |
| CTO Advisor | `cto-advisor.md` |
| Engineering Manager | `engineering-manager.md` |
| Founder | `founder.md` |
| Technical Program Manager | `technical-program-manager.md` |

### Platform Team (4)
| Agent | File |
|-------|------|
| AI Platform Engineer | `ai-platform-engineer.md` |
| ML Engineer | `ml-engineer.md` |
| Release Manager | `release-manager.md` |
| Site Reliability Engineer | `site-reliability-engineer.md` |

### Product Team (8)
| Agent | File |
|-------|------|
| AI Product Manager | `ai-product-manager.md` |
| AI Strategy Engineer | `ai-strategy-engineer.md` |
| AI UX Designer | `ai-ux-designer.md` |
| Product Analyst | `product-analyst.md` |
| Product Designer | `product-designer.md` |
| Product Marketing Manager | `product-marketing-manager.md` |
| Technical Product Manager | `technical-product-manager.md` |
| UX Researcher | `ux-researcher.md` |

### Safety Team (3)
| Agent | File |
|-------|------|
| AI Legal Engineer | `ai-legal-engineer.md` |
| AI Responsible Engineer | `ai-responsible-engineer.md` |
| AI Security Engineer | `ai-security-engineer.md` |

---

## Team Coordinators (9)

Each team coordinator knows its members, can delegate subtasks, and orchestrates team workflows.

| Coordinator | File | Team |
|-------------|------|------|
| Team Architecture | `team-architecture.md` | 7 architecture agents |
| Team Data & AI | `team-data-ai.md` | 6 data/AI agents |
| Team Engineering | `team-engineering.md` | 12 engineering agents |
| Team Growth | `team-growth.md` | 4 growth agents |
| Team Knowledge | `team-knowledge.md` | 3 knowledge agents |
| Team Leadership | `team-leadership.md` | 5 leadership agents |
| Team Platform | `team-platform.md` | 4 platform agents |
| Team Product | `team-product.md` | 8 product agents |
| Team Safety | `team-safety.md` | 3 safety agents |

---

## Installation

```bash
# From FoundryAI root
cp agents/*.md ~/.claude/agents/
```

Or use the one-line installer:
```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

Restart Claude Code and run `/agents` to verify all 61 agents appear.

---

## Quick Start

```bash
# Spawn your co-founder for any strategic task
/founder "build me a RAG-powered document search"

# Route directly to a specialist
# Use the Agent tool or type the agent name in Claude Code
```

See `CLAUDE.md` for the full routing guide and `WORKFLOWS.md` for pre-built team workflows.
