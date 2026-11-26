#!/usr/bin/env bash
# Founders Kit — installer
#
#   curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- --dry-run      # show what would change
#   ./install.sh --no-plugin                               # from a local clone
#
# Options:
#   --dry-run     print what would be installed; change nothing
#   --no-plugin   skip the founders-kit plugin (routing commands)
#   --hooks       also copy hook scripts to ~/.claude/hooks (you still register them
#                 in ~/.claude/settings.json; see templates/hooks-setup.md)
#
# Existing files that would be overwritten with different content are backed up to
# ~/.claude/founders-kit-backup/<timestamp>/ first. Every installed file is recorded in
# ~/.claude/founders-kit.manifest so uninstall.sh removes exactly what was installed.

set -euo pipefail

REPO_URL="https://github.com/VenkataAnilKumar/FoundryAI"
MARKETPLACE_SOURCE="VenkataAnilKumar/FoundryAI"
MARKETPLACE_NAME="foundryai"
PLUGIN_NAME="founders-kit"

CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$CLAUDE_DIR/agents"
COMMANDS_DIR="$CLAUDE_DIR/commands"
HOOKS_DIR="$CLAUDE_DIR/hooks"
MANIFEST="$CLAUDE_DIR/founders-kit.manifest"
BACKUP_DIR="$CLAUDE_DIR/founders-kit-backup/$(date +%Y%m%d-%H%M%S)"

DRY_RUN=0
INSTALL_PLUGIN=1
INSTALL_HOOKS=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --no-plugin) INSTALL_PLUGIN=0 ;;
    --hooks) INSTALL_HOOKS=1 ;;
    -h|--help) { sed -n "2,17p" "$0" | sed "s/^# \{0,1\}//"; } 2>/dev/null || true; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

if [ -t 1 ]; then
  GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
else
  GREEN=''; BLUE=''; YELLOW=''; RED=''; NC=''
fi
warn() { echo -e "${YELLOW}warning:${NC} $*" >&2; }

echo ""
echo -e "${BLUE}Founders Kit — your AI co-founder + specialist agents + team coordinators${NC}"
echo "────────────────────────────────────────────────────────"
[ "$DRY_RUN" = 1 ] && echo -e "${YELLOW}Dry run — nothing will be changed.${NC}"
echo ""

if ! command -v claude >/dev/null 2>&1; then
  echo -e "${RED}Claude Code is not installed.${NC} Install it first: https://claude.ai/code" >&2
  exit 1
fi

# Use the local checkout when run from one; otherwise clone.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/agents" ] && [ -d "$SCRIPT_DIR/skills" ]; then
  SRC="$SCRIPT_DIR"
else
  command -v git >/dev/null 2>&1 || { echo "git is required." >&2; exit 1; }
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  echo "Downloading..."
  git clone --depth 1 --quiet "$REPO_URL" "$TMP_DIR/FoundryAI"
  SRC="$TMP_DIR/FoundryAI"
fi

# Only real agent definitions: files whose frontmatter has a name: field.
# (agents/ also holds README.md, CLAUDE.md and WORKFLOWS.md, which are docs.)
is_agent() { head -1 "$1" | grep -q '^---$' && sed -n '2,/^---$/p' "$1" | grep -q '^name:'; }

NEW_MANIFEST=()
backed_up=0
install_file() { # install_file <src> <dest-dir>
  local src="$1" dest
  dest="$2/$(basename "$1")"
  NEW_MANIFEST+=("$dest")
  [ "$DRY_RUN" = 1 ] && return 0
  if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
    mkdir -p "$BACKUP_DIR"
    cp "$dest" "$BACKUP_DIR/"
    backed_up=$((backed_up + 1))
  fi
  cp "$src" "$dest"
}

[ "$DRY_RUN" = 1 ] || mkdir -p "$AGENTS_DIR" "$COMMANDS_DIR"

agents=0; coordinators=0
for f in "$SRC"/agents/*.md; do
  is_agent "$f" || continue
  install_file "$f" "$AGENTS_DIR"
  case "$(basename "$f")" in team-*) coordinators=$((coordinators + 1)) ;; *) agents=$((agents + 1)) ;; esac
done
echo -e "Agents:   ${GREEN}$agents specialists + $coordinators team coordinators${NC} → $AGENTS_DIR"

skills=0
for f in "$SRC"/skills/*.md; do
  install_file "$f" "$COMMANDS_DIR"
  skills=$((skills + 1))
done
echo -e "Skills:   ${GREEN}$skills slash commands${NC} → $COMMANDS_DIR"

if [ "$INSTALL_HOOKS" = 1 ]; then
  [ "$DRY_RUN" = 1 ] || mkdir -p "$HOOKS_DIR"
  for f in "$SRC"/templates/hooks/*.sh; do
    install_file "$f" "$HOOKS_DIR"
    [ "$DRY_RUN" = 1 ] || chmod +x "$HOOKS_DIR/$(basename "$f")"
  done
  echo -e "Hooks:    ${GREEN}copied${NC} → $HOOKS_DIR (register them: templates/hooks-setup.md)"
fi

if [ "$DRY_RUN" = 0 ]; then
  # Merge with any earlier manifest so uninstall also catches files from older versions.
  { [ -f "$MANIFEST" ] && cat "$MANIFEST"; printf '%s\n' "${NEW_MANIFEST[@]}"; } | sort -u > "$MANIFEST.tmp"
  mv "$MANIFEST.tmp" "$MANIFEST"
  [ "$backed_up" -gt 0 ] && warn "$backed_up existing file(s) differed and were backed up to $BACKUP_DIR"
fi

if [ "$INSTALL_PLUGIN" = 1 ]; then
  if [ "$DRY_RUN" = 1 ]; then
    echo -e "Plugin:   would run: claude plugin marketplace add $MARKETPLACE_SOURCE"
    echo -e "          would run: claude plugin install $PLUGIN_NAME@$MARKETPLACE_NAME"
  else
    echo -e "Plugin:   installing ${GREEN}$PLUGIN_NAME${NC}..."
    if claude plugin marketplace add "$MARKETPLACE_SOURCE" >/dev/null 2>&1 || claude plugin marketplace update "$MARKETPLACE_NAME" >/dev/null 2>&1; then
      if claude plugin install "$PLUGIN_NAME@$MARKETPLACE_NAME" >/dev/null 2>&1; then
        echo -e "          ${GREEN}✓${NC} $PLUGIN_NAME@$MARKETPLACE_NAME"
      else
        warn "plugin install failed. Run it yourself: claude plugin install $PLUGIN_NAME@$MARKETPLACE_NAME"
      fi
    else
      warn "could not add the $MARKETPLACE_NAME marketplace. Inside Claude Code run:"
      warn "  /plugin marketplace add $MARKETPLACE_SOURCE"
      warn "  /plugin install $PLUGIN_NAME@$MARKETPLACE_NAME"
    fi
  fi
fi

echo ""
if [ "$DRY_RUN" = 1 ]; then
  echo -e "${GREEN}Dry run complete.${NC} Re-run without --dry-run to install."
else
  echo -e "${GREEN}✓ Done!${NC} Founders Kit is installed. Restart Claude Code to pick up new agents."
fi
echo ""
echo "Quick start:"
echo -e "  ${YELLOW}/founders-kit:founder \"build a streaming chat interface\"${NC}"
echo -e "  ${YELLOW}/review${NC}             ← review current file"
echo -e "  ${YELLOW}/prd \"your idea\"${NC}    ← write a PRD"
echo ""
echo "Uninstall: curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash"
echo "Docs:      $REPO_URL"
echo ""
