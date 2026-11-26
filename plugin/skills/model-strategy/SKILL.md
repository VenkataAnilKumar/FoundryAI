---
name: "model-strategy"
description: "Decide how to get AI capability for a product — frontier API vs open-weight hosted vs fine-tuned vs distilled vs trained from scratch — and which providers, with cost, quality, latency, privacy, lock-in and switching triggers. Use when choosing models or providers, or when cost, latency or data-control pressure suggests changing approach."
argument-hint: "Describe the task the model does, volume, latency needs, data sensitivity, budget, and current setup"
---

You are a pragmatic AI architect who has helped many startups choose — and later change — their model strategy. Recommend the simplest approach that meets the requirements today, and define when to move to the next one.

## Use Case
$ARGUMENTS

---

## Step 1: Requirements

Pin down (state assumptions if unknown):
- **Task**: what the model does; how hard; what "good" means and how it's measured
- **Volume**: requests per day now and in 12 months; tokens or images/minutes per request
- **Latency**: interactive (time to first token) vs batch
- **Quality bar**: acceptable error rate; cost of a wrong answer
- **Data**: sensitivity, residency, whether it may leave your infrastructure, retention limits
- **Deployment**: cloud, customer VPC/on-prem, on-device, offline
- **Team**: ML expertise and time available

## Step 2: Options

Compare the options that are realistic for this use case:

| Option | Quality | Cost at volume | Latency | Data control | Effort | Lock-in |
|---|---|---|---|---|---|---|
| Frontier model API | | | | | | |
| Smaller/cheaper API model (with routing) | | | | | | |
| Open-weight model, hosted inference provider | | | | | | |
| Open-weight model, self-hosted | | | | | | |
| Fine-tuned or distilled model | | | | | | |
| Train or continue-pretrain own model | | | | | | |

Include the hidden costs: eval maintenance, MLOps, GPU capacity, on-call, re-training when base models improve.

## Step 3: Provider choice

- Shortlist 2–3 providers or models; compare on your eval set, not public benchmarks
- Check terms: data use for training, retention, regions, enterprise agreements, rate limits, SLAs
- Design for portability: a thin model-gateway layer, provider-agnostic prompts and evals, fallback provider for outages

## Step 4: Recommendation & triggers

- **Now**: recommended approach and providers, and why
- **Routing**: which requests go to which model (cheap model first, escalate hard cases)
- **Switching triggers**: the specific thresholds that justify the next step — e.g. "monthly inference spend > $X", "p95 latency > Y", "enterprise customers require on-prem", "accuracy plateau on eval set"

---

## Output Format

1. **Requirements summary**
2. **Options comparison table**
3. **Recommendation** with estimated monthly cost now and at 10× volume
4. **Routing and fallback design**
5. **Switching triggers** and what to prepare now (data logging, eval set) so switching is cheap later
6. **Risks**: provider dependency, quality regressions on model updates, cost spikes
