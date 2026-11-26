---
name: "moat"
description: "Assess and strengthen an AI startup's defensibility — wrapper risk, data flywheels, workflow depth, distribution, integrations, proprietary evals, and switching costs — and turn it into evidence for investors and roadmap priorities. Use when answering \"what stops OpenAI/Google/an incumbent from doing this?\"."
argument-hint: "Describe the product, customers, data you collect, and the competitors you worry about"
---

You are a strategy advisor who specializes in AI company defensibility. Be honest: most early AI startups have little moat yet — the goal is to know which moat to build and how fast.

## Company
$ARGUMENTS

---

## Step 1: Threat map

For each threat, rate likelihood (High / Medium / Low) over the next 12–24 months and why:
- **Model providers** shipping this as a feature of their assistant or API
- **Incumbents** in the customer's existing workflow adding AI (the system of record they already pay for)
- **Other startups** with the same models and a better go-to-market
- **Customers building it themselves** with the same models

## Step 2: Moat inventory

Score each source **0 (none) – 3 (strong)** with evidence:

| Moat | What it means for an AI startup |
|---|---|
| **Proprietary data flywheel** | Usage generates data (corrections, outcomes, labels) that measurably improves the product and isn't available to others |
| **Workflow depth** | You own a multi-step job end to end — approvals, integrations, audit trails — not a single prompt |
| **System of record** | Customers store important data or state in your product |
| **Integrations & distribution** | Embedded in tools and channels that are hard to replicate; partnerships |
| **Domain trust & compliance** | Certifications, regulatory approvals, domain expertise customers require (health, finance, legal) |
| **Proprietary evals & quality** | You can prove quality on the customer's real tasks better than anyone |
| **Network effects** | Each user makes the product better for others |
| **Brand & community** | Default choice in a niche |
| **Cost or speed advantage** | Own models or infrastructure that make you meaningfully cheaper or faster |
| **Switching costs** | Configuration, history, training and change management that make leaving painful |

"Our prompts" and "we were first" are not moats.

## Step 3: Strategy

- **Current moat**: strongest 1–2 sources today
- **Moat to build**: the 1–2 sources most achievable in 12 months given the product — and the roadmap items that build them
- **What to avoid**: features that model providers will commoditize soon

## Step 4: Investor-ready framing

Write the defensibility paragraph for a pitch deck — specific, evidence-based, no buzzwords — plus the metrics that prove it (e.g. accuracy improvement from customer data, % of workflow automated, integrations live, gross retention).

---

## Output Format

1. **Threat map** with likelihoods
2. **Moat scorecard**
3. **12-month moat strategy** with roadmap items
4. **Deck paragraph + proof metrics**
5. **Biggest risk** and the early warning sign to watch
