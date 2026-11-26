#!/usr/bin/env bash
# skills/ is the source of truth for every slash command.
# plugin/commands/ holds the plugin-only routing commands (founder, engineering,
# product, business) plus copies of shared skills, which this script keeps in sync.
#
# Usage:
#   scripts/sync-plugin-commands.sh          # copy skills/ -> plugin/commands/
#   scripts/sync-plugin-commands.sh --check  # exit 1 if any copy has drifted
set -euo pipefail
cd "$(dirname "$0")/.."

ROUTING_ONLY="founder engineering product business"
mode="${1:-sync}"
drift=0

for dest in plugin/commands/*.md; do
  name="$(basename "$dest" .md)"
  case " $ROUTING_ONLY " in *" $name "*) continue ;; esac
  src="skills/$name.md"
  if [ ! -f "$src" ]; then
    echo "error: $dest has no source in skills/" >&2
    drift=1
    continue
  fi
  if ! cmp -s "$src" "$dest"; then
    if [ "$mode" = "--check" ]; then
      echo "drift: $dest differs from $src" >&2
      drift=1
    else
      cp "$src" "$dest"
      echo "synced: $dest"
    fi
  fi
done

if [ "$mode" = "--check" ] && [ "$drift" -ne 0 ]; then
  echo "Run scripts/sync-plugin-commands.sh to fix." >&2
fi
exit "$drift"
