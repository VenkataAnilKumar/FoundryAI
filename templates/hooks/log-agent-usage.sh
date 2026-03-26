#!/usr/bin/env bash
# Hook: Log every agent invocation for usage analytics
# Event: PostToolUse (fires after each tool call)
# Usage: Add to settings.json hooks config

LOG_FILE="$HOME/.claude/logs/agent-usage.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Only log agent invocations (tool_name = "Agent")
TOOL_NAME="${CLAUDE_TOOL_NAME:-}"
if [[ "$TOOL_NAME" != "Agent" ]]; then
  exit 0
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
AGENT="${CLAUDE_TOOL_INPUT_SUBAGENT_TYPE:-unknown}"
DESCRIPTION="${CLAUDE_TOOL_INPUT_DESCRIPTION:-}"
SESSION="${CLAUDE_SESSION_ID:-unknown}"

echo "$TIMESTAMP | session=$SESSION | agent=$AGENT | task=$DESCRIPTION" >> "$LOG_FILE"
