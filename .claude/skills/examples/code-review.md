---
name: code-review
description: Review all staged or changed files for security issues, bugs, and code quality. Use before committing or when the user asks for a review.
user_invocable: true
---

# Code Review

Review all changed files for issues before committing.

## Steps

1. Run `git diff --staged` to see staged changes. If nothing staged, run `git diff` for unstaged changes.
2. For each changed file, analyze for:

### Security (Critical)
- SQL injection, XSS, command injection
- Hardcoded API keys, passwords, secrets
- Unvalidated user input at system boundaries
- Path traversal vulnerabilities

### Bugs (High)
- Null/undefined references
- Off-by-one errors
- Race conditions
- Unhandled error cases
- Logic errors

### Quality (Medium)
- Unclear naming
- Unnecessary complexity
- Code duplication
- Dead/unreachable code
- Missing error handling at boundaries

### Tests (Low)
- Are changes covered by existing tests?
- Should new tests be added?

## Output

Present findings as a table:

| File | Line | Severity | Issue | Suggestion |
|------|------|----------|-------|------------|

If no issues found, say: "Clean review — no issues found in N files changed."
