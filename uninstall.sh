#!/usr/bin/env bash
# Founders Kit — uninstaller
#
#   curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash
#   ./uninstall.sh --dry-run
#
# Removes exactly the files listed in ~/.claude/founders-kit.manifest (written by
# install.sh) and the founders-kit plugin. Your own agents and commands are untouched.
# Backups in ~/.claude/founders-kit-backup/ are kept.

set -euo pipefail

MANIFEST="$HOME/.claude/founders-kit.manifest"
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

if [ ! -f "$MANIFEST" ]; then
  echo "No install manifest at $MANIFEST." >&2
  echo "Founders Kit was not installed with install.sh, or was already removed." >&2
  echo "Older installs (before the manifest existed) must be removed by hand:" >&2
  echo "compare ~/.claude/agents and ~/.claude/commands with the repo's agents/ and skills/." >&2
  exit 1
fi

removed=0
while IFS= read -r path; do
  [ -n "$path" ] || continue
  # Only ever remove files inside ~/.claude.
  case "$path" in "$HOME/.claude/"*) ;; *) echo "skipping unexpected path: $path" >&2; continue ;; esac
  if [ -f "$path" ]; then
    if [ "$DRY_RUN" = 1 ]; then echo "would remove $path"; else rm -f "$path"; fi
    removed=$((removed + 1))
  fi
done < "$MANIFEST"

if [ "$DRY_RUN" = 1 ]; then
  echo "Dry run: $removed file(s) would be removed."
  echo "Would run: claude plugin uninstall founders-kit@foundryai"
  exit 0
fi

rm -f "$MANIFEST"
echo "Removed $removed file(s)."

if command -v claude >/dev/null 2>&1; then
  if claude plugin uninstall founders-kit@foundryai >/dev/null 2>&1; then
    echo "Removed the founders-kit plugin."
  else
    echo "Plugin not removed (it may not be installed). Inside Claude Code: /plugin uninstall founders-kit@foundryai"
  fi
fi

echo "If you registered hooks, remove them from ~/.claude/settings.json."
