---
name: eos
description: End-of-session summary — SAVES to file, does not print full summary in chat. Invoke at the end of any session to produce a comprehensive, Slack-ready summary that is persisted to disk so the user can load it into the next session via `/resume`. Use when the user types `/eos`, `session summary`, "end of session", "wrap up", "save session", "checkpoint".
---

# EOS — Save End-of-Session Summary to File

## Goal
Produce a **zero-detail-loss** summary of the current conversation and **write it to a file** (do NOT dump the full summary in chat). The companion skill `/resume` reads this file at the start of a new session.

## Output behaviour
- **Do NOT print the full summary in chat.** The user has already seen the session unfold; dumping the summary wastes context.
- **DO write the summary to file** using the Write tool.
- **DO confirm in chat** with only these 3 lines:
  1. ✓ Saved to `<full path>`
  2. Topic in one sentence (≤15 words).
  3. `Resume with: /resume`

## Where to save
1. `~/.claude/skills/eos/summaries/session_YYYY-MM-DD_HHMM.md` — dated file (never overwritten)
2. `~/.claude/skills/eos/latest.md` — copy of the same content (overwritten each invocation; this is what `/resume` reads)

Use current system date/time for the filename. If unsure of the time, run `date +%Y-%m-%d_%H%M` via Bash once.

## File contents — format & rules

### Non-negotiable rules
1. **No tables.** User pastes into Slack; tables render badly. Bullets only.
2. **No omission.** Every job ID, user ID, org ID, DB name, test environment URL, screenshot path, recording path, PR link, Slack thread link, do.it ticket, ledger ID, file created/modified mentioned in this conversation MUST appear.
3. **Attach media inline.** Tag each screenshot/recording next to the specific test case or bug it evidences using `_[attach: <filename>]_`. Never drop them in a standalone media section only.
4. **Severity labels on bugs.** `P0`, `P1`, `P2` with a one-line reason.
5. **Scope first.** Start with the context block so a reader can recreate state.
6. **Pending items explicit.** If anything was left untested / uncompleted, list it in a `Pending` section with the reason.
7. **DB writes section.** Any credit grant / update / delete with before → after values and ledger IDs.
8. **Changes on disk section.** Every file/skill/memory entry created or modified this session.
9. **Reference IDs section at the end.** Grouped by purpose.
10. **First line of the file MUST be `# EOS SUMMARY — <date time> IST — <topic>`** so `/resume` can display it in one line.

### Mandatory extraction checklist (run before drafting)
**Context:** PR/ticket, test environment(s), DB(s), user(s), org/project.
**Work done:** Every task attempted → PASS/FAIL/partial. Every bug with severity + repro. Every DB write with ledger IDs. Every file/skill/memory created.
**Media:** Every screenshot path + every recording path + which test/bug each evidences.
**Resource IDs:** Job IDs, user IDs, org IDs, test environment URLs, ledger IDs, PR numbers, do.it tickets, Slack thread URLs.

### File template

```markdown
# EOS SUMMARY — <YYYY-MM-DD HH:MM IST> — <one-line topic>

**Tasks in this session**
- <bullet per distinct task: e.g. PR-2634 QA, credit audit, skill creation, resume build>

---

**<TASK 1 NAME>**

Scope: <test environment, DB, user, PR/ticket, org>

**Verified ✅**
- <item>. _[attach: <filename>]_
- ...

**Bugs ⚠️**
**P0 — <title>.** <evidence/repro>. _[attach: ...]_
- Job IDs: `<id>` → `<id>`

**P1 — ...**

**Observations / earlier in session**
- ...

**Pending ⏳**
- ...

**DB writes performed**
- <op> on `<db>` — `<user_id>` — before → after, ledger `<id>`

---

**<TASK 2 NAME>** (repeat sections as needed)

---

**Changes on disk**
- Skill: `~/.claude/skills/<x>/`
- Memory: `<file>`
- Files: `<path>`

**Reference IDs**

test environments: <URLs>
User IDs: `<id>` (<email>), ...
Org ID: `<id>`
Job IDs — verification: `<id>` → `<id>`, ...
Job IDs — bugs: `<id>` → `<id>`
Ledger IDs: `<n>`, ...
Slack threads: <channel>/<ts>
GitHub: <PR URL>
do.it: <ticket>
```

## Chat confirmation format
After successful file write, output EXACTLY (nothing more):

```
✓ Saved to ~/.claude/skills/eos/summaries/session_<date>_<time>.md
<topic in ≤15 words>
Resume with: /resume
```

## Before writing
Re-read the draft against the checklist. Every file path, every job_id, every ledger id, every bug severity — all present? If not, fix before Write.
- 2026-07-09: Session summaries must inventory every deployed asset and piece of infrastructure created across sessions (e.g. an existing Cloudflare dashboard) — omitting one forces the user to rediscover it and breaks trust in /resume.
