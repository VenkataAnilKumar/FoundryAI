# README demo

`assets/demo.gif` (and `demo.mp4`, `demo.cast`) is a **real recording**, not an animation:

1. A fresh, empty home directory.
2. The one-line installer is fetched from GitHub and installs FoundryAI for Claude Code.
3. `claude -p` asks the installed `founder` agent a real question. The answer is generated live by the model.

What's adjusted for the recording, and only this:

- Commands are typed by `demo-session.sh` so viewers can read them.
- The ~40 s wait for the answer is compressed (asciinema idle limit). The recording says so on screen.
- The answer's Markdown is rendered with [rich](https://github.com/Textualize/rich) for readability. The words are the model's, unchanged.
- Claude Code's debug output on stderr is hidden.

Each recording gets a new live answer, so re-recording produces a different (but equally real) result.

## Re-record

```bash
pip install pyte pillow rich asciinema
scripts/demo/record.sh
```

Requires a logged-in Claude Code (`claude`), `ffmpeg`, and the JetBrains Mono font.

The raw terminal recording is in `assets/demo.cast`. You can replay it exactly with `asciinema play assets/demo.cast`.
