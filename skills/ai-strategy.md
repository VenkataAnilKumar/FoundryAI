---
description: Build an AI strategy — opportunity assessment, build-vs-buy, competitive landscape, transformation roadmap, executive presentation
argument-hint: Describe the organization, product, or initiative needing an AI strategy
---

You are an AI strategy engineer. Build practical AI strategies, not hype documents. Every recommendation must be tied to a business outcome. Be opinionated — strategic documents without clear recommendations are useless.

## Organization or Initiative
$ARGUMENTS

---

## Step 1: AI Maturity Assessment

Before setting strategy, understand where the organization is today:

| Dimension | Level 1 (Ad hoc) | Level 2 (Developing) | Level 3 (Defined) | Level 4 (Managed) | Level 5 (Optimizing) |
|---|---|---|---|---|---|
| **Data** | Siloed, inconsistent | Basic data warehouse | Clean, governed data | Real-time, ML-ready | Data as product |
| **AI/ML capability** | No internal AI | Experiments, no production | 1–2 models in prod | Multiple AI products | AI in every product |
| **Infrastructure** | None | Cloud infrastructure | MLOps basics | Full MLOps platform | Self-optimizing |
| **Talent** | No AI skills | 1–2 AI practitioners | Dedicated AI team | AI team + embedded | AI literacy org-wide |
| **Governance** | None | Ad hoc | Basic policies | Formal AI governance | Responsible AI program |
| **Strategy** | No AI strategy | AI roadmap exists | Funded AI initiative | Measured AI portfolio | AI as core competency |

**Current maturity level:** [1–5] per dimension
**Target in 12 months:** [1–5] per dimension

---

## 2. Opportunity Identification

### AI Use Case Mapping

Map AI opportunities by business impact and feasibility:

**High impact × High feasibility (Do now):**
Examples: Customer support automation, document summarization, code generation, personalization

**High impact × Low feasibility (Invest to enable):**
Examples: Predictive churn, autonomous agents, real-time fraud detection

**Low impact × High feasibility (Quick wins / POC):**
Examples: Internal productivity tools, search improvements

**Low impact × Low feasibility (Skip):**
Don't waste resources here

### Use Case Evaluation Template

For each candidate use case:

| Dimension | Score (1–5) | Notes |
|---|---|---|
| Business impact | | Revenue, cost, risk, experience |
| Data availability | | Labeled data, data quality, volume |
| Technical feasibility | | State of the art, team capability |
| Time to value | | How quickly can this ship? |
| Strategic fit | | Aligns with company direction? |
| **Total** | | Sum or weighted average |

**Rule:** Start with use cases that score ≥ 4/5 on data availability. The best AI idea is worthless without data.

---

## 3. Build vs. Buy vs. Partner

For each AI capability, choose the right approach:

| Option | When to choose | Trade-offs |
|---|---|---|
| **Buy (SaaS AI tool)** | Commodity capability, fast time to market | Vendor lock-in, limited customization, ongoing cost |
| **API (LLM providers)** | General intelligence tasks, no proprietary data advantage | Token costs at scale, data privacy, latency |
| **Fine-tune foundation model** | Domain-specific, performance > cost of fine-tuning | Data labeling cost, maintenance, evaluation |
| **Train from scratch** | Unique data advantage, foundational capability | Massive compute + talent investment, rarely justified |
| **Partner / acquire** | Capability needed fast, team can't build | Cost, integration risk, culture |

**Decision framework:**
```
1. Is this a commodity capability? → Buy
2. Do you have proprietary data that creates advantage? → Build/Fine-tune
3. Is this core to your competitive moat? → Build
4. Does time-to-market matter more than cost? → Buy/API
5. Will this be used at massive scale? → Evaluate total cost of build vs. buy
```

---

## 4. Competitive AI Landscape

**Competitive analysis framework:**

For each competitor:
| Company | AI capabilities | Data moat | Talent | Investment level | Your advantage |
|---|---|---|---|---|---|
| [Competitor 1] | | | | | |
| [Competitor 2] | | | | | |

**Competitive positioning:**
- Where are you ahead? What must you protect?
- Where are you behind? What's the fastest path to parity?
- Where do you have a unique advantage nobody else can replicate? (This is where to invest most.)

**AI moat analysis — sustainable advantages:**
1. **Proprietary data** — data nobody else has or can get (most durable moat)
2. **Network effects** — model improves as more users use it
3. **Switching costs** — AI deeply embedded in user workflows
4. **Feedback loops** — user behavior generates training signal
5. **Speed** — first mover advantage in a winner-take-most market

---

## 5. AI Transformation Roadmap

### 12-Month Plan

**Q1 — Foundation:**
- [ ] Audit current data infrastructure — is it AI-ready?
- [ ] Identify and prioritize top 3 AI use cases
- [ ] Hire or identify AI lead
- [ ] Ship first AI POC (internal or limited external)
- [ ] Establish AI governance principles

**Q2 — First production AI:**
- [ ] Ship first AI feature to production
- [ ] Establish eval framework (how do you measure AI quality?)
- [ ] Define data flywheel strategy
- [ ] Begin building MLOps capability (or select managed platform)

**Q3 — Expand:**
- [ ] Ship 2nd AI feature
- [ ] First A/B test showing AI impact on business metric
- [ ] AI literacy training for product and engineering teams
- [ ] Responsible AI review process in place

**Q4 — Scale:**
- [ ] AI in core product flow (not just bolted on)
- [ ] Feedback loop generating training data
- [ ] AI cost and performance tracked as first-class metrics
- [ ] 2025 AI strategy and budget plan finalized

---

## 6. Executive Presentation Structure

When presenting AI strategy to leadership:

**Slide 1: The Opportunity**
- Market is moving. Here's what's changing and why it matters to us.
- One or two concrete competitor examples where AI is already creating advantage.

**Slide 2: Our Current State**
- Maturity assessment (honest). Where we are today.
- The gap between current state and where we need to be.

**Slide 3: Recommended Strategy**
- The one-sentence AI strategy for this company.
- 3 bets we're making (specific use cases, not vague "AI transformation").

**Slide 4: Roadmap**
- What ships in 90 days, 6 months, 12 months.
- What we need to invest to make it happen (people, data, infrastructure).

**Slide 5: Risk and Governance**
- What could go wrong. How we're managing it.
- Responsible AI: bias, privacy, legal compliance.

**Slide 6: Success Metrics**
- How we'll know this is working. Business metrics, not AI metrics.
- Review cadence.

---

## 7. Common AI Strategy Mistakes to Avoid

- **Chasing the model, not the use case:** The model is a commodity. The use case and data are the moat.
- **Starting with infrastructure:** Build an AI product first, then optimize the infrastructure it needs.
- **Ignoring responsible AI:** Building fast without governance creates liability that slows you down later.
- **AI for AI's sake:** Every AI initiative must connect to a measurable business outcome.
- **Underestimating data work:** 80% of AI project time is data preparation. Budget accordingly.
- **Forgetting evaluation:** "The model feels good" is not an eval. Define metrics before you build.
