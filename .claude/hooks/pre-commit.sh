#!/bin/bash
# Claude Command Center — Pre-Commit Hook
# Enforces project rules before commits. Customize the checks below.
# Configure in settings.local.json under hooks.PreToolUse

# ============================================================
# CONFIGURATION — Edit these for your project
# ============================================================

# Brand name enforcement (case-sensitive)
# Format: "WRONG_PATTERN|CORRECT_FORM"
BRAND_RULES=(
  # Example: "tuninglab|Tuning Labs"
  # Example: "myApp|MyApp"
)

# Patterns that should never appear in committed code
FORBIDDEN_PATTERNS=(
  # Example: "hardcoded_price"
  # Example: "TODO_REMOVE_BEFORE_COMMIT"
  # Example: "sk-[a-zA-Z0-9]{20,}"  # OpenAI API keys
)

# Files/directories that should never be committed
FORBIDDEN_FILES=(
  ".env"
  ".secrets/"
  "credentials.json"
  "*.key"
  "*.pem"
)

# ============================================================
# CHECKS — Do not edit below unless customizing
# ============================================================

ERRORS=0

# Check staged files for brand name violations
if [ ${#BRAND_RULES[@]} -gt 0 ]; then
  for rule in "${BRAND_RULES[@]}"; do
    WRONG=$(echo "$rule" | cut -d'|' -f1)
    CORRECT=$(echo "$rule" | cut -d'|' -f2)
    FOUND=$(git diff --cached --name-only | xargs grep -il "$WRONG" 2>/dev/null)
    if [ -n "$FOUND" ]; then
      echo "ERROR: Found '$WRONG' (should be '$CORRECT') in: $FOUND" >&2
      ERRORS=$((ERRORS + 1))
    fi
  done
fi

# Check for forbidden patterns
if [ ${#FORBIDDEN_PATTERNS[@]} -gt 0 ]; then
  for pattern in "${FORBIDDEN_PATTERNS[@]}"; do
    FOUND=$(git diff --cached --name-only | xargs grep -iEl "$pattern" 2>/dev/null)
    if [ -n "$FOUND" ]; then
      echo "ERROR: Forbidden pattern '$pattern' found in: $FOUND" >&2
      ERRORS=$((ERRORS + 1))
    fi
  done
fi

# Check for forbidden files
for forbidden in "${FORBIDDEN_FILES[@]}"; do
  FOUND=$(git diff --cached --name-only | grep -E "$forbidden" 2>/dev/null)
  if [ -n "$FOUND" ]; then
    echo "ERROR: Forbidden file staged for commit: $FOUND" >&2
    ERRORS=$((ERRORS + 1))
  fi
done

if [ $ERRORS -gt 0 ]; then
  echo "Pre-commit failed with $ERRORS error(s). Fix issues and try again." >&2
  exit 1
fi

exit 0
