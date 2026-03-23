# Memory Guide

## Memory Types

| Type | Purpose | When to Save | Example |
|------|---------|-------------|---------|
| `user` | Who the user is, preferences, knowledge | When you learn about the user | Communication style, role, expertise |
| `feedback` | Corrections and validated approaches | When Claude does something wrong OR right | "Don't mock the database in tests" |
| `project` | Ongoing work, goals, decisions | When you learn context not in code/git | "Merge freeze starts Thursday" |
| `reference` | Pointers to external systems | When you discover where info lives | "Bugs tracked in Linear project INGEST" |

## File Format

Every memory file uses YAML frontmatter:

```markdown
---
name: Short Name
description: One-line description (used to decide relevance in future sessions)
type: user | feedback | project | reference
---

Content here. For feedback/project types, structure as:
[Rule or fact]

**Why:** [The reason — incident or preference that led to this]

**How to apply:** [When/where this guidance kicks in]
```

## What NOT to Save
- Code patterns derivable from reading the code
- Git history (use `git log` / `git blame`)
- Debugging solutions (the fix is in the code)
- Anything in CLAUDE.md already
- Ephemeral task details (use open-items-daily.md instead)

## Index Rules
- Every memory file must have a link in `MEMORY.md`
- Keep the index under 200 lines (it's loaded into context every session)
- Organize by topic, not chronologically
- Update or remove stale memories
