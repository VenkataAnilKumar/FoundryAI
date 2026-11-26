# AGENTS.md — Generative Media Product

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

---

## Project Overview

**Type**: Generative media (images / video / audio / 3D)
**Stage**: [Idea / MVP / Early customers / PMF / Scale]
**AI startup type**: generative media
**Team size**: [e.g. 2 founders, 1 engineer]
**Media**: [images / video / music / voice / 3D]
**Users**: [consumers / creators / businesses]

---

## Tech Stack

```
Models:       [hosted generation APIs] and/or [open-weight models — check commercial license]
Pipelines:    [ComfyUI workflows / Diffusers] versioned like code
Fine-tuning:  LoRA / subject and style training for consistency
Serving:      GPU workers behind a priority queue; autoscale on queue depth
Safety:       input/output moderation, likeness/IP filters, C2PA content credentials
App:          [Next.js / mobile] with credits, history and generation status
```

---

## Agent Routing

- Generation pipelines, fine-tuning, GPU serving, safety → `ai-generative-media-engineer`
- Hosted API vs self-hosted open model → `/model-strategy`
- Credits and plans vs GPU cost → `ai-finance-engineer` + `/ai-pricing`
- Editor and gallery UI → `ai-frontend-engineer` / `ai-mobile-engineer`
- Content policy, likeness, deepfake and minors safety → `ai-responsible-engineer` + `ai-legal-engineer`
- Training-data and license questions → `/data-rights`
- Everything else → `/cofounder "describe task"`

---

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | Hosted APIs, one narrow use case, moderation from day one | Unlimited free generations |
| Traction | Fine-tuning for consistency, abuse controls, cost per generation per tier | Growing before likeness/IP policy exists |
| Scale | Self-host open models where licenses allow, GPU capacity planning, provenance by default | Building on a model whose license blocks your revenue level |

## Key Metrics

- Cost per generation (and per second of video) vs revenue per credit
- Generation success rate (no retries) and time to result
- User preference win rate on regression prompts
- Moderation precision/recall; abuse reports and takedown time
- Free-to-paid conversion; credits used per paying user

---

## Conventions

```
- Every model has a recorded license and commercial-use check in /models/LICENSES.md
- Every generation stores prompt, model/pipeline version, seed, and moderation results
- Moderation runs on inputs and outputs; blocked categories are configurable per market
- No generation of real people without verified consent; no sexual content involving minors, ever
- Content credentials (C2PA) attached to outputs where supported
- Free tier limited by credits and rate limits; queue priority for paid users
```

## Directory Structure

```
pipelines/           ← versioned generation workflows
training/            ← LoRA / style training jobs and datasets
workers/             ← GPU workers and queue consumers
safety/              ← moderation, likeness and IP filters, provenance
evals/prompts/       ← regression prompt set
app/                 ← product UI, credits, history
```

## Useful Skills

`/model-strategy` · `/ai-pricing` · `/data-rights` · `/cost-check` · `/responsible-ai` · `/moat`
