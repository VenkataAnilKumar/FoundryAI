# Hooks Setup

Claude Code hooks run shell scripts automatically on events. Add these to `~/.claude/settings.json`.

## Available Hooks

| Hook file | Event | What it does |
|---|---|---|
| `log-agent-usage.sh` | PostToolUse | Logs every agent invocation to `~/.claude/logs/agent-usage.log` |
| `protect-env-files.sh` | PreToolUse | Blocks Claude from writing to `.env`, `.pem`, `secrets.*` files |
| `notify-on-complete.sh` | Stop | Desktop notification when a long task finishes |

## Install

```bash
# Copy hooks
cp claude-agents/templates/hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/protect-env-files.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Agent",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/log-agent-usage.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/notify-on-complete.sh"
          }
        ]
      }
    ]
  }
}
```

## MCP Servers

Copy the right config to your project root as `.mcp.json`:

```bash
# GitHub only
cp claude-agents/templates/mcp-github.json ./.mcp.json

# PostgreSQL only
cp claude-agents/templates/mcp-postgres.json ./.mcp.json

# Full stack (GitHub + PostgreSQL + Filesystem)
cp claude-agents/templates/mcp-full-stack.json ./.mcp.json
```

Then fill in your credentials and run `claude` — MCP servers start automatically.
