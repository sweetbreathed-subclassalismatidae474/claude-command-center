---
name: setup
description: Interactive onboarding interview that seeds your Claude Command Center with project context, user preferences, memory files, hooks, and daily operations tracking.
user_invocable: true
---

# Claude Command Center — Setup Interview

You are running the initial setup for a Claude Command Center. This is an interactive onboarding interview that will configure the entire system based on the user's answers.

## How This Works

Run through 5 stages of questions. After each stage, save the answers to the appropriate memory files. At the end, generate all configuration files.

Use the AskUserQuestion tool for each stage. Be conversational and helpful. If the user seems unsure, offer sensible defaults.

---

## Stage 1: Who Are You?

Ask these questions (use AskUserQuestion with 2-3 questions at a time):

1. **What's your name?** (Used in memory files and commit co-author tags)
2. **What's your role?** Options: Solo developer, Team lead, CTO/Founder, Designer, Data scientist, Other
3. **What's your technical background?** Options: Beginner (learning to code), Intermediate (comfortable with 1-2 languages), Advanced (full-stack, multiple languages), Expert (10+ years, architecture-level)
4. **How should Claude communicate with you?** Options: Terse and direct (no fluff), Balanced (brief but clear), Detailed explanations (teach me as we go)
5. **Any pet peeves with AI assistants?** (free text — things Claude should NEVER do)

After collecting Stage 1 answers, write `memory/user-preferences.md`:

```markdown
---
name: User Preferences
description: User profile, communication style, and working preferences
type: user
---

# User Profile

- **Name:** {name}
- **Role:** {role}
- **Technical Level:** {level}
- **Communication Style:** {style}

## Things to Never Do
{pet_peeves}
```

---

## Stage 2: What's Your Project?

Ask these questions:

1. **Company/product name** — and the EXACT correct capitalization (e.g., "Tuning Labs" not "TuningLab")
2. **One-line description** — What does your product/company do?
3. **Tech stack** — Ask about each layer:
   - Frontend: (React, Vue, Svelte, vanilla JS, Next.js, etc.)
   - Backend: (Node.js, Python, Go, Ruby, serverless, etc.)
   - Database: (PostgreSQL, MySQL, MongoDB, Supabase, Firebase, etc.)
   - Hosting: (Vercel, Netlify, AWS, GCP, Azure, self-hosted, etc.)
   - Payments: (Stripe, PayPal, none, etc.)
   - AI: (OpenAI, Anthropic, none, etc.)
4. **Repo structure** — Options: Monorepo, Multi-repo, Single app, Serverless functions
5. **Key directories** — Where is the frontend? Backend? Tests? Config? (or let Claude scan the repo)
6. **Brand rules** — Any words/names that must always be written a specific way?
7. **Hardcoded values to watch for** — Prices, API keys, commission rates that should never be in code?
8. **License prefix or format** — If you have product licenses/keys, what format?

After collecting Stage 2, write `memory/project-overview.md`:

```markdown
---
name: Project Overview
description: {company} architecture, tech stack, key directories, and conventions
type: project
---

# {company} — Project Overview

**Product:** {one_liner}

## Tech Stack
- **Frontend:** {frontend}
- **Backend:** {backend}
- **Database:** {database}
- **Hosting:** {hosting}
- **Payments:** {payments}
- **AI:** {ai}

## Repo Structure
{repo_structure}

## Key Directories
{directories}

## Brand Rules
- **CORRECT:** "{brand_correct}"
- **WRONG:** {brand_wrong_examples}

## Off-Limits (Never Hardcode)
{hardcoded_rules}
```

Also update the root `CLAUDE.md` with the project-specific rules.

---

## Stage 3: Your Domains

Ask:

1. **What domains do you work across?** (multi-select)
   - Coding / Development
   - Marketing / Content
   - Financial / Analytics
   - Customer Support
   - Operations / Admin
   - Other (specify)

2. For each selected domain, ask:
   - What tools/platforms do you use? (e.g., GitHub, Stripe, Mailchimp, etc.)
   - Any domain-specific conventions or rules?

3. **Which domain is your primary?** (This becomes the default context)

After collecting Stage 3, generate domain-specific `CLAUDE.md` files for each selected domain under `domains/{domain}/CLAUDE.md`. Only create folders for domains the user selected.

---

## Stage 4: Your Workflow

Ask:

1. **Session start behavior?** Options:
   - Load prior session state + check open items (Recommended)
   - Load prior session state only
   - Clean start every time
2. **Session end behavior?** Options:
   - Auto-save branch, commits, and uncommitted work (Recommended)
   - Manual save only
3. **Do you use git worktrees?** Yes/No
4. **Daily reminders?** Options:
   - Yes, check open items every morning (Recommended)
   - No automatic reminders
5. **Track open items persistently?** Yes/No (Recommended: Yes)
6. **Git commit style?** Options:
   - Conventional commits (feat:, fix:, chore:)
   - Free-form descriptive
   - Project-specific (specify)
7. **PR format preference?** Options:
   - Summary + test plan (Recommended)
   - Minimal
   - Detailed with screenshots

After Stage 4, configure:
- `settings.local.json` with appropriate hooks
- `.claude/hooks/session-start.sh` and `session-end.sh`
- `memory/open-items-daily.md` if tracking enabled
- Daily cron reminder if requested

---

## Stage 5: Off-Limits & Safety

Ask:

1. **Directories/files to never commit?** (defaults: .env, .secrets/, credentials.json, *.key)
2. **Commands requiring confirmation before running?** (defaults: rm -rf, git push --force, DROP TABLE)
3. **Pre-commit checks needed?** Options:
   - Brand name enforcement
   - No hardcoded prices/secrets
   - Lint/format check
   - Test suite
   - None
4. **Anything else Claude should know about safety in your project?**

After Stage 5, configure:
- `.claude/hooks/pre-commit.sh` with selected checks
- Update `CLAUDE.md` Off-Limits section

---

## Final Assembly

After all 5 stages, generate these files:

1. **CLAUDE.md** (root) — filled with project rules
2. **memory/MEMORY.md** — index pointing to all generated memory files
3. **memory/user-preferences.md** — from Stage 1
4. **memory/project-overview.md** — from Stage 2
5. **memory/session-closing.md** — initial empty state
6. **memory/lessons-learned.md** — empty perpetual log
7. **memory/open-items-daily.md** — empty tracker (if enabled)
8. **Domain CLAUDE.md files** — for each selected domain
9. **.claude/settings.local.json** — hooks and permissions
10. **.claude/hooks/*.sh** — configured hook scripts

Present a summary table of everything created and tell the user:
"Your Claude Command Center is ready. Start a new session and your hooks will load automatically. Use `/setup` again anytime to reconfigure."

If daily reminders were requested, set up a CronCreate for the morning check.
