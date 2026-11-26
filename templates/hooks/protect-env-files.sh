#!/usr/bin/env bash
# Hook: block Claude from writing to files that usually hold secrets.
# Event: PreToolUse, matcher "Write|Edit|MultiEdit|NotebookEdit"
#
# Claude Code sends the hook input as JSON on stdin, e.g.
#   {"tool_name":"Write","tool_input":{"file_path":"/repo/.env", ...}, ...}
# Exit 2 blocks the tool call and shows stderr to Claude. Exit 0 allows it.
#
# Fails closed: if the input can't be parsed, the write is blocked.

set -uo pipefail

block() {
  echo "BLOCKED by protect-env-files hook: $1" >&2
  echo "If this is intentional, edit the file yourself outside Claude." >&2
  exit 2
}

INPUT="$(cat)"

if command -v jq >/dev/null 2>&1; then
  TOOL_NAME="$(printf '%s' "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)" || block "could not parse hook input"
  FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // .tool_input.notebook_path // empty' 2>/dev/null)" || block "could not parse hook input"
elif command -v python3 >/dev/null 2>&1; then
  PARSED="$(printf '%s' "$INPUT" | python3 -c '
import json, sys
d = json.load(sys.stdin)
ti = d.get("tool_input") or {}
print(d.get("tool_name") or "")
print(ti.get("file_path") or ti.get("notebook_path") or "")
' 2>/dev/null)" || block "could not parse hook input"
  TOOL_NAME="$(printf '%s\n' "$PARSED" | sed -n 1p)"
  FILE_PATH="$(printf '%s\n' "$PARSED" | sed -n 2p)"
else
  block "neither jq nor python3 is installed, so the hook cannot check the target file"
fi

case "$TOOL_NAME" in
  Write|Edit|MultiEdit|NotebookEdit) ;;
  *) exit 0 ;;
esac

[ -z "$FILE_PATH" ] && exit 0

BASENAME="$(basename -- "$FILE_PATH")"
# Template/example env files are safe to edit.
case "$BASENAME" in
  .env.example|.env.sample|.env.template|*.env.example) exit 0 ;;
esac

# Patterns match the file name (case-insensitive).
SENSITIVE_PATTERNS=(
  '^\.env$'
  '^\.env\..+'          # .env.local, .env.production, ...
  '\.env$'              # prod.env
  '^secrets?\.'         # secrets.json, secret.yaml
  '^credentials?\.'     # credentials.json
  '\.pem$'
  '\.key$'
  '\.p12$'
  '\.pfx$'
  '^id_(rsa|dsa|ecdsa|ed25519)$'
)

for pattern in "${SENSITIVE_PATTERNS[@]}"; do
  if printf '%s' "$BASENAME" | grep -qiE -- "$pattern"; then
    block "$FILE_PATH looks like a secrets file"
  fi
done

exit 0
