---
name: daily-standup
description: Morning check-in — review open items, yesterday's progress, today's priorities. Use when the user starts their day or asks for a status update.
user_invocable: true
---

# Daily Standup

Read these memory files and present a morning standup summary:

1. **Read `session-closing.md`** — What happened in the last session? Branch, commits, uncommitted work.
2. **Read `open-items-daily.md`** — Full open items list with status.
3. **Read `lessons-learned.md`** — Last 5 entries (recent gotchas).

## Present

### Yesterday
- Summarize what was accomplished in the last session (from session-closing.md)
- List any items marked completed in open-items-daily.md

### Today — Top Priorities
- Pull the top 3 items from Critical Path in open-items-daily.md
- If Critical Path is empty, pull from Features & Development
- Highlight any items open > 3 days

### Blockers
- Items that can't proceed without external input
- Items that have been attempted and failed

### Ask
"Which items do you want to focus on today?"

Then update open-items-daily.md with the "Last Updated" date.
