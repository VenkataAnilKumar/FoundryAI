# Contributing

## Adding a New Agent

1. Create a file in `agents/` following the naming convention: `agent-name.md`
2. Use this frontmatter template:

```markdown
---
name: your-agent-name
description: One sentence describing what this agent does and when to use it
tools: read, write, bash, search
model: claude-sonnet-4-6
---
```

3. Include these sections in the agent body:
   - **Role** — what the agent is and its core responsibility
   - **Core Expertise** — specific capabilities, tools, frameworks
   - **How to Use** — example invocations
   - **Outputs** — what the agent produces

4. Minimum file size: ~3,000 bytes (enough to be genuinely useful)
5. Reference: see `agents/ai-architect.md` as the gold standard

## Model Selection

- `claude-opus-4-6` — complex reasoning, strategy, architecture, legal/compliance
- `claude-sonnet-4-6` — engineering, product, business tasks (default)
- `claude-haiku-4-5` — fast, lightweight tasks (routing, classification)

## Tool Permissions

Only include tools the agent actually needs:
- `read` — agent needs to read files
- `write` — agent writes code or documents
- `bash` — agent needs to run commands/scripts
- `search` — agent needs to search the web

## PR Guidelines

- One agent per PR
- Test the agent by invoking it in Claude Code
- Include an example of the agent producing useful output in your PR description
- Update the routing tables in `plugin/commands/` if adding to a domain
