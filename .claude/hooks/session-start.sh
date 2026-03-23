#!/bin/bash
# Claude Command Center — Session Start Hook
# Loads prior session state from memory on every session start.
# Configure in settings.local.json under hooks.SessionStart

# Auto-detect memory directory (works in worktrees too)
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
MEMORY_DIR="$HOME/.claude/projects/$(echo "$REPO_ROOT" | sed 's/[\/:\\]/-/g')/memory"

# Check for prior session state
if [ -f "$MEMORY_DIR/session-closing.md" ]; then
  echo "[Session Memory] Prior session state loaded from session-closing.md"
  echo "  Check MEMORY.md index for full session logs and lessons learned."
else
  echo "[Session Memory] No prior session state found. Run /setup to initialize your Command Center."
fi

exit 0
