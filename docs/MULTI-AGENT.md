# Multi-Agent Orchestration Guide

## Agent Types

| Agent Type | Best For | Context |
|-----------|---------|---------|
| `Explore` | Finding files, searching code, quick questions | Read-only, fast |
| `Plan` | Designing implementation approaches | Read-only, architectural |
| `general-purpose` | Complex multi-step tasks, writing code | Full tool access |

## Swarm Patterns

### Research Swarm (10+ agents)
Launch many agents in parallel to research different aspects of a topic. Each agent gets a focused research area. Results are compiled after all return.

```
Agent 1: Research topic A → findings
Agent 2: Research topic B → findings
Agent 3: Research topic C → findings
...
Compile all findings into unified report
```

**Best for:** Market research, technology surveys, competitive analysis, knowledge base building.

### Divide-and-Conquer (3-5 agents)
Split a large task into independent pieces. Each agent works on one piece. Results are merged.

```
Agent 1: Build component A
Agent 2: Build component B
Agent 3: Build component C
Merge all components
```

**Best for:** Large refactors, multi-file changes, database migrations.

### Expert Panel (2-3 agents)
Ask multiple agents the same question from different perspectives. Compare their answers.

```
Agent 1: Evaluate from security perspective
Agent 2: Evaluate from performance perspective
Agent 3: Evaluate from UX perspective
Compare and synthesize
```

**Best for:** Architecture decisions, code review, risk assessment.

## Shared Bus Pattern

For coordinating between parallel Claude sessions (e.g., one building frontend, one building backend), use a shared memory file:

```markdown
# memory/shared-bus.md
---
name: Shared Memory Bus
description: Real-time coordination log between parallel Claude sessions
type: project
---

## Active Sessions
- Session A: Working on frontend auth flow
- Session B: Working on backend auth API

## Messages
[2026-03-22 14:30] Session A: Auth component expects POST /api/auth/login with {email, password}
[2026-03-22 14:32] Session B: Acknowledged. Endpoint ready at /api/auth/login, returns {token, user}
```

## Tips
- Launch independent agents in parallel (single message, multiple tool calls)
- Use `run_in_background: true` for agents you don't need results from immediately
- Give each agent a clear, complete prompt — they don't share context
- Use `isolation: "worktree"` for agents that write code to avoid conflicts
