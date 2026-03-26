#!/usr/bin/env bash
# Founders Kit — Install Script
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/claude-agents/main/install.sh | bash

set -e

REPO_URL="https://github.com/yourusername/claude-agents"
AGENTS_DIR="$HOME/.claude/agents"
COMMANDS_DIR="$HOME/.claude/commands"
PLUGIN_DIR="$HOME/.claude/plugins/founders-kit"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${BLUE}Founders Kit — Your AI co-founder + 34 specialist agents${NC}"
echo "────────────────────────────────────────────────────────"
echo ""

# Check Claude Code is installed
if ! command -v claude &> /dev/null; then
  echo "Claude Code is not installed. Install it first:"
  echo "  https://claude.ai/code"
  exit 1
fi

# Create directories
mkdir -p "$AGENTS_DIR" "$COMMANDS_DIR"

# Clone or pull
TMP_DIR=$(mktemp -d)
echo "Downloading..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR/claude-agents" --quiet

# Install agents
echo -e "Installing ${GREEN}35 agents${NC}..."
cp "$TMP_DIR/claude-agents/agents/"*.md "$AGENTS_DIR/"

# Install skills
echo -e "Installing ${GREEN}20 skills${NC}..."
cp "$TMP_DIR/claude-agents/skills/"*.md "$COMMANDS_DIR/"

# Install plugin
echo -e "Installing ${GREEN}founders-kit plugin${NC}..."
mkdir -p "$PLUGIN_DIR/.claude-plugin" "$PLUGIN_DIR/commands"
cp -r "$TMP_DIR/claude-agents/plugin/." "$PLUGIN_DIR/"
claude plugin add "$PLUGIN_DIR" --quiet 2>/dev/null || true

# Cleanup
rm -rf "$TMP_DIR"

echo ""
echo -e "${GREEN}✓ Done!${NC} Founders Kit is installed."
echo ""
echo "Quick start:"
echo -e "  ${YELLOW}/founder \"build a streaming chat interface\"${NC}"
echo -e "  ${YELLOW}/review${NC}             ← review current file"
echo -e "  ${YELLOW}/prd \"your idea\"${NC}    ← write a PRD"
echo ""
echo "Full docs: $REPO_URL"
echo ""
