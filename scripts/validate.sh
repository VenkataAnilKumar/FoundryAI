#!/usr/bin/env bash
# Run every repository check. CI runs this on each push and pull request.
# Usage: scripts/validate.sh
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

status=0
run() {
  echo "▸ $*"
  "$@" || status=1
}

run python3 scripts/validate.py
run python3 scripts/gen-docs.py --check
run python3 scripts/build.py --check
run scripts/test-hooks.sh
for f in install.sh uninstall.sh scripts/*.sh templates/hooks/*.sh; do
  bash -n "$f" || { echo "syntax error in $f" >&2; status=1; }
done
if command -v shellcheck >/dev/null 2>&1; then
  run shellcheck -S warning install.sh uninstall.sh scripts/*.sh templates/hooks/*.sh
fi

[ "$status" -eq 0 ] && echo "All checks passed." || echo "Some checks failed." >&2
exit "$status"
