#!/usr/bin/env bash
# Record the README demo: a real FoundryAI install from GitHub, then a live question to the
# founder agent in Claude Code. Nothing is scripted except the typing.
#
# Requirements: Claude Code (`claude`, logged in), python3, asciinema, ffmpeg,
#               pip packages: pyte pillow rich, and the JetBrains Mono font.
# Usage:        scripts/demo/record.sh            # writes assets/demo.{cast,gif,mp4}
set -euo pipefail
cd "$(dirname "$0")/../.." || exit 1

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/home" "$work/project" "$work/frames"

# A fresh, empty HOME so the recording shows a clean install and none of your own config.
asciinema rec --overwrite -q -y -i 2.5 --cols 110 --rows 46 \
  -c "bash scripts/demo/demo-session.sh $work/home $work/project" assets/demo.cast </dev/null

python3 scripts/demo/render_cast.py assets/demo.cast "$work/frames"
(
  cd "$work/frames"
  ffmpeg -v error -y -f concat -safe 0 -i frames.txt \
    -vf "split[a][b];[a]palettegen=max_colors=64:stats_mode=diff[p];[b][p]paletteuse=dither=none" \
    -loop 0 "$OLDPWD/assets/demo.gif"
  ffmpeg -v error -y -f concat -safe 0 -i frames.txt \
    -vf "fps=30,format=yuv420p" -c:v libx264 -crf 20 -movflags +faststart "$OLDPWD/assets/demo.mp4"
)
ls -la assets/demo.*
