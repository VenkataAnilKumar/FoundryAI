---
description: Build a growth strategy — acquisition funnels, retention levers, viral loops, content, and experimentation roadmap
argument-hint: Describe the product, current stage, and growth challenge
---

You are a growth engineer and strategist. Be specific — "post on LinkedIn" is not a growth strategy. Identify the highest-leverage lever for this product at this stage, then build a system around it.

## Product and Growth Challenge
$ARGUMENTS

---

## Step 1: Growth Diagnosis

Before recommending tactics, diagnose the problem:

**What stage is this product in?**
- [ ] **Pre-PMF** — Fewer than 100 active users, unclear if product solves a real problem
  → Focus: discovery and learning, not growth. Talk to users. Don't optimize a funnel that doesn't work yet.
- [ ] **Post-PMF, pre-scale** — Clear retention, natural word of mouth, ready to accelerate
  → Focus: identify and double-down on the acquisition channel already working
- [ ] **Scale** — Clear PMF, need to 10x growth systematically
  → Focus: channel diversification, paid acquisition, virality, partnerships

**Current baseline:**
| Metric | Value |
|---|---|
| MAU / DAU | |
| D30 retention | |
| NPS or qualitative signal | |
| Primary acquisition channel | |
| CAC (if known) | |
| LTV (if known) | |

**The one constraint:** What is the single biggest barrier to growth right now?
- [ ] Awareness — people don't know it exists
- [ ] Conversion — people visit but don't sign up
- [ ] Activation — people sign up but don't experience value
- [ ] Retention — people use it once and never return
- [ ] Monetization — users love it but won't pay
- [ ] Virality — no natural sharing or referral mechanism

---

## 2. Acquisition Strategy

### Channel Selection

Evaluate each channel against: **Reach × Relevance × CAC × Scalability**

| Channel | Fits product? | CAC estimate | Time to results | Scalable? |
|---|---|---|---|---|
| SEO / content | | | 3–12 months | High |
| Paid search (SEM) | | | Days | High (if unit econ works) |
| Paid social | | | Days | Medium |
| Product-led growth (PLG) | | | Weeks | Very high |
| Developer community (HN, Reddit, GitHub) | | | Days–weeks | Medium |
| Partnerships / integrations | | | Months | High |
| Influencer / creator | | | Weeks | Low–medium |
| Outbound sales (B2B) | | | Weeks | Medium |
| App stores (mobile) | | | Months | High (if ranked) |
| Events / conferences | | | Months | Low |

**Channel prioritization rule:** Pick the 1–2 channels most likely to reach your ICP. Nail them before diversifying.

### SEO / Content Strategy (if applicable)

**Keyword research framework:**
1. **Bottom-of-funnel** (highest intent): "[product category] software", "[competitor] alternative" → Convert now
2. **Middle-of-funnel**: "how to [solve the problem]" → Educate and capture email
3. **Top-of-funnel**: "[broad topic] guide" → Build authority and backlinks

**Content types by goal:**
| Goal | Content type | Distribution |
|---|---|---|
| Capture demand | Landing pages, comparison pages, use-case pages | SEO |
| Build authority | Long-form guides, original research, tools | SEO + outreach |
| Generate backlinks | Data studies, free tools, interactive calculators | PR + community |
| Retain and activate | Documentation, tutorials, videos | Product + email |

---

## 3. Activation Optimization

**The activation moment:** Define the specific action that separates users who retain from those who churn.

Examples:
- Slack: invite ≥ 3 teammates
- Dropbox: upload first file
- Figma: share a design with a collaborator
- GitHub Copilot: accept first AI suggestion

**Activation funnel:**
```
Signup → [Step 1] → [Step 2] → [Activation moment] → Habit loop
```

For each step, measure:
- Completion rate
- Time to complete
- Drop-off reason (exit survey, session replay)

**Activation optimization tactics:**
- Reduce time to first value (remove friction in onboarding)
- Progressive disclosure (don't show all features upfront)
- Personalized onboarding (route to relevant use case based on signup data)
- In-product coaching (tooltips, checklists, empty states with clear CTAs)
- Email/SMS drip triggered by inaction (day 1, day 3, day 7 if not activated)

---

## 4. Retention Strategy

**Retention curve analysis:**
- Plot retention cohort chart (week 0 vs week 1, 2, 4, 8, 12)
- If curve flattens above 0% = product has a retained core → optimize to grow the floor
- If curve trends to 0% = fundamental product/fit problem → no growth tactics will help

**Retention levers by product type:**

| Mechanism | How it works | Example |
|---|---|---|
| **Habit formation** | Build product into daily routine | Daily email digest, morning briefing |
| **Network effects** | Value increases with more users | Collaboration features, shared workspaces |
| **Data flywheel** | Product gets smarter with more use | Personalization, memory, learning |
| **Switching cost** | Accumulated data/integrations | Import history, integrations, team norms |
| **Notifications** | Re-engagement trigger | Push notifications, weekly summary emails |
| **Jobs to be done** | Become the default tool for a recurring job | Make the product the first thing opened for X |

---

## 5. Viral & Referral Loops

**Natural virality (best):** Does using the product share it with others?
- Collaboration invites (Figma, Notion, Linear)
- Powered-by branding (email footers, embedded widgets)
- Shareable outputs (social cards, exported reports)
- API integrations (if your product shows up in other tools)

**Incentivized referral:**
- Define the referral offer: what do you give the referrer and the referee?
- Unit economics check: Referral reward < (LTV × referral conversion rate)
- Tools: ReferralHero, Viral Loops, or custom-built

**Viral coefficient (K-factor):**
```
K = invites sent per user × conversion rate of invite
K > 1 = exponential growth
K = 0.5–1 = meaningful boost but not self-sustaining
K < 0.5 = adds some growth but not a primary driver
```

---

## 6. Growth Experimentation Roadmap

Prioritize experiments using ICE score: **Impact × Confidence × Ease (each 1–10)**

| Experiment | Hypothesis | ICE score | Owner | Duration |
|---|---|---|---|---|
| | | | | |

**Experiment template:**
```
Name: [descriptive name]
Hypothesis: If we [change], [metric] will [improve] because [reason]
Primary metric: [one metric]
Sample size needed: [calculated]
Duration: [days]
Result: [after running]
Decision: Ship / Iterate / Kill
```

**Growth meeting cadence:**
- Weekly: review active experiments, ship wins, kill losers
- Monthly: channel performance review, new experiment backlog prioritization
- Quarterly: growth model update, channel mix review
