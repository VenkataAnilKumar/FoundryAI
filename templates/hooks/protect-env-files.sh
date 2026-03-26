#!/usr/bin/env bash
# Hook: Block writes to .env files containing secrets
# Event: PreToolUse (fires before Write/Edit tool calls)

TOOL_NAME="${CLAUDE_TOOL_NAME:-}"
FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-}"

# Only check Write and Edit operations
if [[ "$TOOL_NAME" != "Write" && "$TOOL_NAME" != "Edit" ]]; then
  exit 0
fi

# Block writes to sensitive files
SENSITIVE_PATTERNS=(".env$" ".env.local$" ".env.production$" "secrets\." "credentials\." "\.pem$" "\.key$")

for pattern in "${SENSITIVE_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -qE "$pattern"; then
    echo "BLOCKED: Writing to sensitive file: $FILE_PATH"
    echo "If this is intentional, edit the file manually."
    exit 1
  fi
done
