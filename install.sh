#!/usr/bin/env bash
# FoundryAI — installer for any AI workspace
#
#   curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- --target cursor --target codex
#   ./install.sh --dry-run                      # from a local clone
#
# Options:
#   --target NAME  claude | cursor | copilot | codex | gemini | chat | all  (repeatable)
#                  Default: every workspace detected on this machine.
#   --dry-run      show what would be installed; change nothing
#   --hooks        also copy the Claude Code hook scripts to ~/.claude/hooks
#
# Files that would be overwritten with different content are backed up to
# ~/.foundryai/backup/<timestamp>/ first. Every installed file is recorded in
# ~/.foundryai/manifest so uninstall.sh removes exactly what was installed.
# Requires git (when not run from a clone) and python3.

set -euo pipefail

REPO_URL="https://github.com/VenkataAnilKumar/FoundryAI"
ALL_TARGETS="claude cursor copilot codex gemini chat"
STATE_DIR="$HOME/.foundryai"
MANIFEST="$STATE_DIR/manifest"
LEGACY_MANIFEST="$HOME/.claude/founders-kit.manifest"
BACKUP_DIR="$STATE_DIR/backup/$(date +%Y%m%d-%H%M%S)"

DRY_RUN=0
INSTALL_HOOKS=0
TARGETS=""
while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --hooks) INSTALL_HOOKS=1 ;;
    --target) shift; TARGETS="$TARGETS ${1:?--target needs a value}" ;;
    --target=*) TARGETS="$TARGETS ${1#--target=}" ;;
    -h|--help) { sed -n "2,18p" "$0" | sed "s/^# \{0,1\}//"; } 2>/dev/null || true; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ -t 1 ]; then
  GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
else
  GREEN=''; BLUE=''; YELLOW=''; RED=''; NC=''
fi
warn() { echo -e "${YELLOW}warning:${NC} $*" >&2; }
die() { echo -e "${RED}error:${NC} $*" >&2; exit 1; }

echo ""
echo -e "${BLUE}FoundryAI — an AI startup team for any AI workspace${NC}"
echo "────────────────────────────────────────────────────────"
[ "$DRY_RUN" = 1 ] && echo -e "${YELLOW}Dry run — nothing will be changed.${NC}"
echo ""

command -v python3 >/dev/null 2>&1 || die "python3 is required to build FoundryAI for your workspaces."

# --- which workspaces --------------------------------------------------------
detect() {
  case "$1" in
    claude)  command -v claude >/dev/null 2>&1 || [ -d "$HOME/.claude" ] ;;
    cursor)  command -v cursor >/dev/null 2>&1 || [ -d "$HOME/.cursor" ] ;;
    copilot) command -v code >/dev/null 2>&1 || [ -d "$HOME/.copilot" ] || [ -d "$HOME/.vscode" ] ;;
    codex)   command -v codex >/dev/null 2>&1 || [ -d "$HOME/.codex" ] ;;
    gemini)  command -v gemini >/dev/null 2>&1 || [ -d "$HOME/.gemini" ] ;;
    *) return 1 ;;
  esac
}

if [ -z "${TARGETS// }" ]; then
  for t in claude cursor copilot codex gemini; do
    detect "$t" && TARGETS="$TARGETS $t"
  done
  if [ -z "${TARGETS// }" ]; then
    die "no supported AI workspace detected. Choose one with --target ($ALL_TARGETS)."
  fi
  echo "Detected:$TARGETS"
fi
case " $TARGETS " in *" all "*) TARGETS="$ALL_TARGETS" ;; esac
for t in $TARGETS; do
  case " $ALL_TARGETS " in *" $t "*) ;; *) die "unknown target '$t' (choose from: $ALL_TARGETS all)" ;; esac
done

# --- get the source and build ------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/scripts/build.py" ]; then
  SRC="$SCRIPT_DIR"
else
  command -v git >/dev/null 2>&1 || die "git is required."
  echo "Downloading..."
  git clone --depth 1 --quiet "$REPO_URL" "$TMP_DIR/FoundryAI"
  SRC="$TMP_DIR/FoundryAI"
fi

BUILD_ARGS=()
for t in $TARGETS; do BUILD_ARGS+=(--target "$t"); done
python3 "$SRC/scripts/build.py" --out "$TMP_DIR/dist" --no-plugin "${BUILD_ARGS[@]}" >/dev/null

# --- install -----------------------------------------------------------------
NEW_MANIFEST=()
backed_up=0
install_tree() { # install_tree <built-dir>: copy every file to the same path under $HOME
  local root="$1" src rel dest
  while IFS= read -r src; do
    rel="${src#"$root"/}"
    dest="$HOME/$rel"
    NEW_MANIFEST+=("$dest")
    [ "$DRY_RUN" = 1 ] && continue
    if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
      mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
      cp "$dest" "$BACKUP_DIR/$rel"
      backed_up=$((backed_up + 1))
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
  done < <(find "$root" -type f | sort)
}

label() {
  case "$1" in
    claude)  echo "Claude Code     → ~/.claude/agents, ~/.claude/skills" ;;
    cursor)  echo "Cursor          → ~/.cursor/agents, ~/.agents/skills" ;;
    copilot) echo "Copilot/VS Code → ~/.copilot/agents, ~/.copilot/skills" ;;
    codex)   echo "Codex CLI       → ~/.codex/agents, ~/.agents/skills" ;;
    gemini)  echo "Gemini CLI      → ~/.gemini/agents, ~/.agents/skills" ;;
    chat)    echo "Chat workspaces → ~/FoundryAI-chat-prompts (paste into ChatGPT, Claude, Gemini projects)" ;;
  esac
}

for t in $TARGETS; do
  install_tree "$TMP_DIR/dist/$t"
  echo -e "  ${GREEN}✓${NC} $(label "$t")"
done

if [ "$INSTALL_HOOKS" = 1 ]; then
  case " $TARGETS " in
    *" claude "*)
      [ "$DRY_RUN" = 1 ] || mkdir -p "$HOME/.claude/hooks"
      for f in "$SRC"/templates/hooks/*.sh; do
        dest="$HOME/.claude/hooks/$(basename "$f")"
        NEW_MANIFEST+=("$dest")
        [ "$DRY_RUN" = 1 ] || { cp "$f" "$dest"; chmod +x "$dest"; }
      done
      echo -e "  ${GREEN}✓${NC} Claude Code hooks → ~/.claude/hooks (register them: templates/hooks-setup.md)" ;;
    *) warn "--hooks only applies to Claude Code; skipped." ;;
  esac
fi

# --- clean up files from 1.x/2.x installs (slash commands are now skills) ------
legacy_removed=0
if [ -f "$LEGACY_MANIFEST" ]; then
  while IFS= read -r old; do
    case "$old" in
      "$HOME/.claude/commands/"*.md)
        name="$(basename "$old" .md)"
        if [ -f "$old" ] && { [ -d "$SRC/skills/$name" ] || [ "$name" = founder ]; }; then
          if [ "$DRY_RUN" = 1 ]; then
            echo "  would remove old slash command $old (now a skill)"
          else
            mkdir -p "$BACKUP_DIR/.claude/commands"
            mv "$old" "$BACKUP_DIR/.claude/commands/"
          fi
          legacy_removed=$((legacy_removed + 1))
        fi ;;
      *) [ -f "$old" ] && NEW_MANIFEST+=("$old") ;;
    esac
  done < "$LEGACY_MANIFEST"
  [ "$DRY_RUN" = 1 ] || rm -f "$LEGACY_MANIFEST"
fi

if [ "$DRY_RUN" = 0 ]; then
  mkdir -p "$STATE_DIR"
  { [ -f "$MANIFEST" ] && cat "$MANIFEST"; printf '%s\n' "${NEW_MANIFEST[@]}"; } | sort -u > "$MANIFEST.tmp"
  mv "$MANIFEST.tmp" "$MANIFEST"
  [ "$backed_up" -gt 0 ] && warn "$backed_up existing file(s) differed and were backed up to $BACKUP_DIR"
  [ "$legacy_removed" -gt 0 ] && warn "moved $legacy_removed old slash command(s) from ~/.claude/commands to $BACKUP_DIR (they are skills now)"
fi

echo ""
echo "${#NEW_MANIFEST[@]} files $([ "$DRY_RUN" = 1 ] && echo "would be installed" || echo installed)."
echo ""
if [ "$DRY_RUN" = 1 ]; then
  echo -e "${GREEN}Dry run complete.${NC} Re-run without --dry-run to install."
else
  echo -e "${GREEN}✓ Done!${NC} Restart your AI workspace to pick up the new agents and skills."
fi
echo ""
echo "Try:  /cofounder \"build a RAG-powered document search\"   (or ask: use the founder agent to …)"
echo "      /prd \"your idea\"     /review     /launch-check"
case " $TARGETS " in *" gemini "*)
  echo ""
  echo "Gemini CLI: to also load project AGENTS.md files, add to ~/.gemini/settings.json:"
  echo '      { "context": { "fileName": ["AGENTS.md", "GEMINI.md"] } }' ;;
esac
echo ""
echo "Uninstall: curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/main/uninstall.sh | bash"
echo "Docs:      $REPO_URL"
echo ""
