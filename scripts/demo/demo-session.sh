#!/usr/bin/env bash
# Scripted demo: "types" each command, then runs it for real.
# Usage: demo-session.sh <fresh-empty-home-dir> <project-dir>   (run by record.sh)
export HOME="$1" PS1='$ '
cd "$2" || exit 1
# Hide CLI debug noise on stderr, and render the answer's Markdown for readability (words unchanged).
claude() { command claude "$@" 2>/dev/null | python3 -c "import sys; from rich.console import Console; from rich.markdown import Markdown; Console(width=106, force_terminal=True, color_system='256').print(Markdown(sys.stdin.read()))"; }
G='\033[1;32m'; B='\033[1;34m'; D='\033[2;37m'; N='\033[0m'
prompt() { printf "${G}~/clinic-voice-ai${N} ${B}\$${N} "; }
type_cmd() { prompt; local s="$1" i; for ((i=0;i<${#s};i++)); do printf '%s' "${s:i:1}"; sleep 0.022; done; sleep 0.5; printf '\n'; }
say() { printf "${D}%s${N}\n" "$1"; sleep 1.2; }

clear
say "# 1. Install FoundryAI: one line, any AI workspace"
CMD='curl -fsSL https://raw.githubusercontent.com/VenkataAnilKumar/FoundryAI/master/install.sh | bash -s -- --target claude'
type_cmd "$CMD"
eval "$CMD" 2>&1 | grep -vE "^(Try:|      /prd|Uninstall:|Docs:)" | cat -s
sleep 2.5
clear
say "# 2. Ask your AI co-founder a real question (live answer, not scripted)"
Q="Use the founder agent. We're a 2-person voice AI startup at MVP stage: our phone agent books appointments for dental clinics. Calls feel slow (about 2.5s per reply) and cost \$0.40/min. What should we do this week? Answer in under 20 lines."
type_cmd "claude -p \"$Q\""
printf "${D}  … the founder agent is working (about 40s live, sped up in this recording)${N}\n\n"
claude -p "$Q"
sleep 6
