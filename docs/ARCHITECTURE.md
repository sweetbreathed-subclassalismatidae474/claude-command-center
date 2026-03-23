# Architecture — How the Command Center Works

## System Overview

```
┌─────────────────────────────────────────────────┐
│                  CLAUDE CODE                     │
│                                                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ Session  │  │ Session  │  │Pre-Commit│      │
│  │ Start    │→ │ End      │  │ Check    │      │
│  │ Hook     │  │ Hook     │  │ Hook     │      │
│  └────┬─────┘  └────┬─────┘  └──────────┘      │
│       │              │                           │
│  ┌────▼──────────────▼────────────────────┐     │
│  │           MEMORY SYSTEM                 │     │
│  │                                         │     │
│  │  session-closing.md  (auto-saved)       │     │
│  │  lessons-learned.md  (perpetual)        │     │
│  │  open-items-daily.md (daily tracker)    │     │
│  │  user-preferences.md (profile)          │     │
│  │  project-overview.md (architecture)     │     │
│  │  feedback-*.md       (corrections)      │     │
│  │  MEMORY.md           (index)            │     │
│  └─────────────────────────────────────────┘     │
│                                                  │
│  ┌─────────────────────────────────────────┐     │
│  │           DOMAIN ROUTING                 │     │
│  │                                         │     │
│  │  CLAUDE.md (master router)              │     │
│  │    ├── domains/coding/CLAUDE.md         │     │
│  │    ├── domains/marketing/CLAUDE.md      │     │
│  │    ├── domains/financial/CLAUDE.md      │     │
│  │    ├── domains/support/CLAUDE.md        │     │
│  │    └── domains/operations/CLAUDE.md     │     │
│  └─────────────────────────────────────────┘     │
│                                                  │
│  ┌─────────────────────────────────────────┐     │
│  │           SKILLS & TOOLS                 │     │
│  │                                         │     │
│  │  /setup  — onboarding interview         │     │
│  │  Custom skills in .claude/skills/       │     │
│  │  Plans in .claude/plans/                │     │
│  └─────────────────────────────────────────┘     │
└─────────────────────────────────────────────────┘
```

## Data Flow

### Session Lifecycle
1. **Start** → hook reads `session-closing.md` → context loaded
2. **Work** → Claude reads/writes memory files, tracks open items
3. **End** → hook captures git state → saves to `session-closing.md`

### Memory Lifecycle
1. **Created** — by `/setup` interview or during normal work
2. **Updated** — when information changes or corrections happen
3. **Indexed** — every memory file gets a link in `MEMORY.md`
4. **Archived** — session logs age out; core files persist

### Domain Routing
Each domain folder has its own `CLAUDE.md`. When you `cd` into a domain and start Claude, it loads:
1. The root `CLAUDE.md` (project-wide rules)
2. The domain's `CLAUDE.md` (domain-specific rules)
3. All memory files referenced in `MEMORY.md`
