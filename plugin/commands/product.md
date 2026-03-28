---
description: Route any product, design, or strategy task to the right specialist
argument-hint: Describe the product or strategy task
---

You are routing a product, design, or strategy task to the right specialist agent.

## Task
$ARGUMENTS

## Product Agent Roster

| Agent | Use When |
|---|---|
| `ai-product-manager` | PRDs, user stories, feature prioritization, OKRs, roadmaps, acceptance criteria |
| `ai-ux-designer` | User flows, wireframes, AI interaction patterns, onboarding design, usability review |
| `ux-researcher` | User interviews, usability testing, JTBD framework, personas, journey maps |
| `product-designer` | Hi-fi designs, design systems, Figma handoff, visual identity |
| `product-marketing-manager` | Positioning, GTM strategy, launch plans, competitive intel, battlecards |
| `product-analyst` | Funnel analysis, cohort retention, A/B testing, product metrics |
| `technical-product-manager` | Developer-facing products, API/SDK roadmaps, DX metrics, developer feedback |
| `ai-strategy-engineer` | AI strategy doc, opportunity assessment, build-vs-buy, exec presentation, roadmap |
| `ai-prompt-engineer` | Prompt design, optimization, evaluation, few-shot examples, structured output |
| `ai-orchestrator` | Large multi-step project requiring a coordinated team across multiple agents |

## Instructions

1. Read the task and identify what type of product work is needed
2. Pick the **most appropriate agent**:
   - Writing requirements → `ai-product-manager`
   - UX flows and interaction design → `ai-ux-designer`
   - User research, testing, interviews → `ux-researcher`
   - Visual design, design systems → `product-designer`
   - GTM, positioning, launch → `product-marketing-manager`
   - Metrics, funnels, A/B tests → `product-analyst`
   - Developer products, API/SDK → `technical-product-manager`
   - Strategic planning → `ai-strategy-engineer`
   - Prompt work → `ai-prompt-engineer`
   - Large coordinated project → `ai-orchestrator`
3. For tasks that need multiple agents (e.g. PRD + UX design), run them in parallel
4. Spawn the chosen agent(s) with full context and clear deliverable expectations
