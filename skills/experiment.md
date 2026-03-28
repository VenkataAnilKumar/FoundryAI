---
description: Design experiments — A/B tests, statistical analysis, ML model evaluation, research benchmarking
argument-hint: Describe the hypothesis, model, or behavior you want to test
---

You are a data scientist and research engineer. Design rigorous experiments. State hypotheses precisely, choose the right statistical method, and define what "done" looks like before collecting a single data point.

## What to Experiment On
$ARGUMENTS

---

## Experiment Type

Identify which type of experiment this is:

| Type | When to use |
|---|---|
| **A/B test** | User-facing change with a control group; random assignment |
| **Multi-armed bandit** | Exploration/exploitation tradeoff; maximize reward in production |
| **Pre/post analysis** | No control group; compare before vs. after a change |
| **Holdout test** | Withhold a feature from a group; measure long-term impact |
| **ML model evaluation** | Compare model versions on an offline or online benchmark |
| **Research experiment** | Implement paper, test novel technique, benchmark against baseline |

---

## Step 1: Hypothesis

State the hypothesis precisely:

```
If we [intervention/change/model],
then [metric] will [increase/decrease] by [magnitude],
because [causal mechanism — not just correlation].
```

**Null hypothesis (H₀):** The intervention has no effect.
**Alternative hypothesis (H₁):** The intervention changes [metric] by at least [minimum detectable effect].

**Causal chain:** What mechanism connects the intervention to the metric?
(Weak experiments skip this. Strong experiments can point to why it worked or didn't.)

---

## Step 2: Metrics

**Primary metric:** The one number that decides if the experiment succeeded.
- Must be measurable before the experiment ends
- Must be directly affected by the intervention
- One metric only — if you need two, you have two experiments

**Secondary metrics:** Supporting signals (don't use to declare winner, use to understand why)

**Guard metrics:** Must not degrade. If any guard metric is violated, the experiment fails regardless of the primary.

| Metric | Type | Baseline | Expected Direction | Minimum Detectable Effect |
|---|---|---|---|---|
| [Primary] | primary | | ↑ / ↓ | ≥ X% |
| [Secondary 1] | secondary | | ↑ / ↓ | — |
| [Guard 1] | guard | | must not ↓ | — |

---

## Step 3: Statistical Design

**Significance level (α):** 0.05 (standard) — or justify a different threshold.
**Statistical power (1-β):** 0.80 (standard — means 20% chance of missing a real effect).
**Test type:**
- [ ] Two-tailed (effect could go either way)
- [ ] One-tailed (you only care if it improves — use only when you'd ship the change even with no effect)

**Sample size calculation:**
```
Required n per variant = f(α, power, baseline_rate, MDE)
Use: statsig.com/calculator or scipy.stats.power analysis
```

**Expected duration:** `n_required / (daily_eligible_users / num_variants)`
Minimum: 1 full week to capture weekly seasonality. Never stop early.

**Randomization unit:**
- [ ] User (most common — consistent experience per user)
- [ ] Session (risky — same user gets different experiences)
- [ ] Request (appropriate for non-personalized API features)
- [ ] Device (for mobile-specific experiments)

**Variance reduction technique (optional but recommended):**
- CUPED (Controlled-experiment Using Pre-Experiment Data) reduces variance by 20–40%
- Stratified sampling ensures balanced variant assignment on key dimensions

---

## Step 4: For ML Model Experiments

### Offline Evaluation

**Benchmark dataset:**
- Source: [where the data comes from]
- Size: [number of samples]
- Split: [train / validation / test — never touch test until final eval]
- Distribution: [does it represent production traffic?]

**Metrics by task type:**

| Task | Primary Metric | Secondary |
|---|---|---|
| Classification | F1, AUC-ROC | Precision, Recall by class |
| Regression | RMSE, MAE | R², error distribution |
| Ranking | NDCG@K, MRR | Precision@K |
| Generation (LLM) | Task-specific (ROUGE, BERTScore, human eval) | Latency, token cost |
| Retrieval (RAG) | Context precision, recall, faithfulness | Answer relevance |

**Baseline:** Always compare against the simplest reasonable baseline (majority class, previous model, rule-based system). If you can't beat the baseline, the model isn't ready.

### Online Evaluation (Shadowing / Canary)

1. **Shadow mode:** New model runs in parallel, results logged but not served. Compare offline.
2. **Canary:** Route 1–5% of traffic to new model. Monitor production metrics for 24–48h.
3. **Ramp:** Gradually increase traffic (5% → 25% → 50% → 100%) with go/no-go checkpoints.

**Rollback trigger:** Define the exact condition that causes immediate rollback:
- Primary metric degrades by > X%
- Error rate exceeds Y%
- P99 latency exceeds Z ms

---

## Step 5: For Research Experiments

**Baseline:** Which prior work are you comparing against?
- Paper citation: [arxiv ID or DOI]
- Reproduced result: [their reported number on their dataset]
- Your reproduced baseline: [your result on the same setup — must match before experimenting]

**Ablation plan:** Test one variable at a time.
| Variant | What changes | What stays the same |
|---|---|---|
| Baseline | — | — |
| + [Component A] | Add component A | Everything else |
| + [Component B] | Add component B | Everything else |
| Full model | A + B + C | — |

**Compute budget:** How many GPU hours / API tokens / dollars is this experiment allowed to use?

---

## Step 6: Results Analysis

**When to stop:**
- [ ] Reached pre-specified sample size (never stop early for significance)
- [ ] Reached pre-specified time window
- [ ] Reached compute budget (research)

**Decision matrix:**

| Primary metric | Guard metrics | Decision |
|---|---|---|
| Significant improvement | All pass | Ship |
| Significant improvement | Any fail | Iterate — investigate guard metric |
| No significant effect | All pass | Do not ship — insufficient evidence |
| Significant degradation | Any | Do not ship |

**Reporting template:**
```
Experiment: [name]
Duration: [dates]
Sample: [n per variant]

Primary metric: [metric]
  Control: [value ± CI]
  Treatment: [value ± CI]
  Relative lift: [%]
  p-value: [value]
  Significant: Yes / No

Guard metrics: All pass / [which failed]

Conclusion: [Ship / Do not ship / Inconclusive]
Next step: [follow-on experiment or rollout plan]
```
