# Skills

Place `.md` skill files here to add custom slash commands to Claude Code.

See `examples/` for starter skills:
- `daily-standup.md` — Morning status check with open items review
- `code-review.md` — Security and quality review of changed files

## Creating Skills

See [docs/SKILLS-GUIDE.md](../../docs/SKILLS-GUIDE.md) for the full guide.

## Quick Format

```markdown
---
name: skill-name
description: When to trigger this skill
user_invocable: true
---

[Instructions for Claude]
```

The `name` becomes `/skill-name` as a slash command.
