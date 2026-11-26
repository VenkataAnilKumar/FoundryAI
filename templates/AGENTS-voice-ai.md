# AGENTS.md — Voice AI Product

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

---

## Project Overview

**Type**: Voice AI (real-time voice agent, phone bot, or voice interface)
**Stage**: [Idea / MVP / Early customers / PMF / Scale]
**AI startup type**: voice
**Team size**: [e.g. 2 founders, 1 engineer]
**Channel**: [phone (PSTN/SIP) / web (WebRTC) / mobile app / device]
**Languages**: [e.g. English, Spanish]

---

## Tech Stack

```
Orchestration:  [LiveKit Agents / Pipecat / hosted voice platform]
Transport:      [Twilio / Telnyx SIP] for phone, WebRTC for web/mobile
VAD / turns:    [Silero VAD + semantic end-of-turn detection]
STT:            [streaming STT provider]
LLM:            [fast model for conversation; larger model behind tools]
TTS:            [streaming TTS provider and voice]
Backend:        [FastAPI / Node] — tools, call state, CRM integrations
Storage:        call records, transcripts (PII-redacted), eval sets
```

---

## Agent Routing

- Voice pipeline, latency, turn-taking, telephony → `ai-voice-engineer`
- Tools the agent calls (booking, CRM, lookups) → `ai-backend-engineer`
- Conversation design, persona, scripts → `ai-ux-designer` + `content-designer`
- Call evals and regression suites → `ai-qa-engineer`
- Recording consent, AI disclosure, PCI/PII → `ai-legal-engineer` + `ai-security-engineer`
- Cost per minute and pricing → `ai-finance-engineer` (+ `/ai-pricing`)
- Everything else → `/cofounder "describe task"`

---

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | One call type, hosted components, human handoff, measure 50 real calls | Custom models, many languages at once |
| Early customers | Eval set from recorded calls (with consent), latency SLOs, cost per minute | Optimizing the voice before fixing task completion |
| Scale | Regional deployment, negotiated per-minute rates, custom vocabulary and voices | Single-provider dependency for STT/TTS |

## Key Metrics

- Voice-to-voice latency per turn (p50/p95; target under ~1 s)
- Task completion / containment rate; transfer-to-human rate
- Interruptions handled correctly; talk-over incidents
- Word error rate on your own call audio
- Cost per minute (STT + LLM + TTS + telephony) and gross margin per minute

---

## Conventions

```
- Stream everything: partial transcripts, LLM tokens, sentence-chunked TTS
- Barge-in stops TTS immediately; assistant context is truncated to what the caller heard
- Every call announces recording/AI use where required; consent stored with the call
- Card numbers and sensitive data captured via DTMF or paused recording, never in transcripts
- Latency budget per stage tracked on every release
- Prompts and tool definitions versioned; evals run on every change
```

## Directory Structure

```
voice/
  pipeline.py        ← transport, VAD, STT, LLM, TTS wiring
  turn_taking.py     ← end-of-turn and barge-in logic
  prompts/           ← persona and task prompts, versioned
tools/               ← booking, CRM, lookup integrations
evals/
  calls/             ← recorded call fixtures (consented, redacted)
  scenarios/         ← scripted test conversations
telephony/           ← numbers, SIP, transfer and voicemail handling
```

## Useful Skills

`/eval` · `/cost-check` · `/performance` · `/model-strategy` · `/compliance` · `/ai-pricing`
