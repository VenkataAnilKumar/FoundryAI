# Hooks Setup

Claude Code hooks run shell scripts automatically on events. Claude Code passes each hook a JSON object on stdin (`session_id`, `hook_event_name`, `tool_name`, `tool_input`, ...). A `PreToolUse` hook blocks the tool call by exiting with code **2**.

The scripts need `jq` or `python3` to read that JSON. `protect-env-files.sh` fails closed: if it can't read its input, it blocks the write.

## Available Hooks

| Hook file | Event | What it does |
|---|---|---|
| `protect-env-files.sh` | PreToolUse | Blocks Claude from writing to `.env*`, `*.pem`, `*.key`, `secrets.*`, `credentials.*`, SSH keys. `.env.example` / `.env.sample` / `.env.template` are allowed. |
| `log-agent-usage.sh` | PostToolUse | Logs every subagent invocation to `~/.claude/logs/agent-usage.log` (override with `FOUNDERS_KIT_LOG`) |
| `notify-on-complete.sh` | UserPromptSubmit + Stop | Desktop notification when a turn takes longer than 30 seconds (override with `FOUNDERS_KIT_NOTIFY_MIN_SECONDS`) |

## Install

```bash
mkdir -p ~/.claude/hooks
cp FoundryAI/templates/hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Merge this into `~/.claude/settings.json` (keep any hooks you already have):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit|NotebookEdit",
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/protect-env-files.sh" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Agent|Task",
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/log-agent-usage.sh" }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/notify-on-complete.sh" }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/notify-on-complete.sh" }
        ]
      }
    ]
  }
}
```

Run `/hooks` in Claude Code to confirm they're registered.

## Testing

From the repo root:

```bash
scripts/test-hooks.sh
```

The tests feed each hook the same JSON Claude Code sends and check the exit codes and log output.

## MCP Servers

Copy the right config to your project root as `.mcp.json`:

```bash
# GitHub only
cp FoundryAI/templates/mcp-github.json ./.mcp.json

# PostgreSQL only
cp FoundryAI/templates/mcp-postgres.json ./.mcp.json

# Full stack (GitHub + PostgreSQL + Filesystem)
cp FoundryAI/templates/mcp-full-stack.json ./.mcp.json
```

Then fill in your credentials and run `claude` — MCP servers start automatically.
