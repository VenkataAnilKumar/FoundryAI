# FoundryAI Demo Script

A step-by-step script for recording the demo GIF. Aim for 60–90 seconds total.

---

## Setup Before Recording

1. Open terminal in a clean project folder (e.g. `~/demo-project`)
2. Have Claude Code open and ready
3. Font size: 18–20px for readability in GIF
4. Terminal width: 120 columns
5. Use a dark theme (Dracula, One Dark, or Tokyo Night)
6. Clear all previous Claude Code context

**Tool:** Use [Terminalizer](https://github.com/faressoft/terminalizer) or [Gifox](https://gifox.io/) (Mac) or [ScreenToGif](https://www.screentogif.com/) (Windows) to record.

---

## Scene 1 — The Hook (0–10s)

**What to show:** The problem. Switching between tools is slow.

Type slowly into terminal:
```
# You're building an AI product.
# Normally you'd need: ChatGPT for strategy,
# GitHub Copilot for code, another tool for docs...
#
# With FoundryAI — one command does it all.
```

Pause 2 seconds.

---

## Scene 2 — Install (10–20s)

**What to show:** One-line install.

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

Show the output:
```
✓ Installing 38 agents...
✓ Installing 25 skills...
✓ Installing founders-kit plugin...
✓ Done. Your AI team is ready.
```

---

## Scene 3 — The Founder Agent (20–45s)

**What to show:** One prompt → multi-agent team kicks off.

Open Claude Code (`claude`) and type:

```
Use the founder agent to build me a RAG-powered document search feature.
Include architecture, implementation plan, and cost estimate.
```

**What Claude Code should show:**
- `founder` agent activating
- Routing to `ai-architect` → system design
- Routing to `ai-engineer` → RAG implementation plan
- Routing to `ai-finance-engineer` → cost estimate
- Final synthesized output with all three sections

> **Tip:** Run this for real before recording so you know the output. Then record the real run.

---

## Scene 4 — A Slash Command (45–60s)

**What to show:** Instant skill — the `/review` command.

In Claude Code, type:

```
/review
```

Point at an existing file in the project. Show the output:
```
## Code Review

**CRITICAL** — None
**HIGH** — Input not sanitized before passing to LLM (prompt injection risk)
**MEDIUM** — No retry logic on API timeout
**LOW** — Missing docstring on generate_response()

Overall: Solid structure. Fix the HIGH before shipping.
```

---

## Scene 5 — The Close (60–75s)

**What to show:** The full roster and call to action.

Type into terminal or show a text card:

```
38 agents. 25 skills. Zero context switching.

github.com/VenkataAnilKumar/FoundryAI
```

Pause 3 seconds on the GitHub URL.

---

## Recording Tips

- **Slow down typing** — 40–50 WPM looks natural on screen
- **Pause after each output** — give viewers 1–2s to read results
- **Cut loading time** — if install takes 10s, speed up that section 3×
- **No mouse clicks** — keyboard only looks cleaner
- **Trim aggressively** — 60s is better than 90s

---

## Post-Processing

1. Export at 1080p minimum
2. Optimize GIF: use [ezgif.com](https://ezgif.com/optimize) or `gifsicle --optimize=3`
3. Target file size: under 5MB for GitHub README embedding
4. Embed in README:

```markdown
![FoundryAI Demo](demo.gif)
```

---

## Quick Version (30s GIF for Twitter/X)

Just Scene 3 only — the founder agent routing to multiple specialists.
That single moment is the most impressive and tells the whole story.
