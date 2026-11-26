#!/usr/bin/env bash
# Hook: desktop notification when Claude finishes a long-running turn.
# Events: UserPromptSubmit (records the start time) and Stop (notifies).
#
# Register this same script on both events (see templates/hooks-setup.md).
# Claude Code sends JSON on stdin with "hook_event_name" and "session_id".
# Turns shorter than FOUNDERS_KIT_NOTIFY_MIN_SECONDS (default 30) are skipped.
# Notifications must never interfere with the session, so this always exits 0.

MIN_SECONDS="${FOUNDERS_KIT_NOTIFY_MIN_SECONDS:-30}"
STATE_DIR="$HOME/.claude/logs/turn-start"
mkdir -p "$STATE_DIR" 2>/dev/null || exit 0

INPUT="$(cat)"

if command -v jq >/dev/null 2>&1; then
  EVENT="$(printf '%s' "$INPUT" | jq -r '.hook_event_name // empty' 2>/dev/null)"
  SESSION="$(printf '%s' "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)"
elif command -v python3 >/dev/null 2>&1; then
  EVENT="$(printf '%s' "$INPUT" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("hook_event_name",""))' 2>/dev/null)"
  SESSION="$(printf '%s' "$INPUT" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("session_id","unknown"))' 2>/dev/null)"
else
  exit 0
fi

# Keep the session id safe to use as a file name.
SESSION="$(printf '%s' "${SESSION:-unknown}" | tr -c 'A-Za-z0-9_-' '_')"
STATE_FILE="$STATE_DIR/$SESSION"

case "$EVENT" in
  UserPromptSubmit)
    date +%s > "$STATE_FILE"
    exit 0
    ;;
  Stop) ;;
  *) exit 0 ;;
esac

# Without a recorded start time we can't tell how long the turn took: skip.
[ -f "$STATE_FILE" ] || exit 0
START="$(cat "$STATE_FILE" 2>/dev/null)"
rm -f "$STATE_FILE"
case "$START" in ''|*[!0-9]*) exit 0 ;; esac
[ $(( $(date +%s) - START )) -lt "$MIN_SECONDS" ] && exit 0

TITLE="Founders Kit"
MESSAGE="Task complete — Claude is done"

if command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\"" >/dev/null 2>&1
elif command -v notify-send >/dev/null 2>&1; then
  notify-send "$TITLE" "$MESSAGE" >/dev/null 2>&1
elif command -v powershell.exe >/dev/null 2>&1; then
  powershell.exe -NoProfile -Command "
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    \$t = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
    \$n = \$t.GetElementsByTagName('text')
    \$n.Item(0).AppendChild(\$t.CreateTextNode('$TITLE')) | Out-Null
    \$n.Item(1).AppendChild(\$t.CreateTextNode('$MESSAGE')) | Out-Null
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Claude Code').Show([Windows.UI.Notifications.ToastNotification]::new(\$t))
  " >/dev/null 2>&1
fi
exit 0
