# Installation Guide

## Option A — Quick Install (Recommended)

```bash
# Clone the repo
git clone https://github.com/yourusername/claude-agents

# Copy agents to your Claude agents directory
cp claude-agents/agents/*.md ~/.claude/agents/

# Verify installation
ls ~/.claude/agents/
```

Done. Open Claude Code and the agents are available immediately.

---

## Option B — Install with Routing Plugin

The routing plugin adds `/team`, `/engineering`, `/product`, and `/business` commands.

```bash
# After cloning (see Option A above)
claude plugin add ./claude-agents/plugin
```

Test it:
```
/team "help me build a streaming chat interface"
```

---

## Option C — Full Setup with Project Template

For a new project that uses the full agent team:

```bash
# 1. Install agents (Option A)
cp claude-agents/agents/*.md ~/.claude/agents/

# 2. Install plugin (Option B)
claude plugin add ./claude-agents/plugin

# 3. Add project config to your repo
cp claude-agents/templates/CLAUDE.md ./your-project/CLAUDE.md

# 4. Edit CLAUDE.md with your project details
# - Set your tech stack
# - Set coding conventions
# - Customize agent routing preferences
```

---

## Verify Installation

In Claude Code, run:
```
List all available agents
```

You should see all 34 specialists listed.

---

## Updating

```bash
cd claude-agents
git pull
cp agents/*.md ~/.claude/agents/
```

---

## Uninstalling

```bash
# Remove agents
rm ~/.claude/agents/ai-*.md
rm ~/.claude/agents/team-manager.md
rm ~/.claude/agents/technical-writer.md
# ... etc

# Remove plugin
claude plugin remove ai-team-router
```
