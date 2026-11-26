# Contributing to FoundryAI

Thanks for contributing. Every new agent, skill, or fix makes the toolkit more useful for every AI founder using it.

---

## Ways to Contribute

| Type | Examples |
|---|---|
| **New agent** | A specialist that doesn't exist yet (e.g. `ai-blockchain-engineer`) |
| **Improve an agent** | Deeper expertise, better examples, missing frameworks |
| **New skill** | A slash command for a common workflow |
| **Improve a skill** | Better output format, more edge cases covered |
| **Bug fix** | Broken frontmatter, wrong tool list, typo |
| **Template** | New stack-specific `CLAUDE.md` (e.g. Django + Vue, Go + HTMX) |
| **Workflow recipe** | New entry in `WORKFLOWS.md` for a common multi-agent scenario |

---

## Adding a New Agent

### 1. Check it doesn't already exist

Browse `agents/` — there are 38 specialists already. If a close match exists, consider improving it instead of creating a duplicate.

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
tools: Read, Write, Edit, Bash, Grep, Glob, WebSearch, WebFetch
model: sonnet
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

### 4. Pick the right model

Use a model **alias**, not a full model ID. Aliases always resolve to the latest model in that family, work on Bedrock/Vertex, and don't need a 61-file edit every release.

| Model | Use when |
|---|---|
| `opus` | Complex reasoning: strategy, architecture, legal, compliance, system design |
| `sonnet` | Engineering, product, business tasks — the default for most agents |
| `haiku` | Fast, lightweight: routing, classification, simple transformations |
| `inherit` | Use whatever model the main conversation is on |

### 5. Set the right tools

Only include tools the agent actually needs:

| Tool | Include when |
|---|---|
| `Read`, `Grep`, `Glob` | Agent reads or searches files, code, or docs |
| `Write`, `Edit` | Agent creates or edits code, documents, or configs |
| `Bash` | Agent runs commands, tests, or scripts |
| `WebSearch`, `WebFetch` | Agent needs to look up external docs, papers, or current info |

Tool names are case-sensitive and must match Claude Code's tool names exactly.

### 6. Size requirement

Minimum ~3,000 bytes. An agent file that's too short is too vague to be useful. Look at `agents/ai-architect.md` or `agents/ai-backend-engineer.md` as the gold standard.

### 7. Add to routing tables

If your agent belongs to a domain, add it to the relevant plugin command:

- Engineering agents → `plugin/commands/engineering.md`
- Product agents → `plugin/commands/product.md`
- Business agents → `plugin/commands/business.md`

Then add the agent to the right table under **The Team** in `README.md` (and bump that group's count), and run `scripts/gen-docs.py` — it regenerates `docs/agents.md` and the roster in `agents/founder.md` from the README.

---

## Adding a New Skill (Slash Command)

### 1. Name it

Short, lowercase, hyphenated: `skill-name.md`

The file name becomes the command: `debug.md` → `/debug`

### 2. Use the skill template

```markdown
---
description: [One-line description of what this command does]
---

You are [role]. [Task setup in 1-2 sentences.]

$ARGUMENTS

## [Section 1]

[Instructions for this section]

## [Section 2]

[Instructions for this section]

## Output Format

[Describe exact output structure so the output is consistent and useful]
```

### 3. The `$ARGUMENTS` variable

This is where the user's input goes. Design your skill so it works both with and without arguments:

- With: `/debug "TypeError: cannot read property of undefined"`
- Without: `/review` (Claude reads the current file)

### 4. Add to the plugin

Add it to the right table under **Skills** in `README.md`, then run `scripts/gen-docs.py` to regenerate `docs/skills.md`. If the skill is broadly useful, copy it into `plugin/commands/` once; after that `scripts/sync-plugin-commands.sh` keeps the copy in sync.

---

## PR Guidelines

### One thing per PR

- One new agent **or** one improved agent
- One new skill **or** one improved skill
- Keep PRs small and reviewable

### PR description must include

1. **What**: What does this add or change?
2. **Why**: What gap does it fill? What use case does it serve?
3. **Example output**: Paste a real example of the agent/skill producing useful output in Claude Code

### Before submitting

- [ ] File follows the naming convention
- [ ] Frontmatter is valid YAML (name, description, tools, model)
- [ ] Agent has all required sections (Role, Core Expertise, How to Use, Output Format)
- [ ] Tested in Claude Code — invoked the agent and got useful output
- [ ] Routing tables updated if applicable
- [ ] README tables updated and `scripts/gen-docs.py` run if adding a new agent/skill
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

# Install your local changes to Claude Code for testing
cp agents/*.md ~/.claude/agents/
cp skills/*.md ~/.claude/commands/

# Test your agent
claude
# then: Use the ai-your-new-agent agent to [task]
```

---

## Questions?

Open an issue with the `question` label. If you're not sure whether your agent idea fits, open a discussion first before writing the full file.

---

## Editing slash commands

`skills/` is the single source of truth. `plugin/commands/` contains the plugin-only routing commands (`founder`, `engineering`, `product`, `business`) plus copies of shared skills. After editing a skill, run:

```bash
scripts/sync-plugin-commands.sh          # copy changes into plugin/commands/
scripts/sync-plugin-commands.sh --check  # verify nothing has drifted
```
