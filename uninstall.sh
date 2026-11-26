#!/usr/bin/env bash
# FoundryAI — uninstaller
#
#   curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash
#   ./uninstall.sh --dry-run
#
# Removes exactly the files listed in ~/.foundryai/manifest (written by install.sh) from every
# workspace, then any skill folders left empty. Your own agents, skills and commands are untouched.
# Backups in ~/.foundryai/backup/ are kept. Also removes the Claude Code plugin if installed.

set -euo pipefail

MANIFEST="$HOME/.foundryai/manifest"
LEGACY_MANIFEST="$HOME/.claude/founders-kit.manifest"
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

manifests=()
[ -f "$MANIFEST" ] && manifests+=("$MANIFEST")
[ -f "$LEGACY_MANIFEST" ] && manifests+=("$LEGACY_MANIFEST")
if [ "${#manifests[@]}" -eq 0 ]; then
  echo "No install manifest found at $MANIFEST." >&2
  echo "FoundryAI was not installed with install.sh, or was already removed." >&2
  exit 1
fi

removed=0
dirs=()
while IFS= read -r path; do
  [ -n "$path" ] || continue
  # Only ever remove files inside the user's home directory.
  case "$path" in "$HOME/"*) ;; *) echo "skipping unexpected path: $path" >&2; continue ;; esac
  case "$path" in *"/../"*) echo "skipping unexpected path: $path" >&2; continue ;; esac
  if [ -f "$path" ]; then
    if [ "$DRY_RUN" = 1 ]; then echo "would remove $path"; else rm -f "$path"; fi
    removed=$((removed + 1))
    dirs+=("$(dirname "$path")")
  fi
done < <(cat "${manifests[@]}" | sort -u)

if [ "$DRY_RUN" = 1 ]; then
  echo "Dry run: $removed file(s) would be removed."
  exit 0
fi

# Remove directories the install created that are now empty (e.g. skills/<name>/).
if [ "${#dirs[@]}" -gt 0 ]; then
  printf '%s\n' "${dirs[@]}" | sort -ru | while IFS= read -r d; do
    rmdir "$d" 2>/dev/null && rmdir "$(dirname "$d")" 2>/dev/null || true
  done
fi

rm -f "${manifests[@]}"
echo "Removed $removed file(s)."

if command -v claude >/dev/null 2>&1 && claude plugin uninstall founders-kit@foundryai >/dev/null 2>&1; then
  echo "Removed the founders-kit Claude Code plugin."
fi
echo "If you registered Claude Code hooks, remove them from ~/.claude/settings.json."
