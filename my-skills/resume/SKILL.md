---
name: resume
description: Load the previous session's EOS summary as context for this conversation. Reads `~/.claude/skills/eos/latest.md` (or a specific dated file if the user asks) and uses it to resume where the last session ended. Use when the user types `/resume`, "load last session", "pick up where we left off", "resume from EOS", "what was I doing last time", or starts a new conversation after running `/eos`.
---

# RESUME — Load Previous Session Context

## Goal
Restore full context from the previous session's `/eos` file so the user can continue work without re-briefing.

## When invoked

### Default behaviour (`/resume` with no args)
1. Read `~/.claude/skills/eos/latest.md` using the Read tool.
2. If the file does not exist → respond: "No saved EOS summary found. Run `/eos` at the end of a session to save one."
3. Parse the first line (`# EOS SUMMARY — <date> — <topic>`) to identify the session.
4. Respond with a short confirmation — 3–5 lines max — NOT the full summary:
   ```
   ✓ Loaded <topic> from <date time>.
   Key carryover:
   - <Pending items — bulleted, top 3–5>
   - <Active bugs — IDs only>
   - <Relevant user / test environment / DB currently in play>
   What would you like to do next?
   ```

### If user asks for a specific date / older summary
- `/resume 2026-04-20` → read `~/.claude/skills/eos/summaries/session_2026-04-20_*.md` (newest match if multiple)
- `/resume --list` → list the last 10 summary files with their topics
- `/resume --full` → print the full summary contents (only when explicitly asked)

## Rules
1. **Do NOT dump the whole summary into chat by default.** It burns tokens the model doesn't need to see verbatim — the Read tool call already loaded it into context. Just surface the pending/active pieces the user is most likely to act on.
2. **Treat the loaded summary as ground truth** for IDs, DBs, test environments, pending items. Use the same job_ids, user_ids, ledger_ids, DB names in subsequent actions — do not ask the user to re-share them.
3. **If pending items reference DB state** (e.g., "credit balance set to 0.5 for banner test"), still verify before acting — state may have changed between sessions.
4. **Don't assume the user wants to continue all pending items.** Just surface them and ask what's next.

## Extraction priorities (top to bottom)
When parsing `latest.md`, surface these to the user in order:
1. **Pending ⏳** section — most actionable
2. **Bugs ⚠️** — active P0/P1 that may still need filing or retesting
3. **Current DB state** — last credit balance, active test environment, user in play
4. **Tasks in this session** — for orientation
5. Everything else stays loaded but isn't summarised in chat

## Example output after loading

```
✓ Loaded "PR-1234 QA" from 2026-04-21 02:15 IST.
Key carryover:
- Pending: re-verify the fix on the test environment
- Pending: Agent Name Display fix, BuyCreditsModal distinction, session-scoped dismiss
- Active bugs: P0 GitHub pull 404 on 0a92fdf1 and 9bd039d1; P0 message-disappears on E3-stop
- Current DB state: test-db, user 1234abcd, credit ≈ 0.5 (banner test)
What would you like to do next?
```

## Before responding
Read `latest.md`. If empty or malformed, fail gracefully: "EOS summary file exists but looks incomplete — want me to inspect `<path>`?"
