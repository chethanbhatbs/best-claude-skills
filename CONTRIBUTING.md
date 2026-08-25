# Contributing

This list has one job: stay true. A wrong number here becomes a wrong number in someone else's decision.

## Adding a skill

One skill per pull request. The entry must follow the existing format exactly:

```markdown
### owner/repo
**Link:** https://github.com/owner/repo
**Description:** One or two sentences. What it does, not why it is great.
**Signals:** <stars> stars / <forks> forks / <licence> / last push <YYYY-MM-DD>

**Analysis.** Two paragraphs. First: what it is genuinely good at and for whom.
Second: a real limitation - maintenance gap, licence constraint, narrow scope,
unverified claim, overlap with another entry. Every entry has one. Find it.

**Use it if:** one line, naming the situation.
```

## The bar

An entry has to clear all four:

1. **Verifiable** - stats pulled from the GitHub API, not a blog post or memory.
2. **Adopted** - real stars and forks, or first-party publication by the vendor whose product it covers.
3. **Maintained** - recent enough to be plausible. If it is not, the entry must say so.
4. **Distinct** - it does something the entries around it do not.

## Rules for the analysis

- **State limitations.** A PR whose analysis has no downside gets closed. Nothing is uniformly good.
- **No unverified numbers.** If the project claims a benchmark ("cuts 65% of tokens", "used by 175,000 people"), attribute it to the project rather than asserting it. Say "the project claims".
- **No marketing voice.** "Revolutionary", "game-changing", "must-have" - all closed on sight.
- **Say when something lower-starred is better.** Popularity is not quality, and this list should be willing to say so.

## Get the stats

```bash
# add your repo to scripts/repos.txt first, then:
./scripts/refresh-stats.sh
```

Use the exact values it prints. Round stars to one decimal place in thousands (171432 -> 171.4k).

## Out of scope

- Skills whose primary purpose is evading AI-use disclosure or detection.
- Offensive-security tooling without a clear authorised-use framing.
- Repos with star counts inconsistent with their engagement.
- Anything you have not actually looked at.

## Removing or correcting an entry

Corrections are as welcome as additions. If a project has gone stale, changed licence, or the analysis is simply wrong, open a PR with the evidence. Include the API output.
