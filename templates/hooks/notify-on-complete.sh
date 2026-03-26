#!/usr/bin/env bash
# Hook: Desktop notification when Claude finishes a long task
# Event: Stop (fires when Claude finishes responding)

# Skip if session is very short (< 30 seconds — not a long task)
START_TIME="${CLAUDE_SESSION_START:-0}"
NOW=$(date +%s)
ELAPSED=$((NOW - START_TIME))

if [[ $ELAPSED -lt 30 ]]; then
  exit 0
fi

# Windows (using PowerShell toast notification)
if command -v powershell.exe &>/dev/null; then
  powershell.exe -Command "
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    \$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
    \$textNodes = \$template.GetElementsByTagName('text')
    \$textNodes.Item(0).AppendChild(\$template.CreateTextNode('Founders Kit')) | Out-Null
    \$textNodes.Item(1).AppendChild(\$template.CreateTextNode('Task complete — Claude is done')) | Out-Null
    \$toast = [Windows.UI.Notifications.ToastNotification]::new(\$template)
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Claude Code').Show(\$toast)
  " 2>/dev/null
  exit 0
fi

# macOS
if command -v osascript &>/dev/null; then
  osascript -e 'display notification "Task complete — Claude is done" with title "Founders Kit"' 2>/dev/null
  exit 0
fi

# Linux
if command -v notify-send &>/dev/null; then
  notify-send "Founders Kit" "Task complete — Claude is done" 2>/dev/null
fi
