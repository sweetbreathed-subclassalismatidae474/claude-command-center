# Claude Command Center — Project Rules

> Run `/setup` to configure this file for your project. The setup interview will fill in all sections below.

## Session Continuity
- **On every session start:** Read `session-closing.md` from memory for prior session state, then check `lessons-learned.md` for known issues.
- **On every session end:** The SessionEnd hook auto-saves branch, commits, and uncommitted work to `session-closing.md`.
- **Lessons learned** is a perpetual file — append new lessons when issues are overcome, never delete existing entries.
- **Open items** tracks all work across sessions — update every session, mark items as completed.

## Brand
- **CORRECT**: "[YOUR_BRAND_NAME]"
- **WRONG**: "[COMMON_MISSPELLINGS]"

## Architecture
- **Frontend**: [YOUR_FRONTEND]
- **Backend**: [YOUR_BACKEND]
- **Database**: [YOUR_DATABASE]
- **Hosting**: [YOUR_HOSTING]
- **Payments**: [YOUR_PAYMENTS]
- **AI**: [YOUR_AI_PROVIDER]

## Off-Limits
- **`.env`** — never commit
- **`.secrets/`** — never commit
- **`credentials.json`** — never commit

## Working Style
- Fix, validate, commit, push, verify cycles
- Complete all related items before stopping — no partial work
- Use table format when presenting findings/options
- Read files before modifying them

## Conventions
- [ADD YOUR PROJECT-SPECIFIC CONVENTIONS]
