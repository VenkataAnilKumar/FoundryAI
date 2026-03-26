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
| `ai-finance-cost-optimization` | AI cloud costs, token spend, ROI analysis, cost reduction, unit economics |
| `ai-sales-customer-success` | Sales playbooks, demo scripts, onboarding, churn, QBR, expansion strategy |
| `ai-growth-marketing` | Content strategy, SEO, campaigns, growth experiments, AI-powered marketing |
| `ai-security-risk` | Security review, threat modeling, prompt injection testing, vulnerability assessment |
| `responsible-ai-engineer` | Bias audit, fairness evaluation, AI safety, ethics review, risk assessment |
| `legal-compliance-agent` | GDPR, EU AI Act, IP risk, data privacy, contracts, regulatory analysis |
| `analytics-insights-agent` | KPI dashboards, funnel analysis, business intelligence, executive reporting |
| `autonomous-ops-agent` | Incident response, system monitoring, runbook execution, deployment ops |
| `data-scientist` | Statistical analysis, ML modeling, A/B testing, experimentation, predictions |
| `data-engineer` | ETL/ELT pipelines, data warehouse, data quality, stream processing |
| `domain-expert` | Deep domain knowledge, expert review of AI outputs, specialized validation |
| `ai-documentation-knowledge-engineer` | API docs, architecture docs, runbooks, knowledge bases, internal wikis |
| `technical-writer` | User guides, tutorials, how-to articles, SOPs, release notes |

## Instructions

1. Read the task and identify the business function it belongs to
2. Pick the **right agent(s)**:
   - For compliance reviews → run `ai-security-risk` + `responsible-ai-engineer` + `legal-compliance-agent` in **parallel**
   - For data work → `data-engineer` (pipeline) vs `data-scientist` (analysis) — pick the right one
   - For documentation → `ai-documentation-knowledge-engineer` (technical/API) vs `technical-writer` (user-facing)
   - For ops → `autonomous-ops-agent` for live incidents, `ai-devops-mlops-engineer` for pipeline setup
3. Spawn the chosen agent(s) with full task context and expected deliverables
