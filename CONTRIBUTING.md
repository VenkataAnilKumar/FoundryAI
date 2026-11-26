# Contributing to FoundryAI

Thanks for contributing. Every new agent, skill, or fix makes the toolkit more useful for every AI founder using it — in every AI workspace.

**One source, every workspace.** You write agents and skills once, in a workspace-neutral format. `scripts/build.py` turns them into the native formats for Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI and chat workspaces. Never write workspace-specific fields (`tools:`, `model:`) into `agents/`.

---

## Ways to Contribute

| Type | Examples |
|---|---|
| **New agent** | A specialist that doesn't exist yet (e.g. `ai-blockchain-engineer`) |
| **Improve an agent** | Deeper expertise, better examples, missing frameworks |
| **New skill** | A reusable workflow (Agent Skills `SKILL.md`) |
| **Improve a skill** | Better output format, more edge cases covered |
| **Bug fix** | Broken frontmatter, wrong capability, typo |
| **Template** | New stack-specific `AGENTS.md` (e.g. Django + Vue, Go + HTMX) |
| **Workflow recipe** | New entry in `templates/WORKFLOWS.md` for a common multi-agent scenario |

---

## Adding a New Agent

### 1. Check it doesn't already exist

Browse `agents/` — there are 58 specialists already. If a close match exists, consider improving it instead of creating a duplicate.

### 2. Name it correctly

Format: `ai-[role]-engineer.md`

```
ai-blockchain-engineer.md   ✓
ai-sre-engineer.md          ✓
ai-ml-engineer.md           ✓
blockchain-expert.md        ✗  (missing ai- prefix)
ai-blockchain.md            ✗  (missing -engineer suffix)
```

Special cases without `-engineer` suffix:
- `founder.md` — master orchestrator
- `cto-advisor.md` — advisory role

### 3. Use the agent template

```markdown
---
name: ai-[role]-engineer
description: [What this agent does and when to use it — 1 sentence, start with a verb]
capabilities: [read, edit, web]
tier: standard
---

# [Agent Title] — [One-line tagline]

## Role
[2-3 sentences on what this agent is, its core responsibility, and the perspective it brings.]

## Core Expertise

### [Domain Area 1]
- Specific capability with real tool/framework names
- Specific capability
- Specific capability

### [Domain Area 2]
- Specific capability
- Specific capability

### [Domain Area 3]
- Specific capability
- Specific capability

## How to Use

**Best for:**
- [Specific task type 1]
- [Specific task type 2]
- [Specific task type 3]

**Example invocations:**
```
Use the ai-[role]-engineer agent to [specific task].
```
```
Use the ai-[role]-engineer agent to review [X] and identify [Y].
```

**Not for:** (required — point to the agent that should handle neighbouring work)
- [Adjacent task] → `[other-agent]`

## Output Format

[Describe what the agent produces — document type, structure, level of detail.]

## Stack & Tools

| Category | Tools |
|---|---|
| [Category] | Tool1, Tool2, Tool3 |
| [Category] | Tool1, Tool2 |

## Quality Bar

- [Specific standard this agent holds itself to]
- [Another standard]
- [What "done" looks like for this agent's outputs]
```

### 4. Pick the tier

The tier says how much reasoning the agent needs; the build maps it to each workspace's models (for example `deep` → `opus` in Claude Code, high reasoning effort in Codex). Workspaces without per-agent models use the session's model.

| Tier | Use when |
|---|---|
| `deep` | Complex reasoning: strategy, architecture, legal, compliance, system design |
| `standard` | Engineering, product, business tasks — the default for most agents |
| `fast` | Lightweight: routing, classification, simple transformations |

### 5. Pick the capabilities

Only include what the agent actually needs. The build maps each capability to the workspace's own tools.

| Capability | Include when | Claude Code | Copilot |
|---|---|---|---|
| `read` | Always — read and search files | `Read, Grep, Glob` | `read, search` |
| `edit` | Agent creates or edits code, documents, or configs | `Write, Edit` | `edit` |
| `shell` | Agent runs commands, tests, or scripts | `Bash` | `execute` |
| `web` | Agent looks up external docs, papers, or current info | `WebSearch, WebFetch` | `web` |
| `delegate` | Coordinators only — the agent runs other FoundryAI agents | `Agent` | `agent` |

Every agent also gets FoundryAI's shared operating principles (`agents/_shared/`) and access to skills.

### 6. Size requirement

Minimum ~3,000 bytes. An agent file that's too short is too vague to be useful. Look at `agents/ai-architect.md` or `agents/ai-backend-engineer.md` as the gold standard.

### 7. Add to routing tables

If your agent belongs to a domain, add it to the relevant routing skill:

- Engineering agents → `skills/engineering/SKILL.md`
- Product agents → `skills/product/SKILL.md`
- Business agents → `skills/business/SKILL.md`

Then add the agent to the right table under **The Team** in `README.md` (and bump that group's count), and run `scripts/gen-docs.py` — it regenerates `docs/agents.md` and the roster in `agents/founder.md` from the README.

---

## Adding a New Skill

Skills follow the open [Agent Skills](https://agentskills.io/specification) standard, so the same file works in Claude Code, Cursor, Copilot, Codex, Gemini CLI and other compatible agents.

### 1. Name it

Create `skills/<skill-name>/SKILL.md`. The name is 1–64 lowercase letters, digits and single hyphens, and must match the folder: `skills/debug/SKILL.md` → `/debug`. Supporting files can go in `scripts/`, `references/` or `assets/` next to it.

### 2. Use the skill template

```markdown
---
name: skill-name
description: [What this skill does and when to use it — max 1024 characters]
argument-hint: [What the user should type after the command]
---

You are [role]. [Task setup in 1-2 sentences.]

$ARGUMENTS

## [Section 1]

[Instructions for this section]

## Output Format

[Describe exact output structure so the output is consistent and useful]
```

### 3. The `$ARGUMENTS` placeholder

This is where the user's input goes. Claude Code substitutes it directly; for every other workspace the build replaces it with a note pointing at the user's request. Design your skill so it works both with and without arguments:

- With: `/debug "TypeError: cannot read property of undefined"`
- Without: `/review` (the agent reviews the current file)

### 4. List it

Add it to the right table under **Skills** in `README.md`, then run `scripts/gen-docs.py` and `scripts/build.py`.

---

## PR Guidelines

### One thing per PR

- One new agent **or** one improved agent
- One new skill **or** one improved skill
- Keep PRs small and reviewable

### PR description must include

1. **What**: What does this add or change?
2. **Why**: What gap does it fill? What use case does it serve?
3. **Example output**: Paste a real example of the agent/skill producing useful output, and say which workspace you tested in

### Before submitting

- [ ] File follows the naming convention
- [ ] Frontmatter is valid YAML — agents: name, description, tier, capabilities; skills: name, description
- [ ] Agent has all required sections (Role, Core Expertise, How to Use, Output Format)
- [ ] Tested in at least one workspace — invoked the agent or skill and got useful output
- [ ] Routing tables updated if applicable
- [ ] README tables updated, and `scripts/gen-docs.py` + `scripts/build.py` run, if adding a new agent/skill
- [ ] `scripts/validate.sh` passes (CI runs it on every PR)

### Quality bar

Every agent should be **specific enough** that a developer immediately knows:
1. When to use this agent (vs another)
2. What they'll get back
3. What frameworks and tools it knows

Vague agents ("AI Assistant that helps with everything") will be rejected.

---

## Improving an Existing Agent

The bar for improvement PRs is lower — these are always welcome.

Good improvements:
- Add a missing framework the agent should know (e.g. new vector DB, new auth library)
- Fix an outdated tool reference
- Add better example invocations
- Improve the output format section
- Fix a typo or unclear wording

---

## Local Development

```bash
git clone https://github.com/VenkataAnilKumar/FoundryAI
cd FoundryAI

scripts/build.py                          # build every workspace into dist/ and refresh plugin/
scripts/validate.sh                       # run all checks (CI runs the same)
./install.sh --target cursor              # install your local changes into a workspace
```

Then invoke your agent in that workspace: *"Use the ai-your-new-agent agent to [task]"*.

---

## Repository Layout

```
FoundryAI/
├── agents/                          ← single source: specialists + team coordinators
│   ├── founder.md                   ← AI co-founder (master orchestrator)
│   ├── team-*.md                    ← team coordinators
│   └── _shared/                     ← operating principles appended to every agent
├── skills/<name>/SKILL.md           ← skills (Agent Skills standard)
├── templates/
│   ├── AGENTS*.md                   ← project templates, by stack and by AI startup type
│   ├── WORKFLOWS.md                 ← copy-paste team recipes
│   ├── hooks/                       ← Claude Code hook scripts
│   └── mcp-*.json                   ← MCP server configs (see docs/mcp.md)
├── scripts/
│   ├── build.py                     ← builds every workspace format and the Claude plugin
│   ├── validate.sh / validate.py    ← all checks (CI runs this)
│   ├── gen-docs.py                  ← regenerates docs/agents.md, docs/skills.md, founder roster
│   └── test-hooks.sh                ← hook tests
├── plugin/                          ← Claude Code plugin (generated — don't edit agents/ or skills/ here)
├── .claude-plugin/marketplace.json  ← Claude Code marketplace entry
├── docs/                            ← agents.md, skills.md (generated), routing.md, mcp.md
├── install.sh / uninstall.sh        ← multi-workspace installer
└── README.md                        ← its team and skill tables are the source for gen-docs.py
```

---

## Questions?

Open an issue with the `question` label. If you're not sure whether your agent idea fits, open a discussion first before writing the full file.

