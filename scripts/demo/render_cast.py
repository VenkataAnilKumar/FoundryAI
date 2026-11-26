"""Render an asciinema v2 cast into PNG frames + an ffmpeg concat list.

Usage: python3 render_cast.py demo.cast outdir
"""
import json
import pathlib
import sys

import pyte
from PIL import Image, ImageDraw, ImageFont

cast_path, outdir = sys.argv[1], pathlib.Path(sys.argv[2])
outdir.mkdir(parents=True, exist_ok=True)

lines = pathlib.Path(cast_path).read_text().splitlines()
header = json.loads(lines[0])
COLS, ROWS = header["width"], header["height"]
events = [json.loads(l) for l in lines[1:] if l.strip()]
events = [(t, d) for t, kind, d in events if kind == "o"]

FONT_DIR = "/usr/share/fonts/truetype/jetbrains-mono/"
font = ImageFont.truetype(FONT_DIR + "JetBrainsMono-Regular.ttf", 16)
bold = ImageFont.truetype(FONT_DIR + "JetBrainsMono-Bold.ttf", 16)
CW = int(font.getlength("M"))
CH = 23
PAD = 22
TITLE = 40
W = PAD * 2 + COLS * CW
H = TITLE + PAD * 2 + ROWS * CH

# Catppuccin Mocha palette
BG = (30, 30, 46)
BAR = (24, 24, 37)
FG = (205, 214, 244)
DIM = (127, 132, 156)
PALETTE = {
    "black": (69, 71, 90), "red": (243, 139, 168), "green": (166, 227, 161),
    "brown": (249, 226, 175), "yellow": (249, 226, 175), "blue": (137, 180, 250),
    "magenta": (203, 166, 247), "cyan": (148, 226, 213), "white": (205, 214, 244),
    "default": FG,
}

screen = pyte.Screen(COLS, ROWS)
stream = pyte.ByteStream(screen)


def chrome(img):
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, W - 1, H - 1], radius=14, fill=BG)
    d.rounded_rectangle([0, 0, W - 1, TITLE + 10], radius=14, fill=BAR)
    d.rectangle([0, TITLE - 4, W - 1, TITLE + 10], fill=BG)
    d.rectangle([0, TITLE - 14, W - 1, TITLE - 4], fill=BAR)
    for i, c in enumerate([(243, 139, 168), (249, 226, 175), (166, 227, 161)]):
        x = 24 + i * 24
        d.ellipse([x - 7, 13, x + 7, 27], fill=c)
    title = "FoundryAI — real install + live answer (Claude Code)"
    tw = font.getlength(title)
    d.text(((W - tw) / 2, 10), title, font=font, fill=DIM)
    return d


def render():
    img = Image.new("RGB", (W, H), (0, 0, 0))
    d = chrome(img)
    for y in range(ROWS):
        row = screen.buffer[y]
        for x in range(COLS):
            ch = row[x]
            if ch.data in (" ", ""):
                continue
            if len(ch.fg) == 6 and all(c in "0123456789abcdef" for c in ch.fg.lower()):
                color = tuple(int(ch.fg[k:k + 2], 16) for k in (0, 2, 4))
            else:
                color = PALETTE.get(ch.fg, FG)
            if ch.fg == "white" and not ch.bold:
                color = DIM  # our "dim" comments use 2;37
            d.text((PAD + x * CW, TITLE + PAD + y * CH), ch.data,
                   font=bold if ch.bold else font, fill=color)
    if not screen.cursor.hidden:
        cx, cy = screen.cursor.x, screen.cursor.y
        d.rectangle([PAD + cx * CW, TITLE + PAD + cy * CH + 2,
                     PAD + cx * CW + CW - 2, TITLE + PAD + cy * CH + CH - 2], fill=FG)
    return img


# Emit a frame at most every 70 ms of recording time (and always before a pause),
# then compute each frame's display time from the next frame's timestamp.
emitted = []  # (time, name)
prev_bytes, last_emit, idx = None, -1.0, 0
for i, (t, data) in enumerate(events):
    stream.feed(data.encode())
    is_last = i + 1 == len(events)
    next_t = events[i + 1][0] if not is_last else t
    if not is_last and t - last_emit < 0.07 and next_t - t < 0.3:
        continue
    last_emit = t
    img = render()
    b = img.tobytes()
    if b == prev_bytes:
        continue
    name = f"f{idx:05d}.png"
    img.save(outdir / name)
    emitted.append((t, name))
    prev_bytes, idx = b, idx + 1

concat = []
for k, (t, name) in enumerate(emitted):
    if k + 1 < len(emitted):
        dur = emitted[k + 1][0] - t
        if dur >= 2.4:
            dur = 4.5  # give viewers time to read at natural pauses
    else:
        dur = 16.0  # hold the final answer
    concat.append([name, max(dur, 0.04)])

with open(outdir / "frames.txt", "w") as f:
    for name, dur in concat:
        f.write(f"file '{name}'\nduration {dur:.3f}\n")
    f.write(f"file '{concat[-1][0]}'\n")
total = sum(d for _, d in concat)
print(f"{idx} frames, {total:.1f}s, {W}x{H}")
