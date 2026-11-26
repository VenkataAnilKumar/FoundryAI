#!/usr/bin/env python3
"""Consistency checks for FoundryAI. Run via scripts/validate.sh (used by CI).

Checks:
  - agents: valid YAML frontmatter, name matches file, description, tier, capabilities;
    coordinators can delegate
  - skills: Agent Skills spec (name rules, matches folder, description <= 1024 chars)
  - every agent name referenced in agents/skills/templates/docs exists
  - README / plugin / marketplace / install docs counts match the files on disk
  - every agent and skill is listed in README
  - every build target builds, with the right file counts, valid YAML and TOML
  - JSON files parse; no retired model IDs
"""
import json
import pathlib
import re
import subprocess
import sys
import tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
TIERS = {"deep", "standard", "fast"}
CAPABILITIES = {"read", "edit", "shell", "web", "delegate"}
NON_AGENT_FILES = {"README.md", "WORKFLOWS.md"}
REFERENCE_ALLOWLIST = {"CONTRIBUTING.md", "CHANGELOG.md", "launch.md"}  # mention hypothetical agents or GitHub topics on purpose
SKILL_NAME = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")

try:
    import yaml  # optional locally; CI installs it
except ImportError:
    yaml = None
try:
    import tomllib
except ImportError:
    tomllib = None

sys.path.insert(0, str(ROOT / "scripts"))
from build import parse_frontmatter  # noqa: E402

errors = []


def err(where, msg):
    if isinstance(where, pathlib.Path):
        where = where.relative_to(ROOT)
    errors.append(f"{where}: {msg}")


def check_yaml(path, text):
    if yaml is None or not text.startswith("---\n"):
        return
    try:
        yaml.safe_load(text[4:text.index("\n---", 4)])
    except Exception as e:  # noqa: BLE001
        err(path, f"frontmatter is not valid YAML ({str(e).splitlines()[0]}); quote the value")


# --- agents ----------------------------------------------------------------
agents = {}
for p in sorted((ROOT / "agents").glob("*.md")):
    if p.name in NON_AGENT_FILES:
        continue
    text = p.read_text(encoding="utf-8")
    check_yaml(p, text)
    try:
        fm, _ = parse_frontmatter(p)
    except ValueError as e:
        err(p, str(e))
        continue
    if fm.get("name") != p.stem:
        err(p, f"name '{fm.get('name')}' does not match file name '{p.stem}'")
    if not fm.get("description"):
        err(p, "missing description")
    if fm.get("tier") not in TIERS:
        err(p, f"tier '{fm.get('tier')}' must be one of {sorted(TIERS)}")
    for key in ("model", "tools"):
        if key in fm:
            err(p, f"'{key}' is workspace-specific; use 'tier' / 'capabilities' (build.py maps them)")
    caps = fm.get("capabilities")
    if not isinstance(caps, list) or not caps:
        err(p, "capabilities must be a list, e.g. [read, edit, web]")
        caps = []
    for c in caps:
        if c not in CAPABILITIES:
            err(p, f"unknown capability '{c}' (allowed: {sorted(CAPABILITIES)})")
    is_coordinator = p.stem.startswith("team-") or p.stem in {"founder", "ai-orchestrator"}
    if is_coordinator and "delegate" not in caps:
        err(p, "coordinators need the 'delegate' capability so they can run other agents")
    agents[p.stem] = fm

specialists = sorted(n for n in agents if not n.startswith("team-"))
coordinators = sorted(n for n in agents if n.startswith("team-"))

# --- skills ----------------------------------------------------------------
skills = {}
for p in sorted((ROOT / "skills").iterdir()):
    if p.is_file():
        err(p, "skills must be folders containing SKILL.md (Agent Skills standard)")
        continue
    f = p / "SKILL.md"
    if not f.exists():
        err(p, "missing SKILL.md")
        continue
    check_yaml(f, f.read_text(encoding="utf-8"))
    try:
        fm, _ = parse_frontmatter(f)
    except ValueError as e:
        err(f, str(e))
        continue
    name, desc = fm.get("name", ""), fm.get("description", "")
    if name != p.name:
        err(f, f"name '{name}' must match its folder '{p.name}'")
    if not SKILL_NAME.match(name) or len(name) > 64:
        err(f, "name must be 1-64 lowercase letters, digits and single hyphens")
    if not desc:
        err(f, "missing description")
    elif len(desc) > 1024:
        err(f, f"description is {len(desc)} characters; the Agent Skills limit is 1024")
    skills[p.name] = fm

# --- agent references -------------------------------------------------------
role = r"(?:engineer|manager|designer|expert|architect|researcher|advisor|analyst|writer|advocate|orchestrator)"
ref_patterns = [
    re.compile(r"`((?:ai|team)-[a-z0-9]+(?:-[a-z0-9]+)*)`"),
    re.compile(r"\b((?:ai|team)-[a-z0-9]+(?:-[a-z0-9]+)*-" + role + r")\b"),
    re.compile(r"\b(team-(?:leadership|architecture|engineering|platform|product|data-ai|growth|knowledge|safety|manager))\b"),
]
scan = [ROOT / "README.md", ROOT / "INSTALL.md"]
scan += sorted((ROOT / "agents").rglob("*.md")) + sorted((ROOT / "skills").glob("*/SKILL.md"))
for d in ("templates", "docs"):
    scan += sorted((ROOT / d).glob("*.md"))
for p in scan:
    if p.name in REFERENCE_ALLOWLIST or not p.exists():
        continue
    text = p.read_text(encoding="utf-8")
    found = set()
    for pat in ref_patterns:
        for m in pat.finditer(text):
            if m.group(1) not in agents:
                found.add((text.count("\n", 0, m.start()) + 1, m.group(1)))
    for line, name in sorted(found):
        err(f"{p.relative_to(ROOT)}:{line}", f"references agent '{name}', which does not exist")

# --- counts -----------------------------------------------------------------
readme = (ROOT / "README.md").read_text(encoding="utf-8")
n_spec, n_coord, n_skills = len(specialists), len(coordinators), len(skills)


def expect_count(where, text, pattern, want, what):
    for m in re.finditer(pattern, text):
        got = int(m.group(1))
        if got != want:
            line = text.count("\n", 0, m.start()) + 1
            err(f"{where}:{line}", f"says {got} {what}, but there are {want}")


expect_count("README.md", readme, r"\b(\d+) specialist", n_spec, "specialists")
expect_count("README.md", readme, r"badge/agents-(\d+)", n_spec, "agents (badge)")
expect_count("README.md", readme, r"\b(\d+) team coordinators", n_coord, "team coordinators")
expect_count("README.md", readme, r"\b(\d+) skills\b", n_skills, "skills")
expect_count("README.md", readme, r"badge/skills-(\d+)", n_skills, "skills (badge)")
expect_count("README.md", readme, r"## Skills — (\d+)", n_skills, "skills (heading)")
expect_count("README.md", readme, r"#skills--(\d+)-", n_skills, "skills (anchor)")
for rel in ("plugin/.claude-plugin/plugin.json", ".claude-plugin/marketplace.json", "plugin/README.md",
            "INSTALL.md", "agents/README.md"):
    p = ROOT / rel
    if p.exists():
        t = p.read_text(encoding="utf-8")
        expect_count(rel, t, r"\b(\d+) specialist", n_spec, "specialists")
        expect_count(rel, t, r"\b(\d+) team coordinators", n_coord, "team coordinators")
        expect_count(rel, t, r"\b(\d+) (?:skills|slash commands)\b", n_skills, "skills")

team = readme[readme.index("## The Team"): readme.index("## Routing")]
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
    err("README.md", f"lists skill '/{name}', but skills/{name}/SKILL.md does not exist")

# --- skill references & agent structure ------------------------------------------
def check_skill_refs(where, text):
    for m in re.finditer(r"`/([a-z][a-z0-9-]*)`|(?<![\w/`])/([a-z][a-z0-9-]+)\b", text):
        name = m.group(1) or m.group(2)
        if name not in skills:
            line = text.count("\n", 0, m.start()) + 1
            err(f"{where}:{line}", f"references skill '/{name}', which does not exist")


for p in sorted((ROOT / "agents").glob("*.md")):
    if p.name in NON_AGENT_FILES:
        continue
    text = p.read_text(encoding="utf-8")
    rel = p.relative_to(ROOT)
    # skill tables: every table row anywhere that names a `/skill`
    rows = "\n".join(l for l in text.splitlines() if l.startswith("|") and "`/" in l)
    check_skill_refs(rel, "\n".join(re.findall(r"`/[a-z][a-z0-9-]*`", rows)))
    if not re.search(r"^## .*(Output|Deliverable)", text, re.M | re.I):
        err(p, "agents need an '## Output Format' section so answers have a consistent shape")
    if not p.stem.startswith("team-") and p.stem != "founder":
        if "not for" not in text.lower():
            err(p, "specialists need a 'Not For' pointer to the agent to use instead")
for p in sorted((ROOT / "templates").glob("AGENTS*.md")):
    text = p.read_text(encoding="utf-8")
    m = re.search(r"^## Useful Skills\n+(.*)$", text, re.M)
    if m:
        check_skill_refs(p.relative_to(ROOT), m.group(1))
for name, fm in skills.items():
    check_skill_refs(f"skills/{name}/SKILL.md (description)", fm.get("description", ""))
routing = (ROOT / "docs" / "routing.md").read_text(encoding="utf-8")
check_skill_refs("docs/routing.md", "\n".join(re.findall(r"\((/[^)]*)\)", routing)))

# --- relative links in docs resolve ------------------------------------------------
link_files = [ROOT / n for n in ("README.md", "INSTALL.md", "CONTRIBUTING.md", "CHANGELOG.md")]
link_files += sorted((ROOT / "docs").glob("*.md")) + sorted((ROOT / "templates").glob("*.md"))
link_files += [ROOT / "agents" / "README.md", ROOT / "plugin" / "README.md"]
for f in link_files:
    if not f.exists():
        continue
    for m in re.finditer(r"\]\(([^)#\s]+)(?:#[^)]*)?\)", f.read_text(encoding="utf-8")):
        target = m.group(1)
        if re.match(r"^[a-z]+:", target):  # http:, https:, mailto:
            continue
        if not (f.parent / target).resolve().exists():
            err(f, f"broken link to '{target}'")

# --- raw.githubusercontent install URLs point at a real branch and file ----------------
DEFAULT_BRANCH = "master"
for f in [ROOT / n for n in ("README.md", "INSTALL.md", "install.sh", "uninstall.sh")] + [ROOT / "agents" / "README.md"]:
    if not f.exists():
        continue
    for m in re.finditer(r"raw\.githubusercontent\.com/VenkataAnilKumar/FoundryAI/([^/\s]+)/([^\s|`'\")]+)", f.read_text(encoding="utf-8")):
        branch, path = m.group(1), m.group(2)
        if branch != DEFAULT_BRANCH:
            err(f, f"raw URL uses branch '{branch}'; the default branch is '{DEFAULT_BRANCH}'")
        if not (ROOT / path).exists():
            err(f, f"raw URL points to '{path}', which is not in the repo")

# --- landing page: agent and skill names in the startup picker exist -------------------
site = ROOT / "site" / "index.html"
if site.exists():
    html = site.read_text(encoding="utf-8")
    script = html[html.find("<script>"):]
    for name in sorted(set(re.findall(r'"((?:ai|team)-[a-z0-9-]+|[a-z]+-(?:architect|engineer|manager|advisor|advocate))"', script))):
        if name not in agents:
            err("site/index.html", f"names agent '{name}', which does not exist")
    for name in sorted(set(re.findall(r'"/([a-z][a-z0-9-]+)"', script))):
        if name not in skills:
            err("site/index.html", f"names skill '/{name}', which does not exist")
    for tpl in sorted(set(re.findall(r'tpl:"([^"]+)"', script))):
        if not (ROOT / "templates" / tpl).exists():
            err("site/index.html", f"links template '{tpl}', which does not exist")

# --- project templates --------------------------------------------------------
for t in sorted((ROOT / "templates").glob("AGENTS*.md")):
    text = t.read_text(encoding="utf-8")
    if t.name not in readme:
        err("README.md", f"template '{t.name}' is not listed under Project Templates")
    for required in ("**Stage**", "**AI startup type**", "Works in any AI workspace"):
        if required not in text:
            err(t, f"missing '{required}'")
    if "{{" in text:
        err(t, "unfilled placeholder '{{...}}'")

# --- every build target -------------------------------------------------------
EXPECT = {  # target: (agent glob, skill glob)
    "claude": (".claude/agents/*.md", ".claude/skills/*/SKILL.md"),
    "cursor": (".cursor/agents/*.md", ".agents/skills/*/SKILL.md"),
    "copilot": (".copilot/agents/*.agent.md", ".copilot/skills/*/SKILL.md"),
    "codex": (".codex/agents/*.toml", ".agents/skills/*/SKILL.md"),
    "gemini": (".gemini/agents/*.md", ".agents/skills/*/SKILL.md"),
    "chat": ("FoundryAI-chat-prompts/agents/*.md", "FoundryAI-chat-prompts/skills/*.md"),
}
with tempfile.TemporaryDirectory() as tmp:
    run = subprocess.run([sys.executable, str(ROOT / "scripts/build.py"), "--out", tmp, "--no-plugin"],
                         capture_output=True, text=True)
    if run.returncode != 0:
        err("scripts/build.py", "build failed:\n" + run.stderr)
    else:
        out = pathlib.Path(tmp)
        for target, (agent_glob, skill_glob) in EXPECT.items():
            a = list((out / target).glob(agent_glob))
            s = list((out / target).glob(skill_glob))
            if len(a) != len(agents):
                err(f"build/{target}", f"{len(a)} agent files, expected {len(agents)}")
            if len(s) != len(skills):
                err(f"build/{target}", f"{len(s)} skill files, expected {len(skills)}")
            for f in a + s:
                text = f.read_text(encoding="utf-8")
                if f.suffix == ".toml" and tomllib is not None:
                    try:
                        data = tomllib.loads(text)
                        for k in ("name", "description", "developer_instructions"):
                            if not data.get(k):
                                err(f"build/{target}/{f.name}", f"missing {k}")
                    except tomllib.TOMLDecodeError as e:
                        err(f"build/{target}/{f.name}", f"invalid TOML: {e}")
                elif target != "chat":
                    if not text.startswith("---\n"):
                        err(f"build/{target}/{f.name}", "missing frontmatter")
                    elif yaml is not None:
                        try:
                            data = yaml.safe_load(text[4:text.index("\n---", 4)])
                            if not data.get("name") or not data.get("description"):
                                err(f"build/{target}/{f.name}", "frontmatter lacks name/description")
                        except Exception as e:  # noqa: BLE001
                            err(f"build/{target}/{f.name}", f"invalid YAML: {e}")
                if target != "claude" and "$ARGUMENTS" in text:
                    err(f"build/{target}/{f.name}", "contains Claude-only $ARGUMENTS")

# --- JSON + model IDs -----------------------------------------------------------
for p in ROOT.rglob("*.json"):
    if {".git", "node_modules", "dist"} & set(p.parts):
        continue
    try:
        json.loads(p.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        err(p, f"invalid JSON: {e}")

stale_model = re.compile(r"claude-(?:opus|sonnet|haiku)-[0-4]-\d|claude-3")
for p in ROOT.rglob("*"):
    if not p.is_file() or {".git", "dist"} & set(p.parts) or p.suffix not in {".md", ".json", ".sh", ".py", ".toml"}:
        continue
    if p.name == "CHANGELOG.md" or p == pathlib.Path(__file__).resolve():
        continue
    for i, line in enumerate(p.read_text(encoding="utf-8").splitlines(), 1):
        if stale_model.search(line):
            err(f"{p.relative_to(ROOT)}:{i}", "references a retired model ID")

if yaml is None:
    print("validate: note — PyYAML not installed, YAML syntax checks skipped (pip install pyyaml)", file=sys.stderr)
if tomllib is None:
    print("validate: note — Python < 3.11, TOML checks skipped", file=sys.stderr)
if errors:
    print(f"validate: {len(errors)} problem(s)", file=sys.stderr)
    for e in errors:
        print(f"  {e}", file=sys.stderr)
    sys.exit(1)
print(f"validate: ok — {n_spec} specialists, {n_coord} coordinators, {n_skills} skills, "
      f"{len(EXPECT)} build targets")
