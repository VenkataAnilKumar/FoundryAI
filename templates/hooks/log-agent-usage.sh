#!/usr/bin/env bash
# Hook: log every subagent invocation for usage analytics.
# Event: PostToolUse, matcher "Agent|Task"
#
# Claude Code sends the hook input as JSON on stdin, e.g.
#   {"session_id":"...","tool_name":"Agent",
#    "tool_input":{"subagent_type":"ai-architect","description":"..."}, ...}
# Logging must never interfere with the session, so this always exits 0.

LOG_FILE="${FOUNDERS_KIT_LOG:-$HOME/.claude/logs/agent-usage.log}"
mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null || exit 0

INPUT="$(cat)"

if command -v jq >/dev/null 2>&1; then
  LINE="$(printf '%s' "$INPUT" | jq -r '
    select(.tool_name == "Agent" or .tool_name == "Task")
    | "session=\(.session_id // "unknown") | agent=\(.tool_input.subagent_type // "general-purpose") | task=\(.tool_input.description // "" | gsub("[\r\n|]"; " "))"
  ' 2>/dev/null)"
elif command -v python3 >/dev/null 2>&1; then
  LINE="$(printf '%s' "$INPUT" | python3 -c '
import json, re, sys
d = json.load(sys.stdin)
if d.get("tool_name") in ("Agent", "Task"):
    ti = d.get("tool_input") or {}
    desc = re.sub(r"[\r\n|]", " ", ti.get("description") or "")
    session = d.get("session_id") or "unknown"
    agent = ti.get("subagent_type") or "general-purpose"
    print("session=%s | agent=%s | task=%s" % (session, agent, desc))
' 2>/dev/null)"
else
  exit 0
fi

[ -n "$LINE" ] && echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) | $LINE" >> "$LOG_FILE"
exit 0
