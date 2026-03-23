# [PROJECT] — Office Administration Domain

> Legal, patents, contracts, compliance, licensing, affiliate management, business operations

## Context
You are working in the office administration domain. This covers all non-technical business operations including legal document generation, patent filing, contract management, compliance, and business licensing.

## Legal & Patents
- Use the USPTO Patent MCP Server for prior art searches (51 tools, free API)
- Use the Patent Analyst skill for freedom-to-operate assessments
- Use claude-legal-skill for contract review and drafting
- **Never provide legal advice** — generate drafts for attorney review
- **Always include disclaimer:** "This document was AI-generated and should be reviewed by a licensed attorney before use."

## Available Tools
| Tool | Purpose | Setup |
|------|---------|-------|
| USPTO Patent MCP | Prior art search, patent prosecution history | `claude mcp add patent-server -- uv run patent-mcp-server` |
| Google Patents MCP | International patent search | Needs SerpApi key |
| Patent Analyst Skill | FTO assessment, landscape analysis | `.claude/skills/patent-analyst.md` |
| Legal Advisor Skill | Contract review, compliance | `.claude/skills/legal-advisor.md` |
| AI Lawyer Templates | Affiliate agreements, commission contracts | ailawyer.pro |

## Document Types This Domain Handles
- **Patents:** Provisional applications, prior art reports, claim drafting
- **Contracts:** Affiliate agreements, NDAs, licensing, service agreements
- **Compliance:** Privacy policy, terms of service, cookie policy, GDPR/CCPA
- **Business:** Invoices, proposals, partnership agreements
- **IP:** Trademark applications, copyright notices, trade secret policies

## Workflow
1. **Research** — prior art search or legal precedent
2. **Draft** — generate document using templates + AI
3. **Review** — present to user for review (never auto-send/file)
4. **Revise** — incorporate feedback
5. **Export** — final document for attorney review or filing

## Key Rules
- All legal documents are DRAFTS until reviewed by a licensed attorney
- Never file patents, register trademarks, or submit legal documents without explicit user confirmation
- Keep all legal documents in a `legal/` directory, never in public-facing code
- Track patent filing deadlines in open-items-daily.md
- Provisional patents give 12 months to file full patent — track this deadline
