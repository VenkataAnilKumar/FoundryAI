# Launch Kit

Everything needed to put FoundryAI in front of developers and founders. Copy is ready to paste. Adapt it to your own voice, because posts that sound like a person do better than posts that sound like a press release.

**Assets**

| Asset | File | Use |
|---|---|---|
| Real demo (GIF) | [`assets/demo.gif`](../assets/demo.gif) | README, Reddit, dev.to, X |
| Real demo (MP4, 39 s) | [`assets/demo.mp4`](../assets/demo.mp4) | X, LinkedIn, Product Hunt |
| Social preview (1280×640) | [`assets/social-preview.png`](../assets/social-preview.png) | GitHub repo preview, link cards |
| Landing page | [`site/index.html`](../site/index.html) | `https://venkataanilkumar.github.io/FoundryAI/` once Pages is on |

---

## 1. One-time setup (≈15 minutes, on GitHub)

- [ ] **Turn on the landing page:** Settings → Pages → Source: **GitHub Actions**. Then run the `pages` workflow, or push any change under `site/`.
- [ ] **Social preview:** Settings → General → Social preview → upload `assets/social-preview.png`. This is the image shown on X, LinkedIn, Slack and Discord when the repo link is shared.
- [ ] **About box:** set the description and website, then add topics:
  - Description: *The AI startup team for any AI workspace. 58 agents and 54 skills for Claude Code, Cursor, Copilot, Codex and Gemini CLI.*
  - Website: the Pages URL
  - Topics: `ai-agents` `claude-code` `cursor` `github-copilot` `codex` `gemini-cli` `agent-skills` `agents-md` `subagents` `prompt-engineering` `llm` `startup` `founders` `developer-tools`
- [ ] **Release:** tag `v3.4.0` and publish a GitHub Release with the CHANGELOG entry and the demo GIF. Releases notify everyone watching the repo.
- [ ] **Discussions:** enable them, and pin a "Show us what you built" thread plus a "Request an agent" thread.
- [ ] **Good first issues:** open 5–10 small issues, such as a new template for a stack, a new skill, or translating the README. Contributors become your loudest promoters.

---

## 2. Where to post

Space posts over 1–2 weeks rather than one day. Post when you can reply to comments for the next 2–3 hours, because early replies decide how far a post travels.

### Hacker News: Show HN
**Title:** `Show HN: FoundryAI – an AI startup team (58 agents) for Claude Code, Cursor, Codex`

**Text:**
> I kept rewriting the same prompts for architecture reviews, eval plans, pricing and investor updates, in a different AI tool every month. FoundryAI packages that work as 58 specialist agents and 54 skills, written once and built into each tool's native format: Claude Code, Cursor, Copilot, Codex, Gemini CLI, or plain prompts for ChatGPT projects.
>
> Two things I cared about:
> 1. **Stage-aware advice.** Every agent first asks what kind of AI startup you are and what stage you're at, so a 2-person team doesn't get told to adopt Kubernetes. The demo in the README is a real, unedited run: a voice-AI startup asks why calls are slow and expensive, and gets a day-by-day plan, including what *not* to do yet.
> 2. **It's just files.** No account, no telemetry. The agents and skills are Markdown; one Python script builds the per-tool formats, and CI checks every build.
>
> MIT licensed. I'd love feedback on which agents are useless and which are missing.

Rules: no voting rings and no asking friends to upvote, because HN detects it and buries the post. Reply to every comment, especially the critical ones.

### Reddit
Read each subreddit's self-promotion rules first, lead with something useful, and post as yourself.

- **r/ClaudeAI, r/ClaudeCode:** *"I built 58 Claude Code subagents for AI startups. Here's a real run fixing a voice agent's latency"* + GIF
- **r/cursor:** *"Cursor subagents + Agent Skills for startup work (architecture, evals, pricing, fundraising)"*
- **r/ChatGPTCoding, r/LocalLLaMA:** focus on the multi-tool build and the open Agent Skills standard
- **r/SaaS, r/startups, r/Entrepreneur:** focus on the founder side (`/pitch-deck`, `/pmf-check`, `/ai-pricing`) and less on the tooling

### X / Twitter thread
1. I turned the work of an AI startup team into 58 agents + 54 skills that run inside Claude Code, Cursor, Copilot, Codex and Gemini CLI. Free, open source. Here's a real run 👇 [demo.mp4]
2. A 2-person voice AI startup asks: "calls take 2.5s and cost $0.40/min, what do we do this week?" The founder agent gives a day-by-day plan, does the margin math, and says what NOT to do yet.
3. That last part is the point. Every agent works out your startup type + stage first. No Kubernetes before product-market fit.
4. One source, six formats: Claude Code subagents, Cursor agents, Copilot `.agent.md`, Codex TOML, Gemini agents, and paste-ready prompts for ChatGPT/Claude projects. Skills use the open Agent Skills standard.
5. Engineering *and* business: `/rag-design`, `/eval`, `/model-strategy` next to `/pitch-deck`, `/pmf-check`, `/ai-pricing`, `/security-questionnaire`.
6. Install in one line → [repo link]. Tell me which agent you'd add next.

Tag the tools' official accounts only where the post is genuinely about their feature (for example Agent Skills or subagents). Don't spam-mention.

### LinkedIn
> Most AI startups can't hire an architect, a security lead, a pricing strategist and a fundraising advisor in year one. So I built them, as open-source AI agents that live inside the coding tools founders already use (Claude Code, Cursor, Copilot, Codex, Gemini).
>
> The part I'm proudest of: the advice adapts to your stage. In the demo, a 2-person voice AI startup gets a one-week plan to cut latency and cost, plus an explicit "not this week" list.
>
> Free and MIT licensed. Link in the comments. What would you want an AI co-founder to handle?

### Product Hunt
- **Name:** FoundryAI
- **Tagline (≤60 chars):** *An AI startup team for any AI coding workspace*
- **Description:** 58 specialist agents, 9 team coordinators and 54 skills for AI startups: architecture, evals, security, pricing, fundraising and more. Works in Claude Code, Cursor, Copilot, Codex, Gemini CLI and ChatGPT. Stage-aware, free and open source.
- **Gallery:** social preview, demo MP4, landing page "Pick your AI startup" screenshot, a workspace table screenshot
- **First comment:** why you built it, the real-run demo, what's next, and an ask for agent requests

### Articles (dev.to / Hashnode / Medium / your blog)
Ideas that teach something, and so get shared:
- *"One prompt file, six AI coding tools: how FoundryAI builds Claude, Cursor, Copilot, Codex and Gemini agents from a single source"*
- *"Stop letting AI tell your 2-person startup to use Kubernetes: stage-aware agents"*
- *"I asked an AI co-founder to fix our voice agent's latency. Here's the unedited answer."*

### Curated lists and directories
Search GitHub for "awesome claude code", "awesome cursor", "awesome agent skills", "awesome AI agents" and "awesome AGENTS.md", and open a short PR adding FoundryAI to the relevant section. Follow each list's contribution rules. Also submit to agent-skill and MCP/agent directories that accept community entries.

### Newsletters and communities
Send a short, personal note with the demo GIF to AI-engineering and indie-hacker newsletters, and share in relevant Discord/Slack communities' show-and-tell channels, where allowed.

---

## 3. Keep the momentum

- **Ship weekly:** a new agent, template or skill each week, announced with a short real-run clip (re-record with `scripts/demo/record.sh`).
- **Answer every issue within a day** in the first month.
- **Credit contributors** in release notes and on social.
- **Measure:** stars, unique visitors and referrers (Insights → Traffic), install-script fetches, issues and PRs from new people.

## A realistic note on stars

A million stars would put FoundryAI among the handful of most-starred repositories on GitHub. Aim for steady milestones instead (100 → 1,000 → 10,000), earned by a genuinely useful tool, a strong real demo, consistent shipping and showing up in the communities above. Never buy stars or use star-exchange schemes. They violate GitHub's terms, get repos penalized, and destroy trust with exactly the developers you want.
