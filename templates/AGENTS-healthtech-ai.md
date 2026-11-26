# AGENTS.md — Healthcare AI

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

> **Not legal or regulatory advice.** Healthcare rules depend on your product's intended use and jurisdiction. Confirm with qualified regulatory and legal counsel.

---

## Project Overview

**Type**: Vertical AI — healthcare
**Stage**: [Idea / MVP / Pilots / PMF / Scale]
**AI startup type**: vertical AI (health)
**Team size**: [e.g. 2 founders incl. 1 clinician, 2 engineers]
**Users**: [clinicians / patients / payers / life sciences]
**Intended use**: [e.g. drafting clinical notes for clinician review — no diagnosis]
**Markets**: [US / EU / UK / ...]

---

## Tech Stack

```
Hosting:      cloud regions and services covered by a BAA (US) / suitable for health data (EU/UK)
Models:       model providers/endpoints with BAA or equivalent terms and zero data retention
Data:         encrypted PostgreSQL; PHI segregated; audit log of every access
Integrations: FHIR / HL7, EHR APIs (e.g. Epic, Cerner/Oracle Health) as needed
Identity:     SSO, MFA, role-based access, break-glass procedures
Evals:        clinician-reviewed eval sets; safety and bias slices
```

---

## Agent Routing

- Clinical workflow and domain validation → `ai-domain-expert` (with your clinical advisors)
- HIPAA/GDPR, intended use, medical-device questions → `ai-legal-engineer`
- Security architecture, audit logging, access control → `security-architect` + `ai-security-engineer`
- Bias, safety, human oversight → `ai-responsible-engineer`
- LLM features with PHI-safe design → `ai-engineer`
- EHR/FHIR integrations → `integration-architect` + `ai-backend-engineer`
- Hospital security reviews → `/security-questionnaire`
- Everything else → `/cofounder "describe task"`

---

## Regulatory Checklist (confirm with counsel)

- **Privacy**: HIPAA (US) — BAAs with every vendor touching PHI, minimum necessary, breach process; GDPR special-category data (EU/UK)
- **Medical device status**: does the intended use make it software as a medical device (FDA in the US, MDR in the EU)? Diagnosis/treatment recommendations usually do; administrative and documentation tools often don't — get a written regulatory assessment
- **AI-specific**: EU AI Act high-risk obligations for medical AI; transparency to patients where required
- **Clinical safety**: clinician in the loop for clinical outputs; hazard log; incident reporting
- **Certifications buyers ask for**: SOC 2, HITRUST (US), ISO 27001

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | Administrative/documentation use cases, synthetic or de-identified data, clinician review | Diagnostic claims; real PHI without BAAs |
| Pilots | BAAs, audit logs, clinician-reviewed evals, written intended use | Pilots without success criteria and an exit path |
| Scale | SOC 2/HITRUST, EHR integrations, post-market monitoring | Changing intended use without regulatory review |

## Key Metrics

- Clinician acceptance/edit rate of AI outputs; time saved per encounter
- Safety: harmful or incorrect clinical content rate (clinician-graded)
- Performance by patient subgroup
- Security: access anomalies, audit completeness

---

## Conventions

```
- No PHI in logs, analytics, prompts to non-BAA vendors, or test fixtures
- Every AI output shown to clinicians is labeled as AI-generated and editable
- Every access to PHI is audit-logged with user, purpose and time
- Model and prompt changes go through clinical eval sign-off
- Data retention and deletion follow the documented policy
```

## Useful Skills

`/compliance` · `/security-questionnaire` · `/data-rights` · `/responsible-ai` · `/eval` · `/review-ai`
