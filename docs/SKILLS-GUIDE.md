# Skills Guide

## What Are Skills?

Skills are markdown files (`.md`) in `.claude/skills/` that define specialized behaviors Claude can invoke. Unlike `CLAUDE.md` (loaded every session), skills load only when triggered, keeping context lean.

## Creating a Skill

Create a `.md` file in `.claude/skills/` with this format:

```markdown
---
name: my-skill
description: What this skill does — used to decide when to trigger
user_invocable: true
---

# Skill Instructions

[Detailed instructions for Claude when this skill is invoked]
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Becomes the `/slash-command` name |
| `description` | Yes | When to trigger this skill (be specific) |
| `user_invocable` | No | If `true`, user can invoke with `/name` |

### Tips
- The `description` field is critical — it determines when Claude auto-triggers the skill
- Keep skills focused on one task
- Reference memory files if the skill needs project context
- Skills can use any tool Claude has access to

## Example Skills

### `/daily-standup` — Morning Status Check
```markdown
---
name: daily-standup
description: Morning check-in — review open items, yesterday's progress, today's priorities
user_invocable: true
---

Read the following files and present a morning standup:

1. Read `memory/session-closing.md` — what was the last session's state?
2. Read `memory/open-items-daily.md` — what's the full open items list?
3. Read `memory/lessons-learned.md` — any recent lessons (last 5 entries)?

Present:
- **Yesterday:** What was accomplished in the last session
- **Today:** Top 3 priorities from open items (Critical Path first)
- **Blockers:** Any items that have been open > 3 days

Ask which items to focus on today.
```

### `/code-review` — Review Changed Files
```markdown
---
name: code-review
description: Review all staged/changed files for bugs, security issues, and code quality
user_invocable: true
---

Run `git diff --staged` (or `git diff` if nothing staged) and review all changes for:

1. **Security** — SQL injection, XSS, command injection, hardcoded secrets
2. **Bugs** — Off-by-one errors, null references, race conditions
3. **Quality** — Naming, complexity, duplication, dead code
4. **Tests** — Are changes covered by tests? Should new tests be added?

Present findings in a table:
| File | Line | Severity | Issue | Suggestion |
```

## Skill Marketplace

Browse pre-built skills at [SkillsMP.com](https://skillsmp.com/) — compatible with Claude Code's SKILL.md format.
