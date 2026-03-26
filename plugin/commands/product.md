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
| `ai-product-builder` | Rapid prototype, working demo, MVP end-to-end, fast shipping |
| `ai-ux-designer` | UX research, user flows, wireframes, AI interaction patterns, usability review |
| `ai-solution-architect` | Client-facing solution design, RFP response, PoC architecture, integration blueprint |
| `ai-strategy-engineer` | AI strategy doc, opportunity assessment, build-vs-buy, exec presentation, roadmap |
| `ai-prompt-engineer` | Prompt design, optimization, evaluation, few-shot examples, structured output |
| `ai-orchestrator` | Large multi-step project requiring a coordinated team across multiple agents |

## Instructions

1. Read the task and identify what type of product work is needed
2. Pick the **most appropriate agent**:
   - Writing requirements → `ai-product-manager`
   - Building something fast → `ai-product-builder`
   - Designing experience → `ai-ux-designer`
   - Strategic planning → `ai-strategy-engineer`
   - Client solution → `ai-solution-architect`
   - Prompt work → `ai-prompt-engineer`
   - Large coordinated project → `ai-orchestrator`
3. For tasks that need multiple agents (e.g. PRD + UX design), run them in parallel
4. Spawn the chosen agent(s) with full context and clear deliverable expectations
