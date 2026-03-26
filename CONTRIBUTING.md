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
tools: read, write, bash, search
model: claude-sonnet-4-6
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

| Model | Use when |
|---|---|
| `claude-opus-4-6` | Complex reasoning: strategy, architecture, legal, compliance, system design |
| `claude-sonnet-4-6` | Engineering, product, business tasks — the default for most agents |
| `claude-haiku-4-5-20251001` | Fast, lightweight: routing, classification, simple transformations |

### 5. Set the right tools

Only include tools the agent actually needs:

| Tool | Include when |
|---|---|
| `read` | Agent reads files, code, or docs |
| `write` | Agent writes code, documents, or configs |
| `bash` | Agent runs commands, tests, or scripts |
| `search` | Agent needs to look up docs, papers, or current info |

### 6. Size requirement

Minimum ~3,000 bytes. An agent file that's too short is too vague to be useful. Look at `agents/ai-architect.md` or `agents/ai-backend-engineer.md` as the gold standard.

### 7. Add to routing tables

If your agent belongs to a domain, add it to the relevant plugin command:

- Engineering agents → `plugin/commands/engineering.md`
- Product agents → `plugin/commands/product.md`
- Business agents → `plugin/commands/business.md`

Also update `README.md` agent roster and `docs/agents.md`.

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

If the skill is broadly useful, add it to `plugin/commands/` so it's available via the founders-kit plugin. Update `README.md` skills table and `docs/skills.md`.

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
- [ ] README and docs updated if adding a new agent/skill

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
