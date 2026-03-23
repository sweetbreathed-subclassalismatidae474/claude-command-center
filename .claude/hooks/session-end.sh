#!/bin/bash
# Claude Command Center — Session End Hook
# Auto-saves branch, commits, and uncommitted work to session-closing.md
# Must complete within 5 seconds (hook timeout).
# Configure in settings.local.json under hooks.SessionEnd

# Read hook input from stdin
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | grep -o '"session_id":"[^"]*"' | head -1 | cut -d'"' -f4)

# Auto-detect paths
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
MEMORY_DIR="$HOME/.claude/projects/$(echo "$REPO_ROOT" | sed 's/[\/:\\]/-/g')/memory"

# Ensure memory directory exists
mkdir -p "$MEMORY_DIR"

# Capture git state
BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
LAST_COMMIT=$(git log -1 --oneline 2>/dev/null || echo "no commits")
UNCOMMITTED=$(git diff --stat 2>/dev/null || echo "no changes")
UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null | head -10)
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Capture worktree status
WORKTREES=""
if git worktree list &>/dev/null; then
  while IFS= read -r line; do
    WT_PATH=$(echo "$line" | awk '{print $1}')
    WT_BRANCH=$(echo "$line" | grep -o '\[.*\]' | tr -d '[]')
    if [ "$WT_PATH" != "$REPO_ROOT" ]; then
      WT_STATUS=$(cd "$WT_PATH" 2>/dev/null && git diff --stat 2>/dev/null | tail -1)
      WORKTREES="$WORKTREES\n- $WT_BRANCH ($WT_PATH): $WT_STATUS"
    fi
  done < <(git worktree list 2>/dev/null)
fi

# Write session-closing.md
cat > "$MEMORY_DIR/session-closing.md" << ENDOFFILE
---
name: Session closing state
description: Auto-saved session state — branch, commits, uncommitted work
type: project
---

# Session State — $(date +"%Y-%m-%d %H:%M")

## Git State
- **Branch:** $BRANCH
- **Last commit:** $LAST_COMMIT
- **Session ID:** ${SESSION_ID:-unknown}
- **Saved at:** $TIMESTAMP

## Uncommitted Changes
\`\`\`
$UNCOMMITTED
\`\`\`

## Untracked Files
$UNTRACKED
$([ -n "$WORKTREES" ] && echo -e "\n## Active Worktrees$WORKTREES")

## Open Items
Check \`open-items-daily.md\` for current task list.
ENDOFFILE

echo "[Session Memory] State saved to session-closing.md" >&2
exit 0
