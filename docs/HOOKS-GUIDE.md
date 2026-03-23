# Hooks Guide

## Available Hook Events

| Event | When It Fires | Use For |
|-------|--------------|---------|
| `SessionStart` | Every session start | Loading prior state, checking reminders |
| `SessionEnd` | Every session exit | Saving state, cleanup |
| `PreToolUse` | Before any tool call | Blocking dangerous operations (exit 2 to block) |
| `PostToolUse` | After any tool call | Auto-formatting, auto-testing |
| `UserPromptSubmit` | Before processing user input | Enriching/validating prompts |
| `Notification` | When notifications fire | Custom notification handling |
| `Stop` | When Claude stops | Final cleanup |

## Exit Codes
- `0` = allow (proceed normally)
- `2` = block (PreToolUse only — explanation via stderr)
- Other non-zero = non-blocking error

## Included Hooks

### session-start.sh
Checks for `session-closing.md` and loads prior session state. Prints a reminder to check lessons-learned.md.

### session-end.sh
Captures git branch, last commit, uncommitted changes, worktree status. Writes structured markdown to `session-closing.md`. Must complete within 5 seconds.

### pre-commit.sh
Configurable checks:
- `BRAND_RULES` — array of "wrong|correct" brand name patterns
- `FORBIDDEN_PATTERNS` — regex patterns that should never appear in code
- `FORBIDDEN_FILES` — file patterns that should never be committed

## Adding Custom Hooks

### Auto-Format After File Writes (PostToolUse)
```json
{
  "hooks": {
    "PostToolUse": [{
      "type": "command",
      "command": "npx prettier --write $CLAUDE_FILE_PATH",
      "event": "Write"
    }]
  }
}
```

### Block .secrets/ Access (PreToolUse)
```json
{
  "hooks": {
    "PreToolUse": [{
      "type": "command",
      "command": "bash -c 'echo $CLAUDE_TOOL_INPUT | grep -q .secrets && echo \"BLOCKED: .secrets/ is off-limits\" >&2 && exit 2 || exit 0'"
    }]
  }
}
```

### Auto-Run Tests After Code Changes (PostToolUse)
```json
{
  "hooks": {
    "PostToolUse": [{
      "type": "command",
      "command": "npm test -- --bail",
      "event": "Edit"
    }]
  }
}
```
