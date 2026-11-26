# Changelog

All notable changes to Founders Kit. Versions follow the plugin version in `plugin/.claude-plugin/plugin.json`.

## [3.5.1] — 2026-11-26

### Changed
- **Landing page redesigned** around what FoundryAI actually does, replacing the generic template look:
  - **Hero:** the founder agent's real recorded answer, laid out as a Monday–Friday plan board, with a "not this week" strip.
  - **Look:** steel-grey palette with one molten-amber accent, a wide Archivo display face, monospace for agent and skill names, light and dark themes.
  - **Team directory:** filterable by team.
  - **By startup type:** a staffing plan for each AI startup type.
  - **Get started:** a three-step start plus the full workspace table.
- `site/data.js` holds the team and skill data. It's generated from the README by `scripts/gen-docs.py` and checked in CI, so the site can't drift from the real roster.
- **Social preview image** redrawn in the new identity.

## [3.5.0] — 2026-11-26

### Added
- **Real demo** replaces the animated SVG.
  - `assets/demo.gif` / `demo.mp4` / `demo.cast` record a genuine one-line install from GitHub, then a live, unedited answer from the `founder` agent in Claude Code.
  - The recording is reproducible with `scripts/demo/record.sh`. `scripts/demo/README.md` lists exactly what's adjusted: typing pace, a compressed wait, and Markdown rendering.
- **Landing page** (`site/index.html`), deployed to GitHub Pages by `.github/workflows/pages.yml`: real demo video, install command, an interactive "Pick your AI startup" guide, workspaces, FAQ.
- **Social preview image** (`assets/social-preview.png`) and Open Graph tags.
- **Launch kit** (`docs/launch.md`): one-time GitHub setup, ready-to-post copy for Hacker News, Reddit, X, LinkedIn and Product Hunt, article ideas, curated-list outreach, and how to keep momentum.
- Validator check that the landing page only names agents, skills and templates that exist.

### Removed
- `demo.svg` (the scripted animation) and `DEMO.md` (manual recording instructions), replaced by the real recording and `scripts/demo/`.

## [3.4.0] — 2026-11-26

### Changed
- **README rewritten for newcomers:**
  - Order: quick start (install → add `AGENTS.md` → first thing to try in each workspace), why FoundryAI, how it works, workspace table, team and skill overviews.
  - The full catalogs fold into collapsible groups.
  - New: examples by startup type and stage, FAQ (privacy, cost, no-subagent workspaces, plugin name, upgrading), CI badge.
  - Fixed: the `ml-engineer` and `ai-engineer` rows, `team-platform` membership, and duplicate `/prd` and `/spec` rows.
  - The file-structure section moved to CONTRIBUTING ("Repository Layout").
- **Workflow recipes merged into one file,** `templates/WORKFLOWS.md`: 23 recipes, all using agent IDs. Voice and fine-tuning recipes now use the new specialists, plus new fundraising-sprint and enterprise-deal-readiness recipes. `agents/WORKFLOWS.md` was removed.
- **Team coordinators and `founder`** gained a "How to Coordinate" process and an Output Format (plan, integrated result, decisions, open questions, next steps).
- **Demo image** shows current counts, workspaces, and stage-aware routing. Fixed result labels overlapping their values.

### Fixed
- **The one-line install never worked.** Every `curl … | bash` URL pointed at a `main` branch that doesn't exist; the default branch is `master`. The validator now checks these URLs.
- **MCP configs** no longer use the deprecated `@modelcontextprotocol/server-github` or the archived `server-postgres`:
  - GitHub now uses GitHub's official remote server.
  - Postgres uses the community `postgres-mcp` in restricted (read-only) mode.
  - Secrets come from environment variables instead of being pasted into the file.
  - New `docs/mcp.md` covers setup for every workspace, including VS Code's `servers` key.
- **Contributor templates** (`CONTRIBUTING.md` and `/agent-design`) now include the Not For and Output Format sections the validator requires.

### Added
- Validator checks:
  - relative links in docs resolve;
  - every agent, coordinators included, has an output format.

## [3.3.0] — 2026-11-26

Quality pass over the original agents and skills.

### Improved
- **48 original agents** gained role-specific sections they were missing:
  - **Output Format** (29 agents): a consistent deliverable shape, so the same request gets the same kind of answer
  - **Approach** (17 agents): how the specialist works through a task
  - **Best For** (35 agents): example requests showing when to use it
  - **Not For** (28 agents): which agent to use instead
  - Every specialist now has an output format and a "Not For" pointer.
- **Outdated advice replaced with durable guidance:**
  - `ai-prompt-engineer`'s provider-specific rules (e.g. "reasoning models take no system prompt", prefill, legacy chat templates) now give cross-provider principles plus "check the provider's current guide for your model".
  - Dated model and tool lists in `ai-engineer`, `ai-architect`, `ai-qa-engineer`, `ai-growth-engineer`, `ai-research-engineer`, `ai-legal-engineer`, `ai-database-engineer`, `ai-frontend-engineer`, `ai-fullstack-engineer` and `/eval` now name model families and the selection criteria instead.
- **Skill references fixed:** 8 agents pointed at `/spec` for non-technical documents. They now use `/ai-pricing`, `/gtm`, `/ai-strategy`, `/moat`, `/compliance`, `/pmf-check` and `/eval`.
- **Overlapping skills** (`/review`, `/security-scan`, `/review-ai`, `/release`, `/changelog`, `/release-plan`, `/docs`, `/explain`, `/metrics`, `/experiment`) now say which sibling to use instead.

### Fixed
- `/compliance` no longer presents the EU AI Act's August 2026 date as a future deadline. It describes the phased timeline and says to check the current official dates.
- `/ai-strategy` no longer hard-codes 2025.
- `/mobile` no longer pins an old Android target API level.
- `/rag-design` no longer lists exact embedding prices, which go stale. It now compares embedding options and says to benchmark them on your own data.

### Added
- Validator checks:
  - every `/skill` reference in agents, templates, skill descriptions and the routing guide exists;
  - every specialist has an output format and a "Not For" pointer.

## [3.2.0] — 2026-11-26

### Added
- **8 project templates by AI startup type.** Each covers routing, stage guidance, key metrics, conventions and directory layout:
  - `AGENTS-agent-product.md`
  - `AGENTS-voice-ai.md`
  - `AGENTS-vision-ai.md`
  - `AGENTS-generative-media.md`
  - `AGENTS-robotics.md`
  - `AGENTS-healthtech-ai.md`
  - `AGENTS-fintech-ai.md`
  - `AGENTS-legaltech-ai.md`
- The health, fintech and legal templates add a regulatory checklist (to confirm with counsel).
- The validator checks every template is listed in the README, has the stage and startup-type fields, and only references agents that exist.

### Changed
- The Next.js and React Native templates are provider-neutral ("LLM API" instead of a specific vendor).

## [3.1.0] — 2026-11-26

Coverage for every kind of AI startup.

### Added
- **6 specialists:**
  - `ai-voice-engineer`: real-time voice agents, STT/TTS, telephony, latency budgets, barge-in
  - `ai-vision-engineer`: detection, document AI, VLMs, labeling loops, edge vision
  - `ai-generative-media-engineer`: image/video/audio generation, style fine-tuning, GPU serving, content safety and provenance
  - `ai-robotics-engineer`: ROS 2, sim-to-real, imitation learning, VLA policies, robot safety
  - `ai-model-training-engineer`: fine-tuning, post-training, distillation, pretraining, compute planning
  - `ai-fundraising-advisor`: raise strategy, pitch narrative, AI investor metrics, data room, terms, investor updates
- **8 skills:**
  - `/pitch-deck`
  - `/investor-update`
  - `/pmf-check`
  - `/moat`
  - `/model-strategy` (API vs open-weight vs fine-tune vs train)
  - `/ai-pricing`
  - `/security-questionnaire`
  - `/data-rights`
- **Routing by AI startup type** in `founder`, plus a new "AI Modalities" group. The routing skills, team coordinators and `docs/routing.md` cover the new specialists.

### Changed
- `ai-finance-engineer` now covers startup finance: runway and burn, fundraising financial models, gross margin after inference, cloud/model-provider credit programs.
- `ai-sales-engineer` now covers founder-led sales, pilots that convert, and enterprise AI deal hurdles: security reviews, AI governance, procurement.
- 21 agent descriptions gained "Not for X (use Y)" guidance to separate overlapping specialists (e.g. software vs fullstack vs backend engineer, staff engineer vs software architect, ml-engineer vs model training).
- `ml-engineer` is scoped to classic ML; LLM fine-tuning and post-training route to `ai-model-training-engineer`.
- Team coordinators, `release-manager` and `developer-advocate` moved from the `deep` to the `standard` tier. They do routing and coordination work, so the cheaper tier keeps cost down.
- `/cost-check` is provider-neutral: it prices whichever providers and models you actually use.
- Routing skills use workspace-neutral "delegate" wording.

## [3.0.0] — 2026-11-26

FoundryAI now works in **any AI workspace** and is built for **every kind of AI startup**.

### Added
- **Multi-workspace build.** `scripts/build.py` generates native agents and skills for Claude Code, Cursor, GitHub Copilot / VS Code, OpenAI Codex CLI (TOML agents), Gemini CLI, and paste-ready prompts for chat workspaces (ChatGPT Projects/GPTs, Claude Projects, Gemini Gems). Skills install to the shared `~/.agents/skills/`, so other Agent Skills–compatible agents (Windsurf, Cline, Roo, Zed, Amp, Junie, …) get them too.
- **Multi-workspace installer.** `install.sh` detects installed workspaces, or takes `--target claude|cursor|copilot|codex|gemini|chat|all`. The manifest and backups moved to `~/.foundryai/`.
- **Shared operating principles** (`agents/_shared/`), added to every agent: identify the AI startup type and stage first, match recommendations to stage and team size, watch inference cost and provider dependency, and delegate (or name the right specialist) when work belongs to someone else.
- **Routing skills** `/cofounder`, `/engineering`, `/product`, `/business` (were Claude-plugin-only commands; `/founder` is now `/cofounder`).
- Project templates now record **AI startup type** and **team size**.
- Validator builds every target and checks file counts, YAML and TOML, the Agent Skills naming rules, and that coordinators can delegate.

### Changed
- **Workspace-neutral source format.** Agents declare `tier` (`deep` / `standard` / `fast`) and `capabilities` (`read`, `edit`, `shell`, `web`, `delegate`) instead of Claude-specific `model` and `tools`. The build maps them to each workspace's models and tools.
- **Skills use the [Agent Skills](https://agentskills.io) standard:** `skills/<name>/SKILL.md` with a `name` field. Claude Code now installs them as skills (`~/.claude/skills/`) instead of legacy slash commands. The installer moves old 2.x copies out of `~/.claude/commands/` into the backup folder.
- **Project templates are `AGENTS.md`** (`templates/AGENTS*.md`), read directly by Codex, Cursor, Copilot and most agents. Claude Code uses a one-line `CLAUDE.md` with `@AGENTS.md`; Gemini CLI uses `context.fileName`.
- **The Claude Code plugin now contains every agent and skill**, generated by the build.
- The routing guide moved from `agents/CLAUDE.md` to `docs/routing.md`.

### Fixed
- **Coordinators can delegate.** `founder`, `ai-orchestrator` and all 9 `team-*` coordinators get the delegate capability (`Agent` in Claude Code, `agent` in Copilot). Previously they could only describe a plan.
- **Agents can use skills.** Claude Code agents get the `Skill` tool. Previously the "Skills" section in every agent couldn't be used.
- **Invalid YAML** in 7 team coordinators' frontmatter (unquoted `Delegates to:`). Strict parsers would reject or misread them.
- `/agent-design` now produces the workspace-neutral format.

### Removed
- `plugin/commands/` and `scripts/sync-plugin-commands.sh`. The plugin is generated from the single source instead.

### Upgrading from 2.x
Re-run the installer. For your own agents, replace `model: opus|sonnet|haiku` with `tier: deep|standard|fast`, and `tools:` with `capabilities: [...]`. Rename project `CLAUDE.md` files to `AGENTS.md` and add a one-line `CLAUDE.md` containing `@AGENTS.md`.

## [2.0.0] — 2026-11-26

### Changed
- Agents use model **aliases** (`opus`, `sonnet`) instead of pinned model IDs. They track the latest Claude models automatically and work on Bedrock/Vertex.
- Agent `tools` lists use Claude Code's real, case-sensitive tool names: `Read, Write, Edit, Grep, Glob, WebSearch, WebFetch` (+ `Bash` where it was granted). Previously `read, write, search` matched no real tools. **Every agent can now edit files in place and use web search/fetch.**
- `/cost-check` pricing updated to Claude 5.5 list prices.
- `founder` agent roster now covers all 52 specialists + 9 team coordinators and is generated from the README.
- `docs/agents.md` and `docs/skills.md` are generated by `scripts/gen-docs.py` and cover every agent and skill.

### Fixed
- **Hooks never ran correctly.** They read environment variables Claude Code doesn't set; they now parse the JSON Claude Code sends on stdin.
  - `protect-env-files.sh` now actually blocks writes (exit code 2), covers `MultiEdit`/`NotebookEdit`, more secret file types, and fails closed.
  - `log-agent-usage.sh` now logs subagent calls.
  - `notify-on-complete.sh` now only notifies for turns longer than 30s (register it on `UserPromptSubmit` and `Stop`).
- **The plugin never installed.** `claude plugin add` is not a Claude Code command and its failure was hidden. The repo now ships `.claude-plugin/marketplace.json`; install with `claude plugin install founders-kit@foundryai`.
- `install.sh` no longer copies `agents/README.md`, `CLAUDE.md` and `WORKFLOWS.md` into `~/.claude/agents/`.
- References to agents that don't exist (`ai-docs-engineer`, `ai-ops-engineer`, `ai-solution-architect`, `ai-product-builder`, `team-manager`) replaced in `founder`, `/feature`, project templates and workflow recipes.
- Counts and install instructions corrected across README, INSTALL, DEMO and plugin metadata.

### Added
- `install.sh --dry-run`, `--hooks`, `--no-plugin`; backups of overwritten files; install manifest.
- `uninstall.sh` — removes exactly what the installer installed.
- `scripts/validate.sh` + GitHub Actions CI: frontmatter, tool names, agent references, counts, generated docs, plugin sync, hook tests, shellcheck.
- `scripts/test-hooks.sh`, `scripts/gen-docs.py`, `scripts/sync-plugin-commands.sh`.

### Upgrading from 1.x
Re-run the installer. Remove the old plugin copy at `~/.claude/plugins/founders-kit` if present, and update your hook registration from `templates/hooks-setup.md`.
