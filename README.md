# Claude Command Center

A production-tested template for organizing Claude Code into a multi-domain workspace with persistent memory, session continuity, daily task tracking, and intelligent onboarding.

**Built by [Tuning Labs](https://tuninglabs.net)** — battle-tested across 30+ agent swarms, 70+ tracked items, and months of daily use building a vertical SaaS platform.

## What This Is

A ready-to-use template that transforms Claude Code from a simple CLI into an organized command center for your project. It includes:

- **Interactive setup interview** (`/setup`) that configures everything from your answers
- **Session persistence** — never lose context between sessions
- **Daily task tracking** — persistent open items list updated every session
- **Multi-domain routing** — separate contexts for coding, marketing, financial, support, ops
- **Memory system** — structured knowledge base that grows with your project
- **Hook scripts** — auto-save state on exit, auto-load on start, pre-commit safety checks
- **Lessons learned** — perpetual log that prevents repeating mistakes

## Quick Start

```bash
# 1. Clone or copy this template into your project
git clone https://github.com/YOUR_USERNAME/claude-command-center.git
cp -r claude-command-center/.claude your-project/.claude
cp claude-command-center/CLAUDE.md your-project/CLAUDE.md

# 2. Start Claude Code in your project
cd your-project
claude

# 3. Run the setup interview
/setup
```

The setup interview asks about your project, tech stack, preferences, and workflow in 5 stages. It generates all configuration files automatically.

## What's Inside

```
.claude/
  hooks/
    session-start.sh    # Loads prior session state on every start
    session-end.sh      # Auto-saves branch, commits, work on every exit
    pre-commit.sh       # Catches brand name errors, hardcoded secrets
  settings.local.json   # Hook configuration and permissions
  skills/               # Custom slash commands
  plans/                # Work-in-progress implementation plans

memory/
  MEMORY.md             # Index of all memory files
  templates/            # Blank templates for each memory type
  examples/             # Filled examples showing best practices

domains/
  coding/CLAUDE.md      # Development-specific context and rules
  marketing/CLAUDE.md   # Marketing-specific context and rules
  financial/CLAUDE.md   # Financial analysis context and rules
  support/CLAUDE.md     # Customer support context and rules
  operations/CLAUDE.md  # Operations and admin context and rules

CLAUDE.md               # Master router — project-wide rules and navigation
```

## How It Works

### Session Continuity
Every time you exit Claude Code, the `session-end.sh` hook captures your git branch, recent commits, uncommitted changes, and worktree status into `session-closing.md`. When you start a new session, `session-start.sh` loads that state back. You never lose context.

### Memory System
Memory files use YAML frontmatter with 4 types: `user`, `feedback`, `project`, `reference`. The `MEMORY.md` index keeps everything discoverable. Memory grows organically as you work — feedback from mistakes becomes guidance for future sessions.

### Daily Task Tracking
The `open-items-daily.md` file persists across sessions. Items are organized by priority (Critical Path, Features, Research, Cleanup). Mark items complete as you go. Set up a daily reminder to review open items each morning.

### Multi-Domain Routing
Each `domains/` folder has its own `CLAUDE.md` with domain-specific rules, tools, and conventions. When you `cd` into a domain folder and run Claude, it loads that domain's context automatically.

### Pre-Commit Safety
The `pre-commit.sh` hook checks for brand name misspellings, hardcoded secrets, forbidden file patterns, and API keys before every commit.

## Memory File Types

| Type | Purpose | When to Save |
|------|---------|-------------|
| `user` | Your role, preferences, knowledge level | When you learn something about yourself that affects how Claude should help |
| `feedback` | Corrections and validated approaches | When Claude does something wrong OR right that's worth remembering |
| `project` | Ongoing work, goals, decisions | When you learn context that isn't in the code or git history |
| `reference` | Pointers to external systems | When you discover where information lives outside the codebase |

## Customization

### Adding Custom Skills
Create `.md` files in `.claude/skills/` with YAML frontmatter:

```yaml
---
name: my-skill
description: What this skill does
user_invocable: true
---
[Skill instructions here]
```

### Adding Pre-Commit Checks
Edit `.claude/hooks/pre-commit.sh` — add patterns to `BRAND_RULES`, `FORBIDDEN_PATTERNS`, or `FORBIDDEN_FILES` arrays.

### Adding New Memory Types
Copy a template from `memory/templates/`, fill it in, and add a link to `memory/MEMORY.md`.

## Philosophy

This system is built on three principles:

1. **Context is everything.** The more Claude knows about your project, preferences, and history, the better it performs. Memory makes this persistent.

2. **Never repeat mistakes.** The lessons-learned file and feedback memories ensure that hard-won knowledge survives across sessions.

3. **Track everything, complete everything.** The open items tracker prevents work from falling through cracks across sessions. No partial work.

## License

MIT License - Copyright (c) 2026 Tuning Labs (tuninglabs.net)

See [LICENSE](LICENSE) for details.
