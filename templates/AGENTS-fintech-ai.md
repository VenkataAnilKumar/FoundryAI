# AGENTS.md — Financial Services AI

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

> **Not legal or regulatory advice.** Financial regulation depends on your activities, licenses and jurisdictions. Confirm with qualified compliance and legal counsel.

---

## Project Overview

**Type**: Vertical AI — financial services
**Stage**: [Idea / MVP / Pilots / PMF / Scale]
**AI startup type**: vertical AI (finance)
**Team size**: [e.g. 2 founders, 3 engineers, fractional compliance lead]
**Users**: [banks / fintechs / insurers / accounting firms / consumers]
**Activities**: [e.g. KYC document review, fraud triage, credit memo drafting, bookkeeping automation]
**Markets**: [US / EU / UK / ...]

---

## Tech Stack

```
Hosting:      cloud with strong tenant isolation; regions matching data-residency requirements
Models:       providers with zero data retention and no training on customer data; fallback provider
Data:         encrypted PostgreSQL, immutable audit log, data lineage for every decision
Integrations: core banking / payments / accounting APIs, KYC/AML vendors, open banking
Identity:     SSO, MFA, RBAC, four-eyes approval for sensitive actions
Evals:        decision-quality evals, explainability, fairness slices, drift monitoring
```

---

## Agent Routing

- Financial domain validation → `ai-domain-expert`
- Regulatory scope, contracts, model-risk expectations → `ai-legal-engineer`
- Security, audit, tenant isolation → `security-architect` + `ai-security-engineer`
- Fairness, explainability, adverse-action reasons → `ai-responsible-engineer`
- Fraud/risk models and monitoring → `ai-data-scientist` + `ml-engineer`
- LLM document workflows → `ai-engineer`
- Bank vendor-risk reviews → `/security-questionnaire`
- Everything else → `/cofounder "describe task"`

---

## Regulatory Checklist (confirm with counsel)

- **Licensing**: does the product move money, give advice, lend, or hold funds? That may require licenses or a regulated partner
- **KYC/AML**: customer identification, sanctions screening, suspicious-activity escalation; AI assists, humans decide where rules require
- **Fair lending & consumer protection**: explainable decisions, adverse-action reasons, disparate-impact testing (e.g. ECOA in the US)
- **Model risk management**: bank customers will expect model documentation, validation and monitoring (e.g. SR 11-7-style practices in the US)
- **Data & security**: GLBA (US), GDPR (EU/UK), PCI DSS for card data, SOC 2 Type II
- **Records**: retention of communications and decisions where required
- **AI-specific**: EU AI Act high-risk categories (e.g. creditworthiness assessment)

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | Back-office assistance with human decision-makers, synthetic or anonymized data | Automated decisions on consumers |
| Pilots | Audit trail, explainability, model documentation, partner bank compliance review | Pilots that skip vendor-risk review |
| Scale | SOC 2 Type II, model risk program, monitoring for drift and bias | Expanding activities without checking licensing |

## Key Metrics

- Decision accuracy vs human baseline; false positive/negative rates (fraud, KYC)
- Time per case; analyst throughput
- Fairness metrics across protected groups
- Audit completeness; explanation coverage for every decision

---

## Conventions

```
- Every AI-assisted decision stores inputs, model/prompt version, output, explanation and the human approver
- No customer financial data in logs, analytics or non-approved vendors
- Consumer-impacting decisions are never fully automated without explicit compliance sign-off
- Model and prompt changes require eval results and a change record
- Monitoring alerts on drift, error spikes and fairness regressions
```

## Useful Skills

`/compliance` · `/security-questionnaire` · `/data-rights` · `/responsible-ai` · `/eval` · `/ai-pricing`
