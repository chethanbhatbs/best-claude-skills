# Best Claude Skills

A curated, evidence-backed index of the best **Agent Skills** for Claude (Claude Code, Claude Desktop, and the Claude apps) - plus the directories where new ones show up first.

Every entry gives you the three things you actually need:

1. **Link** - straight to the source repo.
2. **Description** - what the skill does, in one line.
3. **Analysis** - who it is for, what it is good at, and where it falls short.

**All numbers in this README were pulled from the GitHub REST API on 2026-08-25.** Stars, forks, licence and last-push dates are verified facts as of that date. The *Analysis* lines are editorial judgement based on each project's stated scope plus those signals - they are not a line-by-line audit of every skill file. Re-run `scripts/refresh-stats.sh` to refresh the numbers.

> New to skills? A Skill is a folder with a `SKILL.md` (name + description + instructions), optionally bundled with scripts and reference files. The agent reads the description, decides when the skill applies, and loads the body only then. Spec: [anthropics/skills/spec](https://github.com/anthropics/skills/tree/main/spec).

---

## My own skills

Skills I wrote and use every day. Each one is a single `SKILL.md` inside [`my-skills/`](my-skills/).

| Skill | What it does | Open | Raw file |
|---|---|---|---|
| **ui-taste** | UI and UX rules: one look across every screen, no AI-looking design, clear states, a check to run before calling a screen done. | [SKILL.md](https://github.com/chethanbhatbs/best-claude-skills/blob/main/my-skills/ui-taste/SKILL.md) | [raw](https://raw.githubusercontent.com/chethanbhatbs/best-claude-skills/main/my-skills/ui-taste/SKILL.md) |
| **eos** | End of session: saves a full summary of the session to a file, so nothing is lost. | [SKILL.md](https://github.com/chethanbhatbs/best-claude-skills/blob/main/my-skills/eos/SKILL.md) | [raw](https://raw.githubusercontent.com/chethanbhatbs/best-claude-skills/main/my-skills/eos/SKILL.md) |
| **resume** | Start of next session: loads that saved summary so work picks up where it stopped. Pairs with `eos`. | [SKILL.md](https://github.com/chethanbhatbs/best-claude-skills/blob/main/my-skills/resume/SKILL.md) | [raw](https://raw.githubusercontent.com/chethanbhatbs/best-claude-skills/main/my-skills/resume/SKILL.md) |
| **guide-mode** | Claude guides, you run every step. Exact steps, one at a time, and it checks what you paste back. | [SKILL.md](https://github.com/chethanbhatbs/best-claude-skills/blob/main/my-skills/guide-mode/SKILL.md) | [raw](https://raw.githubusercontent.com/chethanbhatbs/best-claude-skills/main/my-skills/guide-mode/SKILL.md) |

**Install one** (Claude Code):

```bash
mkdir -p ~/.claude/skills/ui-taste
curl -o ~/.claude/skills/ui-taste/SKILL.md \
  https://raw.githubusercontent.com/chethanbhatbs/best-claude-skills/main/my-skills/ui-taste/SKILL.md
```

Swap `ui-taste` for any skill name above. It loads in the next Claude Code session.

---

## Skills I use and like

Made by others. I use these every day. Each folder in [`skills-i-use/`](skills-i-use/) explains why and how to install, and links to the original repo (nothing is copied).

| Skill | What it does | My notes | Source |
|---|---|---|---|
| **claude-mem** | Memory across sessions: records what the agent did and brings it back next time. | [notes](skills-i-use/claude-mem/README.md) | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) |
| **agent-browser** | Lets the agent drive a real browser: click, type, screenshot. | [notes](skills-i-use/agent-browser/README.md) | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| **i-have-adhd** | Shapes Claude's answers for ADHD: next action first, numbered steps, no side topics. | [notes](skills-i-use/i-have-adhd/README.md) | [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) |

---

## Contents

- [My own skills](#my-own-skills)
- [Skills I use and like](#skills-i-use-and-like)
- [How to read this list](#how-to-read-this-list)
- [Start here (top 5)](#start-here-top-5)
- [1. Official and foundational](#1-official-and-foundational)
- [2. Engineering methodology and agent behaviour](#2-engineering-methodology-and-agent-behaviour)
- [3. Codebase understanding and token efficiency](#3-codebase-understanding-and-token-efficiency)
- [4. Design, frontend and diagrams](#4-design-frontend-and-diagrams)
- [5. Writing and research](#5-writing-and-research)
- [6. Security](#6-security)
- [7. Domain packs](#7-domain-packs)
- [8. Skill authoring tools](#8-skill-authoring-tools)
- [9. Directories and marketplaces](#9-directories-and-marketplaces)
- [Anthropic's 19 official skills](#anthropics-19-official-skills)
- [Selection criteria](#selection-criteria)
- [Contributing](#contributing)

---

## How to read this list

Each entry carries a **Signals** line with verified metadata:

`Signals: <stars> stars / <forks> forks / <licence> / last push <date>`

- **Licence `none`** means GitHub detected no licence file. Legally that is "all rights reserved" by default - fine to read, risky to redistribute or fork into a product. Check the repo for its own terms.
- **`NOASSERTION`** means a licence file exists but GitHub could not classify it. Read it before you depend on it.
- **Last push** is the maintenance signal that matters most. Skills wrap fast-moving agent behaviour; a repo untouched for months is more likely to reference retired flags or old file layouts.

---

## Start here (top 5)

If you install nothing else, install these.

| # | Skill | Why it earns the slot |
|---|-------|----------------------|
| 1 | [anthropics/skills](https://github.com/anthropics/skills) | The reference implementation and the spec. Everything else is downstream of it. |
| 2 | [obra/superpowers](https://github.com/obra/superpowers) | The most-adopted opinionated methodology layer; changes how the agent plans, not just what it knows. |
| 3 | [mattpocock/skills](https://github.com/mattpocock/skills) | Practitioner-grade engineering skills, actively maintained, MIT. |
| 4 | [NVIDIA/SkillSpector](https://github.com/NVIDIA/SkillSpector) | Scan any skill before you install it. Skills execute instructions and scripts - treat them as supply chain. |
| 5 | [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | The broadest maintained directory; where you go next after this list. |

---

## 1. Official and foundational

### anthropics/skills
**Link:** https://github.com/anthropics/skills
**Description:** Anthropic's public repository for Agent Skills - 19 first-party skills plus the format spec and a skill template. Includes the document skills (`docx`, `pdf`, `pptx`, `xlsx`) that power Claude's file-creation features in production.
**Signals:** 171.4k stars / 20.4k forks / licence `none` (source-available, see `LICENSE.txt` per skill) / last push 2026-08-21

**Analysis.** This is the canonical reference and the only place where the skill format itself is normatively defined (`spec/` and `template/`). Two things make it uniquely valuable: the document skills are the *actual* production skills, not toy examples, so they show you what a large, script-backed skill looks like at scale; and `skill-creator` gives you evals and description-tuning, which is the part everyone gets wrong. Also installable as a Claude Code plugin marketplace.

The catch is licensing: GitHub detects no repo-level licence, and the document skills are explicitly source-available rather than open source. Read them, learn from them, but do not assume you can vendor them into a commercial product. Also note these skills are tuned for Anthropic's own house style (`brand-guidelines`, `internal-comms`) - useful as structure, not as content you ship unedited.

**Use it if:** you are writing your own skills, or you want the highest-quality worked examples that exist.

---

### vercel-labs/agent-skills
**Link:** https://github.com/vercel-labs/agent-skills
**Description:** Vercel's official collection of agent skills - framework and deployment knowledge for Next.js/Vercel-shaped work, published by the vendor itself.
**Signals:** 30.4k stars / 2.7k forks / licence `none` / last push 2026-08-21

**Analysis.** The strongest argument for vendor-published skills: the people who ship the framework encode how to use it correctly, which beats an agent guessing from stale training data. If your stack is Next.js, this is the single highest-leverage install because framework APIs churn faster than model cutoffs.

Limits are equally clear: it is deliberately Vercel-shaped. On a non-Vercel stack, some of it is inert and some of it will nudge you toward Vercel-specific patterns you did not ask for. No detected licence file, so treat redistribution carefully.

**Use it if:** you build on Next.js or deploy to Vercel.

---

### vercel-labs/skills
**Link:** https://github.com/vercel-labs/skills
**Description:** `npx skills` - an open, agent-agnostic CLI for finding and installing skills across Claude Code, Codex, Cursor and other harnesses.
**Signals:** 29.6k stars / 2.5k forks / MIT / last push 2026-08-18

**Analysis.** This is infrastructure rather than a skill, and it belongs on the list because manual skill management does not scale past about five installs. It normalises install paths across harnesses, which matters if you use more than one agent.

The trade-off is that a one-command installer makes it trivially easy to pull an unaudited skill straight into your agent's instruction space. Pair it with SkillSpector rather than treating convenience as safety. TypeScript, MIT, actively pushed.

**Use it if:** you manage skills across more than one agent, or more than a handful in total.

---

## 2. Engineering methodology and agent behaviour

These change *how* the agent works. They are the highest-impact and the highest-risk category - a methodology skill that disagrees with your instincts will fight you on every task.

### obra/superpowers
**Link:** https://github.com/obra/superpowers
**Description:** An agentic skills framework and full software-development methodology - planning discipline, workflow structure, and a large bundled skill library.
**Signals:** 277.2k stars / 24.8k forks / MIT / last push 2026-08-19

**Analysis.** The most-starred skills project on GitHub and the de facto reference for "opinionated methodology as a skill". Its value is that it does not just add knowledge, it imposes process: how work is broken down, when the agent stops to plan, how it verifies. That is exactly what fixes the common failure mode of agents charging ahead confidently in the wrong direction.

The cost is the same as the benefit. It is opinionated, it is large, and it overrides habits you may already have encoded in your own `CLAUDE.md`. If you already run a tight custom workflow, expect collisions. Read the methodology before installing wholesale; many people are better served cherry-picking individual skills from it.

**Use it if:** your agent sessions drift, skip planning, or declare done too early - and you are willing to adopt someone else's process.

---

### mattpocock/skills
**Link:** https://github.com/mattpocock/skills
**Description:** "Skills for Real Engineers" - a working engineer's `.agents` directory published as-is, focused on practical TypeScript-era development craft.
**Signals:** 235.8k stars / 20.1k forks / MIT / last push 2026-08-24

**Analysis.** The appeal here is provenance: this is a real, daily-driven set rather than a curated-for-GitHub collection, and it shows in how specific the guidance is. Very actively maintained (pushed within a day of this snapshot) and cleanly MIT.

The flip side of "straight from my directory" is that it is calibrated to one person's stack and taste. Expect a TypeScript/JS centre of gravity and preferences that are stated as rules rather than options. Treat it as a strong starting template, not scripture.

**Use it if:** you work in the TypeScript ecosystem and want battle-tested defaults fast.

---

### affaan-m/ECC
**Link:** https://github.com/affaan-m/ECC
**Description:** An agent-harness performance system combining skills, "instincts", persistent memory, security guardrails, and research-first development across Claude Code, Codex, OpenCode and Cursor.
**Signals:** 243.0k stars / 36.8k forks / MIT / last push 2026-08-25

**Analysis.** The most ambitious project in this category: it treats the harness itself as the optimisation target rather than any single task. The memory and research-first pieces address the two things that most degrade long agent sessions - lost context and confident guessing. Fork count (36.8k, the highest here) suggests heavy customisation in the wild, which is a genuine signal of usefulness.

Ambition is also the risk. A system that layers memory, instincts and security policy on top of your harness is a lot of surface area to reason about when something behaves oddly, and it is harder to partially adopt than a single-purpose skill. Budget real time to understand it before trusting it on important work.

**Use it if:** you live in the agent all day and want a systematic harness upgrade, not a point fix.

---

### addyosmani/agent-skills
**Link:** https://github.com/addyosmani/agent-skills
**Description:** Production-grade engineering skills for AI coding agents, from a long-standing web-performance and engineering-practices author.
**Signals:** 89.6k stars / 9.6k forks / MIT / last push 2026-08-21

**Analysis.** Strong signal-to-noise. The framing is "production-grade", and the author's track record is in exactly the areas agents are weakest at: performance, maintainability, and the unglamorous engineering practices that do not show up in a demo. Smaller and more focused than superpowers or ECC, which makes it far easier to adopt selectively.

Less of a complete system, so it will not restructure how your agent plans - it raises the quality bar of what it produces. Some overlap with any methodology pack you already run.

**Use it if:** you want quality lifts without handing over your workflow.

---

### multica-ai/andrej-karpathy-skills
**Link:** https://github.com/multica-ai/andrej-karpathy-skills
**Description:** A single `CLAUDE.md` file that improves Claude Code behaviour, derived from Andrej Karpathy's public observations on where LLM coding goes wrong.
**Signals:** 206.7k stars / 21.1k forks / licence `none` / last push 2026-04-20

**Analysis.** The best effort-to-value ratio on this list: one file, no install machinery, and it targets known LLM coding pathologies (over-abstraction, silent assumption, plausible-but-wrong code) rather than adding domain knowledge. Very easy to try and trivially easy to remove.

Two caveats, both real. It has not been pushed since 2026-04-20 - the longest gap among the top-starred entries here - and harness behaviour has moved since. And it carries no detected licence. It is also a derived interpretation of someone's public commentary, not authored or endorsed by them; judge it on whether the rules work for you, not on the name.

**Use it if:** you want a five-minute upgrade with no dependencies.

---

### DietrichGebert/ponytail
**Link:** https://github.com/DietrichGebert/ponytail
**Description:** Makes the agent "think like the laziest senior dev in the room" - bias it toward the smallest change, and toward not writing code at all where possible.
**Signals:** 110.0k stars / 6.1k forks / MIT / last push 2026-08-07

**Analysis.** A sharp, single-idea skill aimed at the most expensive agent failure mode: enthusiastic over-engineering. Agents rewrite when they should patch, add abstraction layers nobody asked for, and produce large diffs that are hard to review. Encoding senior-dev laziness as an explicit value is a genuinely good corrective, and the 110k stars say it lands.

Push it too far and you get under-delivery - the agent declining work that actually needed doing, or patching around a problem that deserved a real fix. It pairs best with a review step that can call out the difference. Note the slightly older last push (2026-08-07) relative to its peers.

**Use it if:** your agent's diffs are consistently bigger than the problem.

---
### OthmanAdi/planning-with-files
**Link:** https://github.com/OthmanAdi/planning-with-files
**Description:** Persistent file-based planning for long-running agent work - crash-proof markdown plans, session recovery after `/clear` or compaction, per-turn re-injection, and a deterministic completion gate.
**Signals:** 26.3k stars / 2.2k forks / MIT / last push 2026-08-22

**Analysis.** This solves a specific, painful and very real problem: context loss. When a long session compacts or gets cleared, the plan evaporates and the agent silently starts improvising. Writing the plan to disk and re-injecting it each turn is the correct architectural fix, and the "deterministic completion gate" directly attacks premature done-declaration. Installable via npm, the Claude Code plugin marketplace, or `npx skills`.

It adds file churn to your working tree and a step you must actually follow for it to help. On short tasks it is pure overhead. Lower star count than the giants above, but it is solving a narrower problem and solving it well.

**Use it if:** you run multi-hour sessions, or you have ever watched an agent forget its own plan mid-task.

---

## 3. Codebase understanding and token efficiency

### Graphify-Labs/graphify
**Link:** https://github.com/Graphify-Labs/graphify
**Description:** Turns a codebase - with its docs, SQL schemas, configs and PDFs - into a queryable knowledge graph via local deterministic AST parsing. No vector store; every edge is explained.
**Signals:** 110.2k stars / 10.7k forks / Apache-2.0 / last push 2026-08-24

**Analysis.** The most technically interesting entry on the list. Most "understand my codebase" tooling reaches for embeddings, which are fuzzy, non-reproducible and hard to debug. Deterministic AST parsing with explainable edges gives you an answer you can actually verify, and it runs locally, so no code leaves the machine. Apache-2.0 is the friendliest licence here for commercial use.

The trade-offs follow from the design: AST parsing is language-dependent, so coverage of your particular stack is the question to answer before committing, and graph construction over a large monorepo is not free. It is also a heavier install than a markdown skill.

**Use it if:** you work in a large or unfamiliar codebase and need grounded answers rather than plausible ones.

---

### JuliusBrussee/caveman
**Link:** https://github.com/JuliusBrussee/caveman
**Description:** "Why use many token when few token do trick" - a skill that cuts roughly 65% of tokens by compressing the agent's output style.
**Signals:** 100.7k stars / 5.9k forks / `NOASSERTION` licence / last push 2026-08-24

**Analysis.** Joke framing, serious result. Agent verbosity is a direct cost line and a direct latency line, and a claimed ~65% cut is material if you run agents at volume. Written in Go, actively maintained, and 100k stars suggests the saving is real for a lot of people.

Two honest caveats. The 65% figure is the project's own claim - measure it on your workload before quoting it to anyone. And compressed output degrades exactly where you may not want it to: explanations, review comments, and any text a human other than you will read. Turn it off for handovers. The `NOASSERTION` licence means you should read the licence file before redistributing.

**Use it if:** you are token-constrained and your agent output is for you, not for an audience.

---

## 4. Design, frontend and diagrams

Agents have a recognisable visual default - flat hierarchy, timid palettes, Tailwind boilerplate. This whole category exists to break it.

### nexu-io/open-design
**Link:** https://github.com/nexu-io/open-design
**Description:** Open-source design system for coding agents - prototypes, landing pages, dashboards, slides, images and video, exported as real files (HTML/PDF/PPTX/MP4). Local-first desktop app, works across 20+ CLIs via BYOK.
**Signals:** 91.2k stars / 10.5k forks / Apache-2.0 / last push 2026-08-25

**Analysis.** The most complete design offering here: it spans prototype through export format, which is where most agent design work dies (great in the chat window, unusable as a deliverable). Local-first plus Apache-2.0 plus BYOK makes it a genuinely safe commercial choice, and it was pushed the same day as this snapshot.

It is also the heaviest thing in this section - a desktop app and a system, not a skill file. If you only need better-looking components, this is more than you need. Judge the actual output quality against your own design bar before adopting; scope breadth is not the same as craft.

**Use it if:** design artefacts are a deliverable, not a side effect.

---

### Nutlope/hallmark
**Link:** https://github.com/Nutlope/hallmark
**Description:** An anti-AI-slop design skill for Claude Code, Cursor and Codex - strips the visual tells that make generated UI look generated.
**Signals:** 26.9k stars / 1.4k forks / MIT / last push 2026-08-06

**Analysis.** Narrow, well-aimed and easy to adopt: it targets the specific signature of AI-generated interfaces rather than trying to teach design wholesale. Small surface area, MIT, and it composes fine with whatever component library you already use - which is exactly what you want from a taste skill.

The word "slop" is doing a lot of work; what counts as slop is subjective, and you are adopting the author's taste along with the fix. Last push 2026-08-06 is a little behind its neighbours, though for a taste-and-tokens skill that ages more slowly than tooling.

**Use it if:** your generated UI is functional but looks like every other generated UI.

---

### cathrynlavery/diagram-design
**Link:** https://github.com/cathrynlavery/diagram-design
**Description:** 38 editorial diagram types as self-contained HTML + SVG. Explicitly no shadows, no Mermaid defaults.
**Signals:** 26.4k stars / 1.6k forks / MIT / last push 2026-08-25

**Analysis.** Diagrams are where agent output is worst, because the default path is Mermaid and Mermaid has one look. Self-contained HTML+SVG means the output embeds anywhere - docs, artifacts, slides - with no runtime dependency, which is a real practical win over a renderer that must be present at view time. 38 named types also gives the agent something concrete to choose from instead of defaulting to a flowchart.

It is a fixed catalogue: if your diagram is not one of the 38, you are back to improvising. And the editorial style is a specific aesthetic, not a neutral one.

**Use it if:** you produce reports, docs or decks where the diagrams have to look deliberate.

---

### zarazhangrui/frontend-slides
**Link:** https://github.com/zarazhangrui/frontend-slides
**Description:** Build presentation slides on the web using a coding agent's frontend skills - HTML/CSS as the slide medium rather than a slide tool.
**Signals:** 28.1k stars / 2.3k forks / MIT / last push 2026-06-23

**Analysis.** Smart reframing: agents are far better at HTML/CSS than at any presentation format, so treating a deck as a web page plays to their strengths and gives you version-controllable, diffable slides. Good fit for engineering-audience decks.

The maintenance signal is the weak point - last push 2026-06-23, the oldest in this section by a clear margin. And HTML decks are awkward in an organisation that lives in PowerPoint or Google Slides; check the export story matches how your audience actually consumes decks. For `.pptx` output specifically, Anthropic's `pptx` skill is the more direct route.

**Use it if:** your slides are for a technical audience and live in a repo.

---

### alchaincyf/huashu-design
**Link:** https://github.com/alchaincyf/huashu-design
**Description:** HTML-native design skill for Claude Code - high-fidelity prototypes, slides and animation, with 20 design philosophies, a 5-dimension review pass, and MP4 export. Agent-agnostic.
**Signals:** 23.5k stars / 2.7k forks / MIT / last push 2026-08-25

**Analysis.** The distinguishing feature is the 5-dimension review pass: generating a design and then critiquing it against explicit criteria is a meaningfully better loop than one-shot generation, and it is the closest thing here to how a human designer actually works. MP4 export covers motion, which almost nothing else here does. Actively maintained.

Documentation is substantially Chinese-language, so factor in translation friction if that is a barrier for your team. The "20 design philosophies" framing is broad enough that you should sample the actual output before committing.

**Use it if:** you want generate-then-critique rather than generate-and-hope.

---
## 5. Writing and research

### mvanhorn/last30days-skill
**Link:** https://github.com/mvanhorn/last30days-skill
**Description:** Researches any topic across Reddit, X, YouTube, Hacker News, Polymarket and the open web, then synthesises a grounded summary of recent discussion.
**Signals:** 59.2k stars / 5.2k forks / MIT / last push 2026-08-23

**Analysis.** Directly attacks the knowledge-cutoff problem, and does it better than a plain web search by pulling from where discussion actually happens rather than where SEO content lives. Including Polymarket is a genuinely novel touch - prediction-market pricing is a quantified signal on contested questions, not another opinion. Highest-starred single-purpose research skill here.

Source quality is the obvious risk: Reddit and X are high-recall, low-precision, and a synthesis is only as grounded as what it sampled. Check the citations rather than trusting the summary. It also depends on those platforms remaining accessible, which is outside the maintainer's control.

**Use it if:** you need to know what happened after the model's cutoff, on a topic where the discussion is the data.

---

### blader/humanizer
**Link:** https://github.com/blader/humanizer
**Description:** Removes the signs of AI-generated writing from text.
**Signals:** 37.7k stars / 3.3k forks / MIT / last push 2026-08-19

**Analysis.** A focused fix for a real problem: agent prose has a signature - hedge stacking, tricolons, "it's not just X, it's Y", closing summaries nobody asked for - and readers now detect it instantly. Removing those tells makes writing land better regardless of who wrote it, so the value holds even if you disclose AI use. A Chinese-localised fork, [op7418/Humanizer-zh](https://github.com/op7418/Humanizer-zh) (16.0k stars), exists if you need it.

Be clear-eyed about the use case. Making writing read naturally is legitimate; using it to defeat disclosure requirements in academic or professional contexts is not, and the skill cannot tell the difference. It also cannot fix writing that is empty - stylistic tells are the symptom, thin content is the disease.

**Use it if:** your drafts read as machine-generated and that is costing you the reader.

---

### Imbad0202/academic-research-skills
**Link:** https://github.com/Imbad0202/academic-research-skills
**Description:** A staged academic workflow for Claude Code: research to write to review to revise to finalise.
**Signals:** 43.6k stars / 3.5k forks / `NOASSERTION` licence / last push 2026-08-24

**Analysis.** The pipeline framing is the value. Academic writing fails when it is treated as one generation step; forcing distinct research, drafting, review and revision stages mirrors how the work is actually done and gives natural checkpoints for a human to intervene. Well-adopted and actively maintained.

Verify how it handles citations before using it on anything submitted - fabricated or subtly wrong references are the single most damaging failure mode in this domain, and no star count protects you from it. `NOASSERTION` licence means read the terms. And check your institution's AI-use policy first; that is on you, not the tool.

**Use it if:** you write papers, literature reviews or theses and want structure rather than a first draft.

---

### Orchestra-Research/AI-Research-SKILLs
**Link:** https://github.com/Orchestra-Research/AI-Research-SKILLs
**Description:** An open library of AI research and engineering skills, aimed at turning a coding agent into a competent AI-research agent.
**Signals:** 12.0k stars / 873 forks / MIT / last push 2026-06-16

**Analysis.** The most specialised entry on the list, and the value is depth: ML research has its own conventions - ablations, baselines, experiment hygiene, TeX-first writing - that general engineering skills do not encode. Clean MIT licence.

It is also the smallest by adoption (12.0k stars, 873 forks) and the least recently pushed in this section (2026-06-16), in a field that moves faster than any other. Treat parts of it as potentially stale and verify against current practice.

**Use it if:** you do ML research specifically. Otherwise skip it.

---

## 6. Security

Skills are executable instructions plus scripts. Installing one is a supply-chain decision. This section is not optional.

### NVIDIA/SkillSpector
**Link:** https://github.com/NVIDIA/SkillSpector
**Description:** A security scanner for AI agent skills - detects prompt injection, data exfiltration, malicious patterns and supply-chain risk in Claude Code, Codex and MCP skills before you install them.
**Signals:** 14.9k stars / 1.2k forks / Apache-2.0 / last push 2026-08-24

**Analysis.** The most under-starred important project on this list. A skill's whole job is to inject instructions into your agent's context and often to ship scripts alongside them; a malicious one can exfiltrate credentials or quietly steer behaviour, and nothing in a `SKILL.md` looks dangerous at a glance. NVIDIA maintaining it, under Apache-2.0, with a push the day before this snapshot, is about as good a provenance story as this ecosystem offers.

Like every scanner it is pattern-based: a clean scan is evidence, not proof, and it will not catch a novel or well-obfuscated attack. Use it as one gate, not the only one - still read skills that touch credentials, network calls or your shell.

**Use it if:** you install skills from anyone other than yourself. That is everyone reading this.

---

### mukul975/Anthropic-Cybersecurity-Skills
**Link:** https://github.com/mukul975/Anthropic-Cybersecurity-Skills
**Description:** 817 structured cybersecurity skills mapped to six frameworks - MITRE ATT&CK, NIST CSF 2.0, MITRE ATLAS, D3FEND, NIST AI RMF and MITRE F3 - across 29 security domains.
**Signals:** 31.0k stars / 3.7k forks / Apache-2.0 / last push 2026-08-24

**Analysis.** Framework mapping is what separates this from a pile of security prompts. Mapping to ATT&CK, D3FEND and NIST CSF means output slots directly into how security teams already report and audit, which is the difference between an interesting answer and one you can put in a document. ATLAS and NIST AI RMF coverage is notably current. Apache-2.0 and actively maintained.

817 skills is a very large surface to have vetted individually - assume variable depth and verify the specific ones you rely on. And this is dual-use by nature: appropriate for defence, authorised testing and research; your authorisation to run something is a question the repo cannot answer for you.

**Use it if:** you work in security and need framework-aligned output.

---

## 7. Domain packs

### calesthio/OpenMontage
**Link:** https://github.com/calesthio/OpenMontage
**Description:** Open-source agentic video production system - 12 production pipelines, 100+ tools, and 700+ skill and production-knowledge files.
**Signals:** 50.2k stars / 6.3k forks / AGPL-3.0 / last push 2026-08-22

**Analysis.** The most ambitious domain pack here and the clearest example of skills carrying real production knowledge rather than prompts. Video is a genuinely hard multi-step pipeline, and encoding it as tools plus knowledge files is the right shape for it.

**Check the licence before you build on it: AGPL-3.0 is the only copyleft licence on this list.** If you offer a modified version as a network service, AGPL's obligations reach you. That is a decision for whoever owns your legal risk, not an afterthought. Scale also means weight - this is a system to commit to, not a skill to try.

**Use it if:** video production is core work and AGPL is acceptable to you.

---

### kepano/obsidian-skills
**Link:** https://github.com/kepano/obsidian-skills
**Description:** Agent skills for Obsidian - teaches the agent to use the Obsidian CLI and open formats including Markdown, Bases and JSON Canvas.
**Signals:** 47.2k stars / 3.4k forks / MIT / last push 2026-06-08

**Analysis.** Published by Obsidian's own maintainer, which puts it in the same trust tier as the Vercel collection: first-party knowledge of the formats and CLI. The open-formats emphasis matters - your notes stay portable Markdown and JSON Canvas rather than getting locked into an agent's own store.

Last push 2026-06-08 is the oldest in this section, though file formats drift more slowly than APIs, so the staleness risk is lower than the date suggests. Obviously useless if you do not use Obsidian.

**Use it if:** Obsidian is your knowledge base.

---

### coreyhaines31/marketingskills
**Link:** https://github.com/coreyhaines31/marketingskills
**Description:** Marketing skills for agents - CRO, copywriting, SEO, analytics and growth engineering.
**Signals:** 45.5k stars / 7.1k forks / MIT / last push 2026-08-24

**Analysis.** The best-adopted non-engineering pack here (7.1k forks is high for the category, suggesting people customise it to their own funnel). Marketing is a good fit for skills because the work is genuinely repeatable-with-variation: same frameworks, different product. Actively maintained, MIT.

Marketing craft is also more taste- and context-dependent than code, and frameworks that worked for one channel or audience transfer badly. Expect to rewrite the specifics. It overlaps with `claude-seo` below on the SEO axis - pick one as primary.

**Use it if:** you own growth or marketing output and want structure under it.

---

### K-Dense-AI/scientific-agent-skills
**Link:** https://github.com/K-Dense-AI/scientific-agent-skills
**Description:** 163 validated science skills plus 100+ scientific databases spanning biology, chemistry, medicine and drug discovery, following the open Agent Skills standard.
**Signals:** 34.3k stars / 3.3k forks / MIT / last push 2026-08-24

**Analysis.** The database integration is what makes this more than a prompt library - grounding scientific work in real databases is the difference between a hypothesis and a hallucination, and it is the one thing a general agent absolutely cannot do on its own. "Validated" and the claimed user base are the project's own statements; the databases are checkable, so check those. MIT, actively maintained, and one of the older projects here (created 2025-10-19), which is a maturity signal.

Domain rigour still has to come from you. In medicine and drug discovery the failure cost is high and no skill file changes who is accountable for the output.

**Use it if:** you do life-sciences or chemistry research.

---

### phuryn/pm-skills
**Link:** https://github.com/phuryn/pm-skills
**Description:** 100+ product-management skills, commands and plugins spanning discovery, strategy, execution, launch and growth.
**Signals:** 25.6k stars / 2.7k forks / MIT / last push 2026-07-03

**Analysis.** Covers the full PM lifecycle rather than just the writing tasks agents are usually pointed at, and the discovery and strategy stages are where a structured prompt actually adds something. MIT, clean scope.

Last push 2026-07-03 is the oldest in this section apart from `obsidian-skills`. PM artefacts are also the most org-specific documents in any company - your PRD template, your prioritisation model, your launch checklist. Expect this as scaffolding to be rewritten, not adopted.

**Use it if:** you are a PM starting from a blank page more often than you would like.

---

### AgriciDaniel/claude-seo
**Link:** https://github.com/AgriciDaniel/claude-seo
**Description:** A universal SEO skill - 25 sub-skills and 18 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, backlinks, local SEO, semantic clustering, e-commerce and international SEO, plus PDF/Excel reporting.
**Signals:** 15.0k stars / 2.2k forks / MIT / last push 2026-08-20

**Analysis.** The most thorough SEO decomposition here, and GEO/AEO coverage (optimising for answer engines rather than blue links) is the part that is actually current - most SEO material has not caught up to it. Built-in PDF/Excel reporting means client-ready output, not just advice.

SEO guidance decays faster than almost any domain on this list, so the 2026-08-20 push date is doing real work; re-check it before relying on tactics. Some extensions depend on paid third-party APIs (DataForSEO, Firecrawl), so factor in cost. Overlaps with `marketingskills`.

**Use it if:** SEO is a recurring deliverable rather than an occasional question.

---

### Donchitos/Claude-Code-Game-Studios
**Link:** https://github.com/Donchitos/Claude-Code-Game-Studios
**Description:** Turns Claude Code into a game-dev studio - 49 agents, 72 workflow skills and a coordination system mirroring a real studio hierarchy.
**Signals:** 24.5k stars / 3.5k forks / MIT / last push 2026-05-21

**Analysis.** The most interesting *structural* idea in this section: modelling a studio hierarchy so specialised agents coordinate the way departments do. Whether or not you make games, the coordination pattern is worth reading if you are designing multi-agent systems.

It is also one of the least recently maintained entries here (last push 2026-05-21, roughly three months before this snapshot) and the one whose complexity-to-payoff ratio is hardest to justify - 49 agents is a lot of moving parts to debug when output goes sideways. Try a slice before committing.

**Use it if:** you build games, or you are researching multi-agent coordination patterns.

---
## 8. Skill authoring tools

### yusufkaraaslan/Skill_Seekers
**Link:** https://github.com/yusufkaraaslan/Skill_Seekers
**Description:** Converts documentation sites, GitHub repositories and PDFs into Claude skills, with automatic conflict detection between overlapping skills.
**Signals:** 14.8k stars / 1.5k forks / MIT / last push 2026-08-25

**Analysis.** The conflict detection is the standout feature and the reason this beats a hand-rolled scraper. Once you pass roughly ten skills, overlapping trigger descriptions start firing the wrong skill at the wrong moment, and that failure is maddening to diagnose because nothing errors - the agent just behaves oddly. Nothing else on this list addresses it. One of the older projects here (created 2025-10-17) and pushed the day of this snapshot.

Generated skills are only as good as the source docs, and auto-conversion tends to produce bulky skills that need trimming - the description field in particular usually needs hand-tuning, because triggering accuracy is a writing problem, not an extraction problem.

**Use it if:** you need to teach an agent an internal or niche library that is not in its training data.

---

### virgiliojr94/book-to-skill
**Link:** https://github.com/virgiliojr94/book-to-skill
**Description:** Turns a technical book PDF into a Claude Code skill you can reference while you work.
**Signals:** 25.3k stars / 2.6k forks / MIT / last push 2026-08-24

**Analysis.** A clean idea with an obvious use: turn the reference book you already own into something the agent consults at the moment of relevance rather than something you re-read. Better adopted than Skill_Seekers despite being narrower and newer (created 2026-05-01), which says the workflow resonates.

Copyright is the thing to be deliberate about: converting a book you own into a personal reference is one situation, distributing that skill is another. The repo cannot make that call for you. Quality also depends heavily on the PDF - a well-structured technical book converts far better than a scanned one.

**Use it if:** you have a specific technical book you keep returning to.

---

## 9. Directories and marketplaces

Use these to find what this list does not cover. Ranked by usefulness, not stars.

### VoltAgent/awesome-agent-skills
**Link:** https://github.com/VoltAgent/awesome-agent-skills
**Description:** 1000+ agent skills from official dev teams and the community - including skills published by Anthropic, Google Labs, Vercel, Stripe, Cloudflare, Netlify, Trail of Bits, Sentry, Expo, Hugging Face and Figma - compatible with Claude Code, Codex, Gemini CLI and Cursor.
**Signals:** 32.1k stars / 3.4k forks / MIT / last push 2026-08-24

**Analysis.** The best directory to check second. What sets it apart is the split between *official* vendor-published skills and community ones - vendor provenance is the single most useful trust signal in this ecosystem, and most lists flatten it away. Cross-harness coverage means it stays useful if you move off Claude Code. Actively maintained, MIT.

At 1000+ entries, inclusion is closer to catalogue than endorsement. Use the official-team section as a shortlist and treat the community section as search results.

**Use it if:** you want the widest maintained index, with provenance attached.

---

### ComposioHQ/awesome-claude-skills
**Link:** https://github.com/ComposioHQ/awesome-claude-skills
**Description:** A curated list of Claude Skills, resources and tools, organised by category and workflow type.
**Signals:** 73.2k stars / 8.4k forks / licence `none` / last push 2026-08-10

**Analysis.** The highest-starred directory by a wide margin, and the category/workflow organisation makes it easier to browse by need than by name. Good default entry point for someone new to skills.

Maintained by a company in the adjacent tooling space, so read it with that context. No detected licence, and last push 2026-08-10 is slightly behind the more actively updated lists.

**Use it if:** you are browsing by workflow rather than hunting a specific skill.

---

### hesreallyhim/awesome-claude-code
**Link:** https://github.com/hesreallyhim/awesome-claude-code
**Description:** A hand-picked collection of Claude Code resources - skills, agents, status lines, developer tooling and plugins.
**Signals:** 52.9k stars / 4.6k forks / `NOASSERTION` licence / last push 2026-08-25

**Analysis.** The oldest project on this list (created 2025-04-19, months before skills existed as a format) and the only one that covers the whole Claude Code surface rather than skills alone - hooks, status lines, plugins, tooling. When your problem is "how do I make Claude Code better" rather than "which skill do I install", this is the right list. Hand-picked, so inclusion means something. Pushed the day of this snapshot.

Broad scope is the trade-off: skills are one section among many, so it is less deep on skills specifically than VoltAgent's list. `NOASSERTION` licence.

**Use it if:** you want the full Claude Code ecosystem, not just skills.

---
### wshobson/agents
**Link:** https://github.com/wshobson/agents
**Description:** A multi-harness agentic plugin marketplace covering Claude Code, Codex, Cursor, OpenCode, GitHub Copilot and Google Antigravity.
**Signals:** 39.1k stars / 4.2k forks / MIT / last push 2026-08-24

**Analysis.** Marketplace rather than list - installable rather than browsable, which is a different and often more useful thing. Created 2025-07-24, making it one of the longest-running projects here, and it has kept pace across six harnesses. MIT.

Agent-focused as much as skill-focused, so coverage of skills specifically is thinner than the dedicated lists. Marketplace installation is also where supply-chain risk concentrates - scan before you install.

**Use it if:** you want to install across harnesses rather than read about options.

---

### sickn33/agentic-awesome-skills
**Link:** https://github.com/sickn33/agentic-awesome-skills
**Description:** A local, agent-first control plane over 2,005+ agentic skills - catalogue discovery, agent-owned selection, stack validation and planning, with a CLI, local MCP server, plugins and a workbench.
**Signals:** 45.4k stars / 6.6k forks / MIT / last push 2026-08-24

**Analysis.** The most technically ambitious take on discovery here: instead of a human browsing a list, the agent queries a local catalogue and selects its own skills, with stack validation to catch mismatches. That is the direction this ecosystem is heading, and it is genuinely useful once your skill count is large. Local-first and MIT.

The obvious tension is that agent-owned selection removes the human review step exactly where supply-chain risk lives. Understand the trust boundaries before you let it self-serve from a 2,005-entry catalogue. It is also a control plane, not a list - more setup than a README.

**Use it if:** you have outgrown manual skill selection.

---

### alirezarezvani/claude-skills
**Link:** https://github.com/alirezarezvani/claude-skills
**Description:** 380+ skills, 30+ agents and 70+ custom commands spanning engineering, marketing, product, compliance, C-level advisory, research, business operations, finance and personal productivity - across Claude Code, Codex, Gemini CLI, Cursor and more.
**Signals:** 24.9k stars / 3.5k forks / MIT / last push 2026-08-25

**Analysis.** The broadest single-repo collection here, and the business-function coverage (compliance, C-level advisory, finance) is the part nothing else on this list touches. If your work is not engineering, this is one of the few places to look. MIT, one of the older projects (created 2025-10-19), pushed the day of this snapshot.

Breadth at this scale means uneven depth by definition - 380 skills from one maintainer cannot all be deeply validated. Sample the ones in your domain rather than judging by the headline count.

**Use it if:** you need agent skills for business functions outside engineering.

---

### travisvn/awesome-claude-skills
**Link:** https://github.com/travisvn/awesome-claude-skills
**Description:** A curated list of Claude Skills, resources and tools for customising Claude workflows, particularly Claude Code.
**Signals:** 14.8k stars / 1.9k forks / licence `none` / last push 2026-04-28

**Analysis.** An early and well-regarded list - created 2025-10-16, days after skills launched - and still a clean, readable index. Included here mainly for completeness.

It is the least recently updated entry in this entire README (last push 2026-04-28, about four months before this snapshot). In an ecosystem this fast that is a real staleness risk: expect dead links and missing recent projects. Prefer VoltAgent's or Composio's list as your primary. No detected licence.

**Use it if:** you want a second opinion. Do not use it as your only source.

---

## Anthropic's 19 official skills

Direct links into [anthropics/skills](https://github.com/anthropics/skills). Descriptions are the `description` field from each `SKILL.md`, condensed - these are the exact strings the agent uses to decide when to load a skill, which makes them worth reading as examples of how to write a trigger.

| Skill | What it does | Why it matters |
|-------|--------------|----------------|
| [skill-creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator) | Create, edit and optimise skills; run evals, benchmark performance with variance analysis, and tune descriptions for triggering accuracy. | **Start here if you write skills.** The eval and description-tuning tooling is the part nobody else provides. |
| [mcp-builder](https://github.com/anthropics/skills/tree/main/skills/mcp-builder) | Build high-quality MCP servers in Python (FastMCP) or Node/TypeScript (MCP SDK). | First-party guidance on tool design, which is where most MCP servers go wrong. |
| [claude-api](https://github.com/anthropics/skills/tree/main/skills/claude-api) | Reference for the Claude API and Anthropic SDKs: model ids, pricing, params, streaming, tool use, MCP, agents, caching, token counting, migration. | Stops the agent answering model/pricing questions from stale memory. Its explicit SKIP rules for other providers are a masterclass in trigger writing. |
| [webapp-testing](https://github.com/anthropics/skills/tree/main/skills/webapp-testing) | Drive and test local web apps with Playwright - verify frontend behaviour, capture screenshots, read browser logs. | Closes the loop from "code written" to "verified in a browser". |
| [docx](https://github.com/anthropics/skills/tree/main/skills/docx) | Create, read and edit Word documents and templates: TOCs, headings, page numbers, letterheads, tracked changes, comments, find-and-replace. | Production skill. Read it as a worked example of a large script-backed skill. |
| [pdf](https://github.com/anthropics/skills/tree/main/skills/pdf) | Everything PDF: extract text and tables, merge, split, rotate, watermark, fill forms, encrypt, extract images, OCR scans. | Production skill. The broadest tool surface of the four document skills. |
| [pptx](https://github.com/anthropics/skills/tree/main/skills/pptx) | Create, read and edit presentations and templates: decks, layouts, speaker notes, comments, combine and split. | Production skill. The reliable route to real `.pptx` output. |
| [xlsx](https://github.com/anthropics/skills/tree/main/skills/xlsx) | Create, read, edit and repair spreadsheets and CSV/TSV: formulas, formatting, charts, cleaning messy tabular data. | Production skill. Its description is the clearest example of scoping a skill with explicit do-NOT-trigger rules. |
| [frontend-design](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | Aesthetic direction, typography and layout choices that do not read as templated defaults. | Anthropic's own answer to AI-generated-looking UI. Compare against `hallmark`. |
| [canvas-design](https://github.com/anthropics/skills/tree/main/skills/canvas-design) | Visual art as `.png` and `.pdf` - posters, designs, static pieces - using an explicit design philosophy. | Note its built-in instruction to create original work rather than imitate named artists. |
| [algorithmic-art](https://github.com/anthropics/skills/tree/main/skills/algorithmic-art) | Generative art with p5.js: seeded randomness, flow fields, particle systems, interactive parameter exploration. | Seeded randomness means reproducible output - the right design for generative work. |
| [theme-factory](https://github.com/anthropics/skills/tree/main/skills/theme-factory) | Apply a theme (colours and fonts) to slides, docs, reports or HTML - 10 presets, or generate one on the fly. | Consistency across artefacts with almost no effort. |
| [web-artifacts-builder](https://github.com/anthropics/skills/tree/main/skills/web-artifacts-builder) | Build elaborate multi-component claude.ai HTML artifacts with React, Tailwind and shadcn/ui. | For artifacts needing state or routing - explicitly not for simple single-file ones. |
| [doc-coauthoring](https://github.com/anthropics/skills/tree/main/skills/doc-coauthoring) | A structured workflow for co-authoring docs, proposals, specs and decision documents - transfer context, iterate, verify it works for readers. | The "verify it works for readers" step is the one most doc workflows skip. |
| [brand-guidelines](https://github.com/anthropics/skills/tree/main/skills/brand-guidelines) | Apply Anthropic's official brand colours and typography to any artifact. | Useful as a *pattern* for encoding your own brand. The content is Anthropic's - swap it. |
| [internal-comms](https://github.com/anthropics/skills/tree/main/skills/internal-comms) | Write internal communications: status reports, leadership updates, newsletters, FAQs, incident reports, project updates. | Same pattern: strong structure, house-specific content. Fork and replace the formats with yours. |
| [slack-gif-creator](https://github.com/anthropics/skills/tree/main/skills/slack-gif-creator) | Animated GIFs optimised for Slack, with constraints, validation tools and animation concepts. | The lightest skill here, and a good small example of bundling validation with generation. |
| [discernment-nudge](https://github.com/anthropics/skills/tree/main/skills/discernment-nudge) | After a substantive answer or draft, append 2-3 targeted follow-up questions that help the user check facts, probe assumptions and spot missing context. Once per conversation. | The most unusual skill Anthropic ships: it makes the agent help you *distrust* it. Worth reading whatever you build. |
| [academy-guide](https://github.com/anthropics/skills/tree/main/skills/academy-guide) | Recommends matching courses and tutorials from Claude Academy when someone is learning a Claude feature. | Narrow, and explicitly instructed never to invent Academy content - a good example of anti-hallucination guardrails in a trigger. |

---

## Selection criteria

An entry has to clear all four:

1. **Verifiable.** The repo exists and its metadata was pulled from the GitHub API, not from memory or a blog post.
2. **Adopted.** Meaningful star and fork counts, or first-party publication by a vendor whose product the skill covers.
3. **Maintained.** Pushed recently enough to still be plausible. Where it is not, the entry says so.
4. **Distinct.** It does something the entries around it do not. Near-duplicates were cut.

**What is deliberately excluded:** skills whose primary purpose is evading detection or disclosure; offensive-security tooling without a clear authorised-use framing; and repos whose star counts look inconsistent with their engagement.

**Known bias:** star counts favour projects that went viral, which is not the same as projects that are good. Every entry's *Analysis* states a real limitation, and where a lower-starred project is better for a job than a higher-starred one, the list says so - `SkillSpector` at 14.9k stars is more important than most of the 100k+ entries here.

---

## Verify it yourself

```bash
git clone https://github.com/chethanbhatbs/best-claude-skills
cd best-claude-skills
./scripts/refresh-stats.sh          # re-pulls every stat from the GitHub API
```

Requires the [GitHub CLI](https://cli.github.com/) (`gh auth login`). The script writes `data/stats.tsv` and prints anything that has drifted from the README.

---

## Before you install anything

1. **Scan it.** [SkillSpector](https://github.com/NVIDIA/SkillSpector) first, every time.
2. **Read the `SKILL.md`.** It is instructions injected into your agent's context. Read them the way you would read a shell script before running it.
3. **Check for scripts.** Skills can bundle executables. Look at what they do and what they reach for - network, credentials, your filesystem.
4. **Check the licence.** `none` means all rights reserved by default. AGPL means obligations if you ship a service.
5. **Install a few at a time.** Overlapping trigger descriptions cause silent misfires that are hard to trace back.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Short version: one skill per PR, include the API-verified stats, and write an analysis that names a real limitation. Entries that read like marketing get closed.

## Licence

[CC0 1.0](LICENSE) - public domain. The listed projects carry their own licences; check each before use.
