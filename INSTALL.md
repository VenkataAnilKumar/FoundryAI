# Installation Guide

## Option A — One-line install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

This installs:

- **52 specialist agents + 9 team coordinators** → `~/.claude/agents/`
- **42 skills (slash commands)** → `~/.claude/commands/`
- **The `founders-kit` plugin** (routing commands `/founder`, `/engineering`, `/product`, `/business`)

Any existing file it would overwrite is backed up to `~/.claude/founders-kit-backup/<timestamp>/` first.

Options (pass after `bash -s --` when piping from curl):

| Flag | Effect |
|---|---|
| `--dry-run` | Show what would be installed; change nothing |
| `--hooks` | Also copy the hook scripts to `~/.claude/hooks/` |
| `--no-plugin` | Skip the routing plugin |

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash -s -- --dry-run
```

---

## Option B — From a local clone

```bash
git clone https://github.com/VenkataAnilKumar/FoundryAI
cd FoundryAI
./install.sh
```

The installer uses your local checkout, so you can edit agents before installing.

---

## Option C — Plugin only

Inside Claude Code:

```
/plugin marketplace add VenkataAnilKumar/FoundryAI
/plugin install founders-kit@foundryai
```

Or from your shell:

```bash
claude plugin marketplace add VenkataAnilKumar/FoundryAI
```

```bash
claude plugin install founders-kit@foundryai
```

Plugin commands are namespaced, e.g. `/founders-kit:founder "help me build a streaming chat interface"`.

---

## Option D — Add a project template

```bash
cp FoundryAI/templates/CLAUDE.md ./your-project/CLAUDE.md
```

Then edit it with your stack, conventions, and agent routing preferences. Stack-specific templates: `CLAUDE-nextjs-saas.md`, `CLAUDE-python-ml.md`, `CLAUDE-react-native.md`.

---

## Hooks (optional)

```bash
./install.sh --hooks
```

Then register them in `~/.claude/settings.json` — see [`templates/hooks-setup.md`](templates/hooks-setup.md).

---

## Verify

```bash
ls ~/.claude/agents/ | wc -l    # at least 61
ls ~/.claude/commands/ | wc -l  # at least 42
```

In Claude Code, run `/agents` to see the installed agents.

---

## Updating

Re-run the installer. It overwrites the kit's files (backing up any you changed) and leaves your own agents and commands alone.

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
```

To update just the plugin:

```bash
claude plugin marketplace update foundryai
```

---

## Uninstalling

```bash
curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash
```

This removes exactly the files `install.sh` recorded in `~/.claude/founders-kit.manifest`, plus the plugin. Your own agents, commands, and the backups are kept. Add `--dry-run` (`bash -s -- --dry-run`) to preview.

Installs made before the manifest existed have to be removed by hand: compare `~/.claude/agents/` and `~/.claude/commands/` with this repo's `agents/` and `skills/`.
