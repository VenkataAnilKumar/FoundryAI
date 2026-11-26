#!/usr/bin/env bash
# Tests for templates/hooks/*.sh. Feeds each hook the JSON Claude Code sends on stdin.
# Usage: scripts/test-hooks.sh
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

HOOKS=templates/hooks
fail=0
pass=0

expect() { # expect <description> <expected-exit> <hook> <json>
  local desc="$1" want="$2" hook="$3" json="$4" got
  printf '%s' "$json" | bash "$HOOKS/$hook" >/dev/null 2>&1
  got=$?
  if [ "$got" = "$want" ]; then
    pass=$((pass + 1))
  else
    echo "FAIL: $desc (want exit $want, got $got)" >&2
    fail=$((fail + 1))
  fi
}

write() { printf '{"session_id":"t","hook_event_name":"PreToolUse","tool_name":"%s","tool_input":{"file_path":"%s"}}' "$1" "$2"; }

# --- protect-env-files.sh -------------------------------------------------
P=protect-env-files.sh
for f in /repo/.env /repo/.env.local /repo/.env.production /repo/config/prod.env \
         /repo/secrets.json /repo/secret.yaml /repo/credentials.json /repo/tls/server.pem \
         /repo/server.key /home/u/.ssh/id_rsa /repo/cert.p12 /repo/.ENV; do
  expect "blocks Write to $f" 2 "$P" "$(write Write "$f")"
done
expect "blocks Edit to .env"         2 "$P" "$(write Edit /repo/.env)"
expect "blocks MultiEdit to .env"    2 "$P" "$(write MultiEdit /repo/.env)"
for f in /repo/src/app.ts /repo/.env.example /repo/.env.sample /repo/environment.ts \
         /repo/keyboard.tsx /repo/README.md /repo/docs/secrets-management.md; do
  expect "allows Write to $f" 0 "$P" "$(write Write "$f")"
done
expect "ignores Read of .env"        0 "$P" "$(write Read /repo/.env)"
expect "fails closed on bad JSON"    2 "$P" 'not json'

# --- log-agent-usage.sh ---------------------------------------------------
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
export FOUNDERS_KIT_LOG="$TMP/agent.log"
expect "log hook exits 0 for Agent" 0 log-agent-usage.sh \
  '{"session_id":"s1","tool_name":"Agent","tool_input":{"subagent_type":"ai-architect","description":"design | the\nsystem"}}'
expect "log hook exits 0 for other tools" 0 log-agent-usage.sh \
  '{"session_id":"s1","tool_name":"Bash","tool_input":{"command":"ls"}}'
expect "log hook exits 0 on bad JSON" 0 log-agent-usage.sh 'not json'
if [ "$(wc -l < "$FOUNDERS_KIT_LOG" 2>/dev/null || echo 0)" -eq 1 ] \
   && grep -q 'agent=ai-architect | task=design   the system' "$FOUNDERS_KIT_LOG"; then
  pass=$((pass + 1))
else
  echo "FAIL: log hook should write exactly one sanitised line; got:" >&2
  cat "$FOUNDERS_KIT_LOG" >&2 2>/dev/null
  fail=$((fail + 1))
fi

# --- notify-on-complete.sh ------------------------------------------------
export HOME="$TMP/home"
expect "notify records start on UserPromptSubmit" 0 notify-on-complete.sh \
  '{"session_id":"s2","hook_event_name":"UserPromptSubmit","prompt":"hi"}'
if [ -f "$HOME/.claude/logs/turn-start/s2" ]; then pass=$((pass + 1)); else echo "FAIL: notify hook did not record start time" >&2; fail=$((fail + 1)); fi
expect "notify exits 0 on short Stop" 0 notify-on-complete.sh \
  '{"session_id":"s2","hook_event_name":"Stop"}'
if [ ! -f "$HOME/.claude/logs/turn-start/s2" ]; then pass=$((pass + 1)); else echo "FAIL: notify hook did not clear start time" >&2; fail=$((fail + 1)); fi
expect "notify exits 0 on bad JSON" 0 notify-on-complete.sh 'not json'

echo "hooks: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
