# Daily Operations Guide

## How the Daily System Works

### Session Start
When you start Claude Code, the `session-start.sh` hook automatically:
1. Checks for `session-closing.md` (prior session state)
2. Reminds you to check `lessons-learned.md`
3. You should then check `open-items-daily.md` for current priorities

### During Your Session
- Use the TodoWrite tool to track in-session tasks
- Update `open-items-daily.md` when you complete items or discover new ones
- Add lessons to `lessons-learned.md` when you overcome tricky issues

### Session End
When you exit, the `session-end.sh` hook automatically:
1. Captures your current git branch
2. Records your last commit
3. Lists uncommitted changes
4. Records active worktrees
5. Saves everything to `session-closing.md`

### Daily Reminder (Optional)
Set up a morning reminder to review open items:

```
# In Claude Code, run:
# This creates a daily reminder at ~8:45am to check open items
```

The reminder will present your open items and ask which to prioritize today.

## Open Items Tracker

### Structure
The `open-items-daily.md` file has 4 sections:

| Section | Purpose |
|---------|---------|
| **Critical Path** | Blocking items — do these first |
| **Features & Development** | New functionality being built |
| **Research & Planning** | Investigation and design work |
| **Cleanup & Maintenance** | Tech debt, refactoring, docs |

### Status Values
- **OPEN** — not started
- **IN PROGRESS** — actively working
- **PARTIAL** — partially done, needs more work
- **DONE** — completed (move to Completed section)

### Best Practices
1. Mark items complete **immediately** when done — don't batch
2. Add new items as they arise — don't wait for a planning session
3. Review the full list at the start of each session
4. Move completed items to the Completed section (don't delete them)
5. Add the completion date so you can track velocity

## Memory Maintenance

### Every Session
- Read `session-closing.md` (happens automatically via hook)
- Update `open-items-daily.md` with progress

### Weekly
- Review `lessons-learned.md` for patterns
- Check for stale memory files that need updating
- Verify `MEMORY.md` index is accurate

### Monthly
- Archive old session logs
- Review and consolidate feedback memories
- Update project overview if architecture has changed
