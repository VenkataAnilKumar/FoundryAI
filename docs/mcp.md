# MCP Servers

[MCP](https://modelcontextprotocol.io) servers give your agents live access to tools like GitHub and your database. FoundryAI ships three starter configs in `templates/`:

| File | Servers | Notes |
|---|---|---|
| [`mcp-github.json`](../templates/mcp-github.json) | GitHub | GitHub's official **remote** server (`https://api.githubcopilot.com/mcp/`). Needs a personal access token. |
| [`mcp-postgres.json`](../templates/mcp-postgres.json) | PostgreSQL | Third-party [`postgres-mcp`](https://github.com/crystaldba/postgres-mcp) in **restricted (read-only)** mode, run with `uvx`. |
| [`mcp-full-stack.json`](../templates/mcp-full-stack.json) | GitHub + PostgreSQL + filesystem | The two above, plus the reference filesystem server scoped to the project folder. |

The older `@modelcontextprotocol/server-github` and `@modelcontextprotocol/server-postgres` packages are deprecated or archived and receive no security fixes. Don't use them. For a local GitHub server instead of the remote one, use GitHub's Docker image `ghcr.io/github/github-mcp-server`.

The Postgres server above is a community project. Review it before connecting it to production data, and use a read-only database user regardless.

## Secrets

The configs read secrets from environment variables (`${GITHUB_PERSONAL_ACCESS_TOKEN}`, `${DATABASE_URI}`) instead of storing them in the file. Set them in your shell or secret manager, and never commit tokens. Use a fine-grained GitHub token with only the repositories and permissions you need.

## Where each workspace reads MCP config

The JSON files use the common `mcpServers` format. Copy the block into your workspace's config file:

| Workspace | Project config | Format notes |
|---|---|---|
| **Claude Code** | `.mcp.json` in the project root | Use as is. |
| **GitHub Copilot** (CLI / portable) | `.mcp.json` in the project root, or `~/.copilot/mcp-config.json` | Same `mcpServers` format. |
| **VS Code** | `.vscode/mcp.json` | VS Code's own format uses a top-level **`servers`** key (not `mcpServers`); rename the key, or let VS Code pick up the root `.mcp.json`. |
| **Cursor** | `.cursor/mcp.json` | `mcpServers` format; check Cursor's docs for its environment-variable syntax. |
| **Codex CLI** | `~/.codex/config.toml` | TOML: one `[mcp_servers.<name>]` table per server (`command`/`args`/`env`, or `url` for remote servers). |
| **Gemini CLI** | `.gemini/settings.json` | `mcpServers` format; remote servers use `httpUrl`. |

Exact field names change between releases, so check your workspace's MCP documentation if a server doesn't start.
