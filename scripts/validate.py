#!/usr/bin/env python3
"""Consistency checks for FoundryAI. Run via scripts/validate.sh (used by CI).

Checks:
  - every agent has valid frontmatter: name matches file, description, model alias, valid tools
  - every skill has a description
  - every agent name referenced in docs/agents/skills/templates actually exists
  - README / plugin / marketplace counts match the files on disk
  - every agent and skill is listed in README
  - JSON files parse; no pinned or retired model IDs
"""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
VALID_MODELS = {"opus", "sonnet", "haiku", "fable", "inherit"}
VALID_TOOLS = {
    "Read", "Write", "Edit", "MultiEdit", "NotebookEdit", "Bash", "Grep", "Glob",
    "WebSearch", "WebFetch", "Agent", "Task", "TodoWrite", "Skill",
}
# Files that mention example/hypothetical agent names on purpose.
REFERENCE_ALLOWLIST = {"CONTRIBUTING.md", "CHANGELOG.md"}
AGENT_DOC_FILES = {"README.md", "CLAUDE.md", "WORKFLOWS.md"}  # live in agents/ but aren't agents

errors = []


def err(path, msg):
    errors.append(f"{path.relative_to(ROOT) if isinstance(path, pathlib.Path) else path}: {msg}")


def frontmatter(path):
    text = path.read_text(encoding="utf-8")
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        return None
    fields = {}
    for line in m.group(1).splitlines():
        k, sep, v = line.partition(":")
        if sep and re.fullmatch(r"[a-z][a-z-]*", k.strip()):
            fields[k.strip()] = v.strip()
    return fields


# --- agents ----------------------------------------------------------------
agents = {}
for p in sorted((ROOT / "agents").glob("*.md")):
    if p.name in AGENT_DOC_FILES:
        continue
    fm = frontmatter(p)
    if fm is None:
        err(p, "missing YAML frontmatter")
        continue
    if fm.get("name") != p.stem:
        err(p, f"frontmatter name '{fm.get('name')}' does not match file name '{p.stem}'")
    if not fm.get("description"):
        err(p, "missing description")
    model = fm.get("model")
    if model not in VALID_MODELS:
        err(p, f"model '{model}' should be one of {sorted(VALID_MODELS)} (use an alias, not a model ID)")
    tools = [t.strip() for t in fm.get("tools", "").split(",") if t.strip()]
    for t in tools:
        if t not in VALID_TOOLS and not t.startswith("mcp__"):
            err(p, f"unknown tool '{t}' (tool names are case-sensitive)")
    agents[p.stem] = fm

specialists = sorted(n for n in agents if not n.startswith("team-"))
coordinators = sorted(n for n in agents if n.startswith("team-"))

# --- skills ----------------------------------------------------------------
skills = {}
for p in sorted((ROOT / "skills").glob("*.md")):
    fm = frontmatter(p)
    if fm is None or not fm.get("description"):
        err(p, "missing frontmatter description")
    skills[p.stem] = fm or {}

# --- agent references -------------------------------------------------------
role = r"(?:engineer|manager|designer|expert|architect|researcher|advisor|analyst|writer|advocate|orchestrator)"
ref_patterns = [
    re.compile(r"`((?:ai|team)-[a-z0-9]+(?:-[a-z0-9]+)*)`"),
    re.compile(r"\b((?:ai|team)-[a-z0-9]+(?:-[a-z0-9]+)*-" + role + r")\b"),
    re.compile(r"\b(team-(?:leadership|architecture|engineering|platform|product|data-ai|growth|knowledge|safety|manager))\b"),
]
scan = [ROOT / "README.md", ROOT / "INSTALL.md", ROOT / "DEMO.md"]
for d in ("agents", "skills", "plugin/commands", "templates", "docs"):
    scan += sorted((ROOT / d).glob("*.md"))
for p in scan:
    if p.name in REFERENCE_ALLOWLIST or not p.exists():
        continue
    text = p.read_text(encoding="utf-8")
    found = set()
    for pat in ref_patterns:
        for m in pat.finditer(text):
            name = m.group(1)
            if name not in agents:
                found.add((text.count("\n", 0, m.start()) + 1, name))
    for line, name in sorted(found):
        err(f"{p.relative_to(ROOT)}:{line}", f"references agent '{name}', which does not exist")

# --- counts -----------------------------------------------------------------
readme = (ROOT / "README.md").read_text(encoding="utf-8")
n_spec, n_coord, n_skills = len(specialists), len(coordinators), len(skills)


def expect_count(path, text, pattern, want, what):
    for m in re.finditer(pattern, text):
        got = int(m.group(1))
        if got != want:
            line = text.count("\n", 0, m.start()) + 1
            err(f"{path}:{line}", f"says {got} {what}, but there are {want}")


expect_count("README.md", readme, r"\b(\d+) specialist", n_spec, "specialists")
expect_count("README.md", readme, r"badge/agents-(\d+)", n_spec, "agents (badge)")
expect_count("README.md", readme, r"\b(\d+) team coordinators", n_coord, "team coordinators")
expect_count("README.md", readme, r"\b(\d+) slash commands", n_skills, "slash commands")
expect_count("README.md", readme, r"badge/skills-(\d+)", n_skills, "skills (badge)")
expect_count("README.md", readme, r"## Skills — (\d+)", n_skills, "skills (heading)")
expect_count("README.md", readme, r"#skills--(\d+)-slash-commands", n_skills, "skills (anchor)")
for rel in ("plugin/.claude-plugin/plugin.json", ".claude-plugin/marketplace.json", "plugin/README.md", "INSTALL.md", "DEMO.md"):
    p = ROOT / rel
    if p.exists():
        t = p.read_text(encoding="utf-8")
        expect_count(rel, t, r"\b(\d+) specialist", n_spec, "specialists")
        expect_count(rel, t, r"\b(\d+) team coordinators", n_coord, "team coordinators")
        expect_count(rel, t, r"\b(\d+) (?:skills|slash commands)", n_skills, "skills")

# README group headings: "### Engineering (12)" must match its table rows.
team = readme[readme.index("## The Team"): readme.index("## Routing Commands")]
for m in re.finditer(r"^### (.+?) \((\d+)\)\n(.*?)(?=^### |\Z)", team, re.S | re.M):
    rows = re.findall(r"^\| `[a-z0-9-]+` \|", m.group(3), re.M)
    if len(rows) != int(m.group(2)):
        err("README.md", f"'{m.group(1)}' heading says {m.group(2)} but its table has {len(rows)} rows")

listed_agents = re.findall(r"^\| `([a-z0-9-]+)` \|", team, re.M)
for dup in sorted({a for a in listed_agents if listed_agents.count(a) > 1}):
    err("README.md", f"agent '{dup}' is listed more than once in The Team")
for name in sorted(set(agents) - set(listed_agents)):
    err("README.md", f"agent '{name}' is not listed in The Team tables")

skills_section = readme[readme.index("## Skills"):]
skills_section = skills_section[: skills_section.index("\n## ", 1)]
listed_skills = set(re.findall(r"^\| `/([a-z0-9-]+)", skills_section, re.M))
for name in sorted(set(skills) - listed_skills):
    err("README.md", f"skill '/{name}' is not listed in the Skills tables")
for name in sorted(listed_skills - set(skills)):
    err("README.md", f"lists skill '/{name}', but skills/{name}.md does not exist")

# --- JSON + model IDs ---------------------------------------------------------
for p in list(ROOT.glob("**/*.json")):
    if ".git" in p.parts or "node_modules" in p.parts:
        continue
    try:
        json.loads(p.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        err(p, f"invalid JSON: {e}")

stale_model = re.compile(r"claude-(?:opus|sonnet|haiku)-[0-4]-\d|claude-3")
for p in ROOT.glob("**/*"):
    if not p.is_file() or ".git" in p.parts or p.suffix not in {".md", ".json", ".sh", ".py"}:
        continue
    if p.name == "CHANGELOG.md" or p == pathlib.Path(__file__).resolve():
        continue
    for i, line in enumerate(p.read_text(encoding="utf-8").splitlines(), 1):
        if stale_model.search(line):
            err(f"{p.relative_to(ROOT)}:{i}", "references a retired model ID")

if errors:
    print(f"validate: {len(errors)} problem(s)", file=sys.stderr)
    for e in errors:
        print(f"  {e}", file=sys.stderr)
    sys.exit(1)
print(f"validate: ok — {n_spec} specialists, {n_coord} coordinators, {n_skills} skills")
