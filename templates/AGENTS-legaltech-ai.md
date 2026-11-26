# AGENTS.md — Legal AI

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

> **Not legal advice.** Professional-responsibility and unauthorized-practice rules vary by jurisdiction. Confirm with qualified counsel.

---

## Project Overview

**Type**: Vertical AI — legal
**Stage**: [Idea / MVP / Pilots / PMF / Scale]
**AI startup type**: vertical AI (legal)
**Team size**: [e.g. 2 founders incl. 1 lawyer, 2 engineers]
**Users**: [law firms / in-house legal teams / consumers / courts]
**Workflows**: [e.g. contract review, due diligence, legal research, drafting, e-discovery]

---

## Tech Stack

```
Models:       providers with zero data retention, no training on customer data, enterprise terms
Retrieval:    hybrid search over matters/contracts with per-matter access control; citation tracking
Data:         encrypted storage, ethical walls between clients/matters, legal-hold support
Integrations: document management (e.g. iManage, NetDocuments), Microsoft Word add-in, CLM systems
Identity:     SSO, MFA, matter-level permissions
Evals:        lawyer-graded evals, citation accuracy checks, hallucination tests
```

---

## Agent Routing

- Legal domain validation and workflow design → `ai-domain-expert` (with practicing lawyers)
- Professional responsibility, confidentiality, product terms → `ai-legal-engineer`
- Retrieval with citations, document pipelines → `ai-engineer` + `ai-data-engineer`
- Matter-level access control, ethical walls → `security-architect`
- Hallucination and citation evals → `ai-qa-engineer` + `/eval`
- Word add-in and review UI → `ai-frontend-engineer`
- Law-firm security reviews → `/security-questionnaire`
- Everything else → `/cofounder "describe task"`

---

## Professional Checklist (confirm with counsel)

- **Confidentiality & privilege**: client data never used for training; strict tenant and matter isolation; vendor terms that preserve confidentiality
- **Accuracy**: every legal assertion linked to a verifiable source; no fabricated citations; clear "verify before relying" UX
- **Supervision**: lawyers remain responsible for work product; tools support review, not replace it
- **Unauthorized practice of law**: consumer-facing products must stay on the right side of local rules
- **Bar guidance on AI**: many bars have issued generative-AI guidance (competence, confidentiality, billing transparency) — design for it
- **Security expectations**: SOC 2 / ISO 27001, outside counsel guidelines, client audit rights

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | One workflow (e.g. NDA review), cited answers, lawyer review | Uncited legal conclusions |
| Pilots | Matter isolation, lawyer-graded evals, DMS integration | Using pilot client data for anything beyond that client |
| Scale | SOC 2, firm-wide rollout tooling, usage analytics for partners | Expanding to consumer advice without UPL review |

## Key Metrics

- Citation accuracy; hallucinated-citation rate (target: zero)
- Lawyer acceptance/edit rate; time saved per matter or document
- Issue-spotting recall vs lawyer review
- Seats active weekly; matters processed

---

## Conventions

```
- Every generated legal statement carries a source citation the user can open
- Client and matter data isolated; retrieval filtered by matter permissions before ranking
- No client data in logs, analytics, evals or training without written permission
- Outputs labeled as drafts for lawyer review
- Model or prompt changes pass citation-accuracy and hallucination evals
```

## Useful Skills

`/compliance` · `/security-questionnaire` · `/data-rights` · `/rag-design` · `/eval` · `/review-ai`
