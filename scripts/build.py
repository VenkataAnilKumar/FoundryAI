#!/usr/bin/env python3
"""Build FoundryAI for every supported AI workspace from one neutral source.

Source of truth:
  agents/<name>.md                  neutral agent: name, description, tier, capabilities + prompt
  agents/_shared/*.md               appended to every agent prompt
  skills/<name>/SKILL.md            Agent Skills standard (agentskills.io)

Output (each target mirrors paths relative to $HOME, so installing = copying the tree):
  dist/claude/    .claude/agents/*.md            .claude/skills/<n>/SKILL.md
  dist/cursor/    .cursor/agents/*.md            .agents/skills/<n>/SKILL.md
  dist/copilot/   .copilot/agents/*.agent.md     .copilot/skills/<n>/SKILL.md
  dist/codex/     .codex/agents/*.toml           .agents/skills/<n>/SKILL.md
  dist/gemini/    .gemini/agents/*.md            .agents/skills/<n>/SKILL.md
  dist/chat/      FoundryAI-chat-prompts/...     plain-text prompts for chat workspaces
  plugin/agents, plugin/skills                   the Claude Code plugin (committed)

Usage:
  scripts/build.py                       # build every target into dist/ and refresh plugin/
  scripts/build.py --target cursor       # one target (repeatable)
  scripts/build.py --out /tmp/x          # different output directory
  scripts/build.py --check               # exit 1 if plugin/ is out of date (CI)

Needs only the Python 3.8+ standard library.
"""
import argparse
import json
import pathlib
import re
import shutil
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
TARGETS = ["claude", "cursor", "copilot", "codex", "gemini", "chat"]
NON_AGENT_FILES = {"README.md", "WORKFLOWS.md"}
CAPABILITIES = {"read", "edit", "shell", "web", "delegate"}
TIERS = {"deep", "standard", "fast"}

ARGS_NEUTRAL = (
    "_(The user's request: the message that invoked this skill, plus anything they typed after "
    "its name. If it is empty, ask what they need.)_"
)


# --- source parsing -----------------------------------------------------------

def parse_frontmatter(path):
    """Minimal YAML-frontmatter parser: `key: value`, JSON-quoted strings and [a, b] lists."""
    text = path.read_text(encoding="utf-8")
    m = re.match(r"^---\n(.*?)\n---\n?", text, re.S)
    if not m:
        raise ValueError(f"{path}: missing frontmatter")
    meta = {}
    for line in m.group(1).splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        key, sep, value = line.partition(":")
        if not sep:
            raise ValueError(f"{path}: bad frontmatter line: {line!r}")
        value = value.split("  #", 1)[0].strip()
        if value.startswith('"'):
            value = json.loads(value)
        elif value.startswith("[") and value.endswith("]"):
            value = [v.strip() for v in value[1:-1].split(",") if v.strip()]
        meta[key.strip()] = value
    return meta, text[m.end():].lstrip("\n")


def load_agents():
    shared = "\n\n".join(
        p.read_text(encoding="utf-8").strip()
        for p in sorted((ROOT / "agents" / "_shared").glob("*.md"))
    )
    agents = []
    for p in sorted((ROOT / "agents").glob("*.md")):
        if p.name in NON_AGENT_FILES:
            continue
        meta, body = parse_frontmatter(p)
        caps = meta.get("capabilities", [])
        if isinstance(caps, str):
            caps = [caps]
        unknown = set(caps) - CAPABILITIES
        if unknown:
            raise ValueError(f"{p}: unknown capabilities {sorted(unknown)}")
        if meta.get("tier") not in TIERS:
            raise ValueError(f"{p}: tier must be one of {sorted(TIERS)}")
        agents.append({
            "name": meta["name"],
            "description": meta["description"],
            "tier": meta["tier"],
            "caps": set(caps) | {"read"},
            "body": body.rstrip() + ("\n\n---\n\n" + shared if shared else "") + "\n",
        })
    return agents


def load_skills():
    skills = []
    for d in sorted(p for p in (ROOT / "skills").iterdir() if p.is_dir()):
        path = d / "SKILL.md"
        meta, body = parse_frontmatter(path)
        skills.append({"name": meta["name"], "meta": meta, "body": body, "dir": d})
    return skills


# --- emit helpers -----------------------------------------------------------------

def q(s):
    """A YAML double-quoted scalar (JSON strings are valid YAML)."""
    return json.dumps(s, ensure_ascii=False)


def frontmatter(fields):
    lines = ["---"]
    for k, v in fields:
        if v is None:
            continue
        if isinstance(v, bool):
            lines.append(f"{k}: {'true' if v else 'false'}")
        elif isinstance(v, list):
            lines.append(f"{k}: [{', '.join(q(x) for x in v)}]")
        else:
            lines.append(f"{k}: {q(v) if isinstance(v, str) else v}")
    lines.append("---")
    return "\n".join(lines) + "\n\n"


def toml_multiline(s):
    return '"""\n' + s.replace("\\", "\\\\").replace('"""', '\\"""') + '"""'


def write(out, rel, content):
    path = out / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def skill_file(skill, keep_arguments):
    meta = skill["meta"]
    body = skill["body"]
    if not keep_arguments:
        body = body.replace("$ARGUMENTS", ARGS_NEUTRAL)
    fields = [("name", skill["name"]), ("description", meta["description"])]
    if meta.get("argument-hint"):
        fields.append(("argument-hint", meta["argument-hint"]))
    return frontmatter(fields) + body


def copy_skill_assets(skill, dest_dir):
    """Copy anything besides SKILL.md (scripts/, references/, assets/)."""
    for item in skill["dir"].iterdir():
        if item.name == "SKILL.md":
            continue
        target = dest_dir / item.name
        if item.is_dir():
            shutil.copytree(item, target, dirs_exist_ok=True)
        else:
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(item, target)


def emit_skills(out, base, skills, keep_arguments=False):
    for s in skills:
        write(out, f"{base}/{s['name']}/SKILL.md", skill_file(s, keep_arguments))
        copy_skill_assets(s, out / base / s["name"])


# --- targets --------------------------------------------------------------------

def claude_agent(a):
    tools = ["Read", "Grep", "Glob"]
    if "edit" in a["caps"]:
        tools += ["Write", "Edit"]
    if "shell" in a["caps"]:
        tools.append("Bash")
    if "web" in a["caps"]:
        tools += ["WebSearch", "WebFetch"]
    if "delegate" in a["caps"]:
        tools.append("Agent")
    tools.append("Skill")
    model = {"deep": "opus", "standard": "sonnet", "fast": "haiku"}[a["tier"]]
    return frontmatter([
        ("name", a["name"]),
        ("description", a["description"]),
        ("tools", ", ".join(tools)),
        ("model", model),
    ]) + a["body"]


def build_claude(out, agents, skills):
    for a in agents:
        write(out, f".claude/agents/{a['name']}.md", claude_agent(a))
    emit_skills(out, ".claude/skills", skills, keep_arguments=True)


def build_cursor(out, agents, skills):
    # Cursor subagents inherit the parent's tools; only `readonly` restricts them.
    for a in agents:
        fields = [("name", a["name"]), ("description", a["description"]), ("model", "inherit")]
        if "edit" not in a["caps"] and "shell" not in a["caps"]:
            fields.append(("readonly", True))
        write(out, f".cursor/agents/{a['name']}.md", frontmatter(fields) + a["body"])
    emit_skills(out, ".agents/skills", skills)


def build_copilot(out, agents, skills):
    for a in agents:
        tools = ["read", "search"]
        if "edit" in a["caps"]:
            tools.append("edit")
        if "shell" in a["caps"]:
            tools.append("execute")
        if "web" in a["caps"]:
            tools.append("web")
        if "delegate" in a["caps"]:
            tools.append("agent")
        tools.append("todo")
        fields = [("name", a["name"]), ("description", a["description"]), ("tools", tools)]
        write(out, f".copilot/agents/{a['name']}.agent.md", frontmatter(fields) + a["body"])
    emit_skills(out, ".copilot/skills", skills)


def build_codex(out, agents, skills):
    effort = {"deep": "high", "standard": "medium", "fast": "low"}
    for a in agents:
        lines = [
            f"name = {q(a['name'])}",
            f"description = {q(a['description'])}",
            f"model_reasoning_effort = {q(effort[a['tier']])}",
            f"developer_instructions = {toml_multiline(a['body'])}",
        ]
        if "shell" not in a["caps"]:
            lines += ["", "[features]", "shell_tool = false"]
        write(out, f".codex/agents/{a['name']}.toml", "\n".join(lines) + "\n")
    emit_skills(out, ".agents/skills", skills)


def build_gemini(out, agents, skills):
    # Omitting `tools` makes a Gemini subagent inherit the parent session's tools.
    for a in agents:
        fields = [("name", a["name"]), ("description", a["description"]), ("kind", "local")]
        write(out, f".gemini/agents/{a['name']}.md", frontmatter(fields) + a["body"])
    emit_skills(out, ".agents/skills", skills)


CHAT_README = """# FoundryAI — prompts for chat workspaces

Use these in workspaces that don't load agent or skill files: ChatGPT Projects and custom GPTs,
Claude Projects, Gemini Gems, Microsoft Copilot notebooks, and similar.

- `agents/<name>.md` — paste into a project's or GPT's **instructions** to make it that specialist.
  If the instructions box has a size limit (custom GPTs allow about 8,000 characters), upload the
  file as a knowledge file instead and set the instructions to: "Follow agents/<name>.md".
- `skills/<name>.md` — paste at the start of a chat, followed by your request, to run that skill.
- `routing-guide.md` — upload as a knowledge file to a general project so it knows which
  specialist or skill fits a request.

Chat workspaces can't run other agents or tools for you, so when a prompt says to delegate,
the assistant will name the right specialist and take on that role when you ask it to continue.
"""


def build_chat(out, agents, skills):
    base = "FoundryAI-chat-prompts"
    write(out, f"{base}/README.md", CHAT_README)
    routing = [
        "# FoundryAI routing guide",
        "",
        "Pick the specialist or skill that fits the request.",
        "",
        "## Specialists",
        "",
    ]
    for a in agents:
        write(out, f"{base}/agents/{a['name']}.md",
              f"# {a['name']}\n\n**Use when:** {a['description']}\n\n{a['body']}")
        routing.append(f"- **{a['name']}**: {a['description']}")
    routing += ["", "## Skills", ""]
    for s in skills:
        body = s["body"].replace("$ARGUMENTS", ARGS_NEUTRAL)
        write(out, f"{base}/skills/{s['name']}.md",
              f"# Skill: {s['name']}\n\n{s['meta']['description']}\n\n{body}")
        routing.append(f"- **{s['name']}**: {s['meta']['description']}")
    write(out, f"{base}/routing-guide.md", "\n".join(routing) + "\n")


BUILDERS = {
    "claude": build_claude,
    "cursor": build_cursor,
    "copilot": build_copilot,
    "codex": build_codex,
    "gemini": build_gemini,
    "chat": build_chat,
}


# --- Claude Code plugin (committed, so the marketplace can serve it) -------------

def build_plugin(dest, agents, skills):
    for sub in ("agents", "skills"):
        shutil.rmtree(dest / sub, ignore_errors=True)
    for a in agents:
        write(dest, f"agents/{a['name']}.md", claude_agent(a))
    emit_skills(dest, "skills", skills, keep_arguments=True)


def tree(path):
    return {
        p.relative_to(path).as_posix(): p.read_bytes()
        for p in sorted(path.rglob("*")) if p.is_file()
    } if path.exists() else {}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--target", action="append", choices=TARGETS + ["all"])
    ap.add_argument("--out", default=str(ROOT / "dist"))
    ap.add_argument("--check", action="store_true", help="fail if plugin/ is out of date")
    ap.add_argument("--no-plugin", action="store_true", help="don't refresh plugin/")
    args = ap.parse_args()

    agents, skills = load_agents(), load_skills()

    if args.check:
        import tempfile
        with tempfile.TemporaryDirectory() as tmp:
            fresh = pathlib.Path(tmp)
            build_plugin(fresh, agents, skills)
            current = {k: v for k, v in tree(ROOT / "plugin").items()
                       if k.startswith(("agents/", "skills/"))}
            if tree(fresh) != current:
                print("plugin/ is out of date — run scripts/build.py", file=sys.stderr)
                sys.exit(1)
        print(f"build: plugin up to date ({len(agents)} agents, {len(skills)} skills)")
        return

    targets = TARGETS if not args.target or "all" in args.target else args.target
    out_root = pathlib.Path(args.out)
    for t in targets:
        out = out_root / t
        shutil.rmtree(out, ignore_errors=True)
        out.mkdir(parents=True)
        BUILDERS[t](out, agents, skills)
    if not args.no_plugin:
        build_plugin(ROOT / "plugin", agents, skills)
    print(f"build: {len(agents)} agents, {len(skills)} skills → {', '.join(targets)} in {out_root}")


if __name__ == "__main__":
    main()
