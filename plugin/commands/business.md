---
description: Route any business, operations, compliance, data, or content task to the right specialist
argument-hint: Describe the business or operations task
---

You are routing a business, operations, data, or compliance task to the right specialist agent.

## Task
$ARGUMENTS

## Business Agent Roster

| Agent | Use When |
|---|---|
| `ai-finance-engineer` | AI cloud costs, token spend, ROI analysis, cost reduction, unit economics |
| `ai-sales-engineer` | Sales playbooks, demo scripts, onboarding, churn, QBR, expansion strategy |
| `ai-growth-engineer` | Content strategy, SEO, campaigns, growth experiments, AI-powered marketing |
| `ai-security-engineer` | Security review, threat modeling, prompt injection testing, vulnerability assessment |
| `ai-responsible-engineer` | Bias audit, fairness evaluation, AI safety, ethics review, risk assessment |
| `ai-legal-engineer` | GDPR, EU AI Act, IP risk, data privacy, contracts, regulatory analysis |
| `ai-analytics-engineer` | KPI dashboards, funnel analysis, business intelligence, executive reporting |
| `ai-ops-engineer` | Incident response, system monitoring, runbook execution, deployment ops |
| `ai-data-scientist` | Statistical analysis, ML modeling, A/B testing, experimentation, predictions |
| `ai-data-engineer` | ETL/ELT pipelines, data warehouse, data quality, stream processing |
| `ai-domain-expert` | Deep domain knowledge, expert review of AI outputs, specialized validation |
| `ai-docs-engineer` | API docs, architecture docs, runbooks, knowledge bases, internal wikis |
| `ai-technical-writer` | User guides, tutorials, how-to articles, SOPs, release notes |

## Instructions

1. Read the task and identify the business function it belongs to
2. Pick the **right agent(s)**:
   - For compliance reviews → run `ai-security-engineer` + `ai-responsible-engineer` + `ai-legal-engineer` in **parallel**
   - For data work → `ai-data-engineer` (pipeline) vs `ai-data-scientist` (analysis) — pick the right one
   - For documentation → `ai-docs-engineer` (technical/API) vs `ai-technical-writer` (user-facing)
   - For ops → `ai-ops-engineer` for live incidents, `ai-devops-engineer` for pipeline setup
3. Spawn the chosen agent(s) with full task context and expected deliverables
