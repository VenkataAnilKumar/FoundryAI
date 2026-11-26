# Installation Guide

FoundryAI installs into any AI workspace. The installer builds the agents and skills into each workspace's native format, so you need `python3` (and `git` when installing with `curl`).

## Option A — One-line install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/master/install.sh | bash
```

With no options it installs into **every workspace it detects** on your machine: 58 specialist agents, 9 team coordinators and 54 skills each.

| Target | Workspace | Agents go to | Skills go to |
|---|---|---|---|
| `claude` | Claude Code | `~/.claude/agents/` | `~/.claude/skills/` |
| `cursor` | Cursor | `~/.cursor/agents/` | `~/.agents/skills/` |
| `copilot` | GitHub Copilot / VS Code | `~/.copilot/agents/` | `~/.copilot/skills/` |
| `codex` | OpenAI Codex CLI | `~/.codex/agents/` (TOML) | `~/.agents/skills/` |
| `gemini` | Gemini CLI | `~/.gemini/agents/` | `~/.agents/skills/` |
| `chat` | ChatGPT, Claude, Gemini projects | `~/FoundryAI-chat-prompts/` | same folder |

`~/.agents/skills/` is the shared [Agent Skills](https://agentskills.io) location, so Windsurf, Cline, Roo, Zed, Amp, Junie and other compatible agents pick the skills up too.

Options (pass after `bash -s --` when piping from curl):

| Flag | Effect |
|---|---|
| `--target NAME` | Install into this workspace only (repeatable; `all` for every one) |
| `--dry-run` | Show what would be installed; change nothing |
| `--hooks` | Also copy the Claude Code hook scripts to `~/.claude/hooks/` |

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/master/install.sh | bash -s -- --target cursor --target codex --dry-run
```

Any existing file it would overwrite is backed up to `~/.foundryai/backup/<timestamp>/` first.

---

## Option B — From a local clone

```bash
git clone https://github.com/VenkataAnilKumar/FoundryAI
cd FoundryAI
./install.sh --target all
```

The installer builds from your checkout, so you can edit agents and skills before installing.

---

## Option C — Claude Code plugin

Inside Claude Code:

```
/plugin marketplace add VenkataAnilKumar/FoundryAI
/plugin install founders-kit@foundryai
```

The plugin contains all agents and skills. Its skills are namespaced, e.g. `/founders-kit:cofounder "help me build a streaming chat interface"`. Use either the plugin or `install.sh --target claude`, not both, to avoid duplicates.

---

## Option D — Chat workspaces (no install)

For ChatGPT Projects or custom GPTs, Claude Projects, Gemini Gems and similar:

```bash
./install.sh --target chat
```

Then follow `~/FoundryAI-chat-prompts/README.md`: paste an agent file into the project's instructions, and upload `routing-guide.md` as project knowledge.

---

## Add a project template

```bash
cp FoundryAI/templates/AGENTS.md ./your-project/AGENTS.md
```

Edit it with your AI startup type, stage, stack and conventions. Templates by stack: `AGENTS-nextjs-saas.md`, `AGENTS-python-ml.md`, `AGENTS-react-native.md`. By AI startup type: `AGENTS-agent-product.md`, `AGENTS-voice-ai.md`, `AGENTS-vision-ai.md`, `AGENTS-generative-media.md`, `AGENTS-robotics.md`, `AGENTS-healthtech-ai.md`, `AGENTS-fintech-ai.md`, `AGENTS-legaltech-ai.md`.

- Codex, Cursor, Copilot, Windsurf, Zed, Amp and most agents read `AGENTS.md` directly.
- **Claude Code:** create `CLAUDE.md` containing `@AGENTS.md`.
- **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.

---

## Hooks (Claude Code, optional)

```bash
./install.sh --target claude --hooks
```

Then register them in `~/.claude/settings.json` — see [`templates/hooks-setup.md`](templates/hooks-setup.md).

---

## Verify

Restart your workspace, then check its agent list — e.g. `/agents` in Claude Code, the agent picker in Copilot, or ask *"Which FoundryAI agents are available?"* Try a skill: `/cofounder "plan our MVP"`.

---

## Updating

Re-run the installer. It overwrites FoundryAI's files (backing up any you changed) and leaves your own agents and skills alone. Upgrading from 2.x also moves the old `~/.claude/commands/` copies of FoundryAI's skills into the backup folder, since they're installed as skills now.

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/master/install.sh | bash
```

Plugin users: `claude plugin marketplace update foundryai`.

---

## Uninstalling

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/master/uninstall.sh | bash
```

This removes exactly the files `install.sh` recorded in `~/.foundryai/manifest` from every workspace, plus the Claude Code plugin if installed. Your own agents, skills and the backups are kept. Add `--dry-run` (`bash -s -- --dry-run`) to preview.
