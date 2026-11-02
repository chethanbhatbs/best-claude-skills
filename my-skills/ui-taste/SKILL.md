---
name: ui-taste
description: How the user wants interfaces to look and behave. Accumulated UI/UX rules, gathered project by project, plus approved external design skills. Load before writing or changing ANY user-facing UI - a page, a component, a stylesheet, a dashboard, a report. Also invoke as /ui-taste when the user says "improve the UI", "the design is bad", "this looks AI-generated", or points at a design reference.
---

# UI taste - standing rules for interfaces

This file grows: every time the user reacts to a
design, the reaction becomes a rule here in the same turn.

## How to use this


1. **Read this whole file before touching UI.** Not after.
2. Check the project for `.interface-design/system.md`. If it exists, it wins
   on specifics; this file supplies the taste behind it. **If it does not exist,
   create it before the first screen** — its absence is the root cause of every
   uniformity complaint listed here.
3. If a rule below is missing for the decision in front of you, decide, then
   **write the decision down** in the project's system file.
4. When the user reacts to something you built, add the reaction here **in the same
   turn**, before moving on.

---

## THE GATE — run this before saying any screen is done

Read this first. On 2026-08-27 the user sent seven screenshots and said *"no
uniformity ... I am repeating"*, and when I finally measured, **every fault was
already covered by a rule in this file**. The rules were not missing. They were
not run. So the fix is not more prose below; it is these three commands, every
time, on **five sibling screens** and not only the one the user pointed at.

**1. The type scale.** Seven values or fewer, whole pixels, no halves.
```bash
grep -ohE "font-size: *[0-9.]+(px|rem)" <stylesheet> | sort -u -t' ' -k2 -n
```

**2. Every control, on each screen.** One height. Two radii. Sizes from the list.
```js
[...document.querySelectorAll("button, input:not([type=checkbox]), select")]
  .filter(e => e.getBoundingClientRect().height > 0)
  .map(e => [Math.round(e.getBoundingClientRect().height),
             getComputedStyle(e).borderRadius, getComputedStyle(e).fontSize])
```

**3. Any class you just wrote.** Zero means the element is unstyled and
inheriting from the surrounding app, not that it is tidy.
```bash
grep -c "the-class-you-just-invented" <stylesheet>
```

**4. Every class in the markup, against the stylesheet.** Rule 3 by hand catches
the class you remember writing. This catches the ones you don't — including the
case where the markup shipped and the stylesheet did not.
```bash
# every literal class token in the markup that no stylesheet defines
comm -23 \
  <(grep -rhoE 'className="[^"]*"' <src> | grep -oE '\b<prefix>-[a-z0-9-]+' | sort -u) \
  <(grep -rhoE '\.<prefix>-[a-z0-9-]+' <stylesheets> | cut -c2- | sort -u)
```

**5. One word, one treatment — across screens, not within one.** Pick the state
words the product actually says (`off`, `paused`, `failed`, `published`) and grep
every place each one is rendered. If one word has two classes, that is the
"no uniformity" complaint, in a form you can fix.
```bash
grep -rn '>off<\|>Off<\|"off"' <src> | grep -oE 'className=[^>]*' | sort -u
```

If 1 returns eleven values, or 2 returns nine heights, that IS the answer to
"the design looks inconsistent", and no per-screen tweak will fix it. Stop and
normalise. Measured once: 164 half-pixel font sizes and nine button heights in
one panel, found only after the user complained. Measured again the next day: the word
**"off" rendered four different ways on four screens** of the same panel.

**And the gate belongs in CI, not in this file.** Checks 1, 3, 4 and 5 are all
static — they are a script, and a script is the only version of a rule that
cannot be skipped by a session in a hurry. Every one of these was written down
here *before* the day it was violated.

---

## Hard rules (learned the hard way, do not relearn)

### Behaviour has its own file now, researched from primary sources
Keep a `docs/FRONTEND-BEHAVIOUR.md` in the project, researched from primary sources. Every rule in it carries the URL it came from
(NN/g, W3C WAI APG, MDN, GOV.UK Design System). This file is taste; that one is conduct; a project's
`.interface-design/system.md` is values. Copy it into any new project.

### Give an input its type. An untyped input is a guess.
A field whose KIND the data model knows must hand that kind to the control. Measured in one panel:
**87 of 145 `<input>` elements had no `type` attribute at all** -- so a date field was a text field
and accepted `2005-03-12asdfsdaf`. `type="date"` normalises to `YYYY-MM-DD` and the browser refuses
anything else before it is typed. Verify it: `grep -rn '<input' src/ | grep -v 'type='`.

### Prevent, then report. An error message is the second-best answer.
The panel above was already running the right validator -- on the Save click. So it accepted the
rubbish and argued afterwards. Reach for the control that cannot express the wrong value before
reaching for the message that explains it. And validate on **blur**, never per keystroke: NN/g calls
mid-typing errors "an unwarranted scolding" and a hostile pattern, like grading a test before it is
answered.

### The format goes in a hint, not the placeholder
A placeholder vanishes the moment somebody types, which is exactly when the format is needed. NN/g:
placeholders make it "difficult for people to remember what information belongs in a field, and to
check for and fix errors". A placeholder may hold an EXAMPLE (`2026-03-15`); never the field's name,
never its state. `Not recorded` in a placeholder is a state word wearing a label's clothes.

### Removing a font-weight can make text HEAVIER
On a `<strong>`, `<b>`, `<th>` or `<h*>`, the declaration you delete was the only thing holding the
browser's own `bolder` back. Measured: deleting `font-weight: 600` took a warning to **700**. Set the
value you want; never infer a computed style from a diff.

### A component override of a global element rule usually loses
`.wa-fields-row select` and `.wa-shell select` are both specificity (0,1,1). Ties break on source
order, and the global rule is usually later. Measured: **28 card-level `select` rules preceded the
global one and 24 set a property it also set** -- all silently dead. A declaration that loses is worse
than one that is missing, because it documents an intent the screen does not have. Raise specificity
deliberately (`.wa-fields-row > select`) or delete it.

### Announce what changes. A silent confirmation is no confirmation.
Measured in one panel: **zero `aria-live` regions and one `role="status"`** across every screen, so
every "Saved." and every validation error reached nobody using a screen reader. A confirmation is
`role="status"` (polite); something that has just blocked the user is `role="alert"` (assertive, used
sparingly).


### Do not ship AI-native design
The tell is a page of rounded cards with filled pills, an icon chip in a
rounded square, a gradient somewhere, purple, and 14px+ radii. The user will call
this out immediately. Standard professional applications from before this
era had no extra elements, no fluff, and were clean and to the point. Aim
there.

**The bar:** if another AI given a similar prompt would produce substantially
the same screen, it has failed.

### A re-skin is not a redesign
Swapping colour tokens while keeping the same structure is a re-skin. Say
"re-skin" when that is what it is. "Redesign" means the structure changes.

### Never over-correct
Told a design is bad, do **not** strip everything. Change one variable —
palette, or structure, or density — show it, and let the user react. The user liked the
cards; the decoration on them was the problem. Removing both is a second
wrong answer.

### Cards are fine. Decoration is not.
Keep: surfaces, hairline borders, modest radius, grouping.
Drop: filled pills and badges, icon chips, gradients, coloured edge bars,
drop shadows on flat content, multiple accents.

### A KPI card is a label, a value and one short line
Not a settings summary. pingcrow shipped "1289 ms · every 5 min · down after 2 fails in a row · timeout
10 s" under "Last check" and "Downtime budget, 99.9% over 30 days / 43 m left" with a meter and a second
line. The user's words: **"why these many text ... what is this ... keep the kpi look clean."** Config belongs in
the edit form. Name the number in the owner's words ("Downtime allowed"), never the SRE term ("budget").

### No explanatory prose in the UI. Put it behind a help mark.
A sentence on screen telling the reader how a control behaves is read once and
then sits there forever. The user's rule, verbatim: **"don't add extra text, if you
want to then add a help section — should be a universal rule, i want ui look
clean."** Applies to instruction lines under a toolbar, notes floating below a
board, and paragraphs explaining a form. If it must exist, it goes behind an
info affordance the reader chooses to open.

### One help mark, not two
Two identical ⓘ next to each other say nothing about which is which, so the
reader opens both. Merge them: one mark per surface, holding everything worth
knowing about it. **"why two icons? what is wrong with you."**

### A filled button must never pale on hover
A shared "quiet button" hover that sets a light tint will repaint a filled
button and keep its white label — the label disappears at the exact moment
somebody points at it. **"on hover why does it becomes light green."**
Filled hovers go DARKER. And every shared quiet-button rule with a
`:not(.primary)` escape hatch needs each new filled variant added to that
exclusion by hand; miss it and the destructive button renders identical to
Cancel.

### A destructive action needs its own filled style
Not the primary class plus a modifier that has no rule behind it. Delete looked
exactly like Save. One destructive class per project, same shape as the primary
so a confirm dialog reads as two related controls.

### Confirm anything irreversible, in the app's own dialog
Never `window.confirm()` — it is a different dialog from every other one in the
product and cannot name what goes with the thing. Name the item and say what is
lost. This applies to discarding typed work as well as deleting.

### Never nest a control inside a drag handle
`setPointerCapture` on the handle retargets the click to the handle, so a button
inside it **never fires**. Guard the handle: `if (e.target.closest("button"))
return;` before starting a drag. See the testing rule below, because this one
cannot be caught the way I was catching things.

### Synthetic pointer events cannot prove a drag works
A synthetic `pointerId` is not an active pointer, so `setPointerCapture` throws,
capture never happens, and a click that a real mouse would lose reaches the
button. Three broken controls passed every test I drove. Anything behind pointer
capture must be pressed with a real mouse — in Playwright terms `page.click`,
not a dispatched `PointerEvent`.

### After creating something off-screen, scroll to it and mark it
A new card that lands past the end of a wide board looks like a button that did
nothing. `scrollIntoView({block:"nearest"})` and a temporary fill, cleared on a
timer.

### One state per fact on an element
A card that is unreachable was getting a warning fill, a dashed border and two
sentences — three marks for one fact. Pick the narrowest true state and show
only that.

### No coloured edge accents
No left/top colour bars to mark state. Active state is a **filled
background**. (Long-standing rule, predates this file.)

### Uniformity is the rule the user repeats most. Enumerate, then obey.
The user has now said it three times, the last one as "no uniformity ... I am
repeating, I want uniformity in ui". It keeps happening because each screen gets
built on its own and nobody writes the shared numbers down.

**Before the first line of UI in a project**, create
`.interface-design/system.md` and enumerate, as closed lists:

- **button heights** — one for normal, one for small. Not three, not eight.
- **border radii** — one for controls, one for surfaces.
- **type steps** — whole px only, and every value on the list.
- **one row-action pattern** for the whole product.
- **one treatment per meaning** — a status, a count and a filter are three
  different things and may not share a shape.

Then read that file instead of deciding again. Measured on one admin
panel after the user complained: **8 distinct button heights** across seven
screens (18/19/21/27/28/31/32/39/41px), **5 radii on one screen**
(0/5/6/8/999px), one screen carrying **both** row-action patterns at once (22
icon-only buttons and 8 kebab menus), and an `<h1>` in Playfair Display on a
screen whose siblings are all Roboto.

**A screen that adds a ninth button height is a defect even if it looks fine on
its own.** Check a new screen by measuring computed values across its siblings,
never by eye. `getComputedStyle` over every button on five screens takes one
command and is the only way this claim can be made.

### One class, one meaning. Never state and category on the same class.
`tone("approved")` returned `" on"` -- the same class the filter row used for
"this one is selected" -- so the Approved chip looked permanently selected and the user
asked "why approved is highlighted when all is clicked". A class that encodes
interaction state (`.on`, `.active`, `.selected`) may never also encode a
status, a category or a tone.

### The tone list is closed, and two tones that look alike are one tone
Three tones is enough anywhere: **good**, **warn**, and nothing. Write them down,
put them in a script, and delete every synonym. Measured in one panel: `on`
(green fill), `open` (green outline), `good` (green fill), `bad` (red + 12% wash),
`warn` (red), `off` (muted + fill) -- six names for three facts, so the same
state looked different depending on which screen you were on.

- **A tone that renders like another tone is the same fault as one that does not
  exist.** `.wa-chip.bad` and `.wa-chip.warn` were both `var(--wa-warn)`; the
  tally's `.bad strong` and `.warn strong` were the identical declaration written
  twice. A distinction the code made carefully never once reached the screen.
- Check it by reading the *colour*, not the class name. Two tones resolving to one
  value is a failure, and a script can assert it.

### Off is a fact. Red is for something to go and fix.
The user was shown the user's own working hours in red at nine in the evening, because
"Closed now" carried the warning tone. Nothing was wrong: the shop was shut. Red
means *act on this*; a state that is simply not-on is a plain chip. The one thing
that earns red is a state the reader cannot otherwise see -- "this is switched on
and silent anyway, because a master switch above it is off".

### A checkbox label is a field label, not a heading
Give the shared checkbox class an explicit `font-size`. With none, it inherits:
measured at 16px (the prose size) on one screen and 13px on another, because two
screens had already patched it locally at 12px/500 and 13px/500. One control,
three answers, and on the settings screen the checkbox label rendered LARGER and
blacker than the panel title above it.

`align-items: start` with the box nudged onto the first line -- not `center`
(which centres a box against a two-line label, so it lands beside the gap) and
not `baseline` (measured 2px high, which is the "why is text not in center"
complaint).

### One way to switch a setting on, per product
Not a checkbox on two cards and a `Switch on` button on a third, which is what one
settings screen shipped. Pick the button if your row menus already say "Switch
on/off" -- then the word matches everywhere. A checkbox on a settings card also
has nothing to label itself with except the card's own name, so the card ends up
saying its own name twice, the second time louder.

### Edit opens a dialog. Every section, no exceptions you did not argue for.
The user's words: *"no matter whichever section it is, edit MUST open a modal."* An
inline form that unfolds where the row was is the failure: the thing being edited
vanishes from the list, the page grows, and on a long list the form opens below
the fold with nothing to say it did.

Count them by **driving every Edit control**, not by reading imports. In one
panel: three sections opened a dialog and **eleven rendered in place**, and a
grep for the editor's CSS class found six I had not thought to check.

- **Use the shared dialog component, never a div wearing its classes.** One
  hand-rolled dialog looked identical and behaved like nothing: measured,
  `document.activeElement` stayed on `body` and Escape did nothing. Classes give
  you the look; the component gives you Escape, Cmd+Enter, focus into the first
  field, the focus trap and the scroll lock.
- **Hoist the save out of the JSX** so Cmd+Enter and the submit button are one
  function. Two copies of "what saving means" is two things to keep in step.
- **A form already inside a dialog does not get its own.** Converting one
  produced *two dialogs from one press*. Found by driving it, not by reading it.
- **The opener stops hiding itself.** A dialog covers the screen, so the button
  behind it can stay where it is.
- Check the focus lands in a **field**. `querySelector` with a comma list answers
  the first match in *document order*, not by selector priority — put `button` in
  that list and the head's Close button wins every time.

### "Cancel" or "Discard changes" follows whether something existed
One word per act, and a component that both creates and edits needs a conditional
label -- one fixed word is wrong half the time.

- editing something that already exists → **Discard changes**
- abandoning something new, or closing a dialog that changed nothing → **Cancel**
- an input that opens EMPTY is not an edit. A write-only secret field with a
  "Paste the value" placeholder has no baseline to discard, so Cancel is right.
- an icon button that shuts a panel says **Close**. "Cancel" promises something
  is being undone.

Count them before deciding: one panel had **14** buttons saying Cancel, and only
four of them were on an edit-existing flow. Go case by case; a blanket rename is
as wrong as leaving it.

### An empty state whose control is gated away must say why
Worse than an empty list is an empty list with no button and no explanation. One
screen read "No date rule yet" and rendered no control at all, because the editor
was gated on a date field existing three blocks below. A missing button with no
reason reads as a broken screen. Say the real cause and link to where it is
fixed: "a rule fires on a date held against a contact, and this shop has no date
field yet. Add one on Contacts."

Found by trying to drive my own change and discovering there was nothing to
drive. **If you cannot reach a control to verify it, that is itself a finding** --
not a reason to mark the work done on source alone.

### Ratchet a vocabulary you cannot safely rewrite
Some debt is too broad to fix in one pass. One panel had **498 `gap`
declarations across 17 lengths**, 295 off its own 4px grid. Rewriting them would
be 295 layout changes across every screen with **no test asserting a single
gap** -- unverifiable, so not a fix.

Instead close the list at what is in use and check it **both ways**: nothing new
may be invented, and a value nobody uses any more must come off the list. The
debt can then only shrink. Say plainly that you did the ratchet and not the
rewrite; do not let a ratchet read as a fix.

**And beware the detector that over-reports.** Grouping those gaps by component
found 45 families using more than one small gap -- but a component legitimately
has a tight gap between an icon and its label and a looser one between controls.
Counting is not judging. Never hand over a count as a work list.

### Every disabled control names its reason, next to itself
Not in a loose line above the row, and never only in a `title`. Tie it with
`aria-describedby`, and derive the disabled state FROM the reason
(`disabled={why !== null}`) so the button and its explanation cannot disagree.
Measured on one screen: three disabled buttons, one reason between them, and
`aria-describedby` null on all three. "Save is grey because you have not changed
the number" is correct behaviour and invisible, which reads as broken.

### A row's actions are one pattern, product-wide
Pick the kebab or pick inline icons, once, and never both. Both on one screen is
what the user screenshotted with "switch button in table" against "here it is inside".
The kebab wins when any row has more than two actions, because three icon-only
buttons per row is 39 unlabelled controls on a twelve-row screen -- counted, on
the user's Automations screen.

### An empty feature must say it is empty, where the user is looking
A `/` menu that shows nothing when nothing is saved is indistinguishable from a
broken one. Seed a starter set, or say "nothing saved yet" with the link that
fixes it, in the place they are looking. Never put the explanation in a `title`
on a disabled control -- that is the one place nobody looks.

### Type and spacing must be on a system
Off-grid values are the clearest sign of no system. The user notices.
- Type: pick a base and a ratio, round to whole px. `11 · 12 · 14 · 16 · 18 · 22 · 28` works.
- Space: 4px base, multiples only: `4 · 8 · 12 · 16 · 24 · 32`.
- Weights: three at most. 400 / 500 / 600.
- Prose and chrome are different jobs: read at 16, scan at 14, label at 11.

### No explanatory prose on a screen people are trying to get past
"Why too many text, none of the professional websites has this" - said at a sign-in
carrying a paragraph about who may sign in and a footnote about what the panel is for.
**A door does not need a notice on it.** Sign-in, empty states, confirmation screens and
toolbars get a heading and at most ONE short line. Everything else is either enforced by
the server and stated in the error when it bites, or belongs in the later step where it
is an instruction rather than a warning.

The test: would this sentence still be there if a designer had to justify it out loud?
Rules stated in advance are read by nobody and are wrong the moment the rule changes.
Instructions at the moment of use ("write these down now", on the screen showing the
codes) are the exception and stay.

### One focal point per screen
Name the one thing the user came for, then make it win on size, weight and
colour together. A metric reads figure-first: the number large and tabular,
the unit demoted to 11px uppercase beneath it. Everything else steps down.

### Tabular numerals on anything that changes
Timings, counts, ids, prices, progress. Stops layout shifting.

### A named location is the requirement
When the user says where something goes -- "inside the dropdown", "in the head bar", "on the card" -- that
is the spec, not a hint. Putting it *beside* the named place is the wrong answer however tidy it
looks. Build it there, or say why it cannot be, before shipping.

### An action that sets a state belongs in the control that shows it
"Assign to me" is not a link next to the assignee select, it is an option in it. A second control for
one field means two things to keep in step and two places to look. If the select can express it, the
select expresses it -- and label it so it reads correctly *after* it is chosen: an option saying
"assign to me" becomes the sentence describing who has the thing.

### If you make a screen reachable, open it
Adding a nav entry, a link or a route to a screen means you now own how that
screen looks. The user found a wall of prose, a stray icon and a flush button on a
page I had made reachable and never loaded. Reachability is a UI change.

### One convention per fact, across the whole screen
Two tables on one screen must show the same fact the same way. One had a
`Status` column of "Enabled Enabled Enabled" plus a power button; the one below
it dimmed the row and showed a chip only when off. The user's words: "only this has
status none other table has, I want uniformity." Pick the quieter
convention and apply it to both. A chip that repeats what a control already
shows is noise; a chip earns its place only when the answer is not the plain
expected one.

### Two controls for one job is one too many
A section-wide search box and a per-table search box on the same screen is a
duplicate, not two levels of detail. Keep the more capable one and delete the
other, including its state.

### Fix the class, not the screenshot
When the user points at one instance, sweep every instance before replying. Answering
one screenshot at a time and shipping is what makes the user repeat themselves, and the
repetition is the complaint.

### Read the computed style, not the property you assumed
`outline: none` did nothing for a double border, because the ring was an inset
`box-shadow` from a global input rule. Read the focused element's computed
style before writing the fix.

### Flex wraps on content size, before it shrinks
`flex: 1 1 auto` on a long text block pushes its sibling to the next line, and
`max-width` does not save it: wrapping is decided on the flex BASE size, and
shrinking only applies within a line already chosen. Give the text a small
basis (`flex: 1 1 320px`) if something must sit beside it.

### A bare action row above a panel needs a gap
Measured: a "Write a sequence" button's bottom and the next panel's top were
both at 606px. Same complaint as "the buttons attached to border".

### Two names for one thing means neither is the name
The nav said Series, the page said Sequences, the search said Series. Pick the
word once and use it in the heading, the nav, the buttons and the empty state.

### A fix on a branch the dev server is not running is not a fix
Stacked branches mean the running app shows one branch's work, not the sum. The user reported
the same chart-tooltip shadow twice because the fix was committed to a sibling branch
while the user's dev server ran another. **Before saying anything is fixed, check
`git branch --show-current` against the branch the dev server serves, and verify in that
runtime.** If the fix is on a different branch, say so and say the running app does not
have it. The same applies to reporting a measurement: a value measured on branch A is
not a claim about branch B.

### Measure, never eyeball
Before claiming a spacing or size problem is fixed, read the computed value
out of the browser. The user has caught eyeballed answers.

### Verify in the user's browser, not yours
Hard-reload, and remember `localStorage` from your own testing can make a
page look broken for the user and fine for you. Test with every combination of
stored state before saying it is done.

---

## Portable rules: run these in ANY project

The user asked for this explicitly: *"whatever you are learning just add it in the skill. I
want you to make these all as a rule where i can implement this in other project."*
Nothing below is specific to one codebase. Each rule comes with the command that proves
it, because every one of these was found by measuring after the user complained, which is the
wrong order.

### 1. Write the system file first. It is the root cause of every uniformity complaint.
`.interface-design/system.md`, before the first screen, with **closed lists**: two
control heights, two radii, one type scale, one row-action pattern, one treatment per
meaning. A project without this file has every screen re-deciding, and the drift is not
visible from inside any single screen.

### 2 and 3. The audits
Both commands are THE GATE at the top of this file. Run them there, not from here.
**Half pixels are the tell**: collapse them downward onto whole px, which can only make
text smaller, so nothing overflows.

### 4. `min-height` plus padding is how one class becomes many heights
A rule with `min-height: 32px; padding: 6px 11px` measures 32px in a row and 41px in a
toolbar, depending on its contents. **Set `height`, not `min-height`, on anything that
must match the control beside it.** Three heights in one row is what a user reports as
"the boxes are overlapping" — usually nothing overlaps, they are just three sizes.

### 5. A fixed height needs `align-items: center`
The moment you add `height` to a flex control, `align-items: baseline` puts the text
high in the box. Grep the rule you just changed for `baseline` before moving on. The user
spotted this within a minute: "why text is not in center?"

### 6. When you pin a global height, find everything that WRAPS that element
`input { height: 32px }` is right for a bare field and breaks every search box built as
`<span class=wrap><svg><input></span>`, because the wrapper adds its own padding on top:
32 + 14 + 2 = 48px. **The wrapper takes the height; the field inside gets
`height: 100%`.** Grep for `input { border: 0` or `appearance: none` to find them all.

### 7. A global change is not finished until it is swept
See **Fix the class, not the screenshot** above; this is that rule with a command.
After any CSS change, grep the stylesheet for the same pattern and fix every instance in
the same commit. The user's words: *"your main problem is you only fix the issues where I
highlight, you never check if the issue is present elsewhere."*

### 8. Never invent a class name
A class with **zero** rules in the stylesheet is not neutral: the element falls back to
whatever the surrounding app sets. One panel screen used three invented class names and
its bare `<h1>` inherited the marketing site's serif display face while every sibling
screen was sans. Check:
```bash
grep -c "your-new-class" <stylesheet>   # 0 means the element is unstyled, not tidy
```
Reuse the existing head/section/panel class instead of naming a new one.

### 9. One class, one meaning
`.on`, `.active`, `.selected` encode **interaction state and nothing else**. The moment
a helper returns `" on"` for a category ("approved"), the screen draws two different
facts identically and the user cannot tell which. Status rides on its own
`.good`/`.bad`/`.warn`, which tint text and leave the frame alone.

### 10. Red means something is wrong, not "not right now"
A shop being closed at 19:00 is not an error. A permanent red band or pill for a
standing state trains people to stop reading red. State it as a line, glyph coloured,
no fill, no border.

### 11. A search box whose state is the URL must ignore its own echo
The classic vanishing-text bug, and it is framework-agnostic. Debounced navigation
writes `?q=Shru` while the user is still typing; the effect that syncs the box from the
URL then overwrites `Shruthi` back to `Shru`. **Keep a ref of the last value this box
sent and skip the sync when the incoming value equals it** — only a value it did not
send (Back, Clear, a bookmark) is worth adopting.
```js
const sent = useRef(q);
useEffect(() => { if (q === sent.current) return; /* adopt */ }, [q]);
// and at the moment of navigating: sent.current = typed
```

### 12. A row's actions: one pattern, and the kebab wins past two
Three icon-only buttons per row is 39 unlabelled controls on a twelve-row table. If any
row has more than two actions, every row gets one kebab, ordered
`Edit → toggle → verb → Delete`, with Delete last and the only red item.

### 13. Rows are one line. A cell with three values lists them inline
Stacking `email / whatsapp / sms` inside a cell turned a table row into 119px. Join with
`·` and let the row breathe at one line.

### 14. Edit, save, discard, submit: one arrangement product-wide
`[ Save ]  Discard changes` bottom-left, in that order. Save filled, Discard quiet text.
Call it **Discard changes**, never *Cancel* — cancel is ambiguous about whether the edit
survives. Save disabled while nothing has changed, and visibly so without a tooltip.
Anything that hands work to an external service (approval, publishing) is a **separate
act on the saved row**, never a button inside the edit form, and when it cannot run it
says why on the row in one line.

### 15. An explanation in a `title` on a disabled control is invisible
It is the one place nobody looks. Put it on the surface, next to the thing it explains.

### 16. Never claim a UI fact you did not measure this turn
See **Read the computed style, not the property you assumed** above. One addition: a
screenshot is not a measurement either. A font that looks different in two crops is
usually the same font at two device pixel ratios, so check `fontFamily` before agreeing
that the font changed.

---

## Hands-on and teaching UI

If the product teaches something, these are not optional.

- **The learner must produce, not recognise.** A Run button and a checkbox
  are both passive. Make them compose the thing, or commit to an answer
  before it is revealed. Retrieval practice and the generation effect are the
  evidence; recognition does not teach.
- **Show the mechanism, not only the result.** If someone can act and get an
  answer without seeing what happened in between, the tool has taught nothing.
- **Reference material goes in the navigation,** never inside a tool panel.
  If you have to explain where a feature is, it is in the wrong place.
- **Every factual claim in teaching material is a test case.** Execute it
  against the thing that demonstrates it. Do not write it and hope.

---

## Approved external skills

Principles pulled in with the user's explicit approval. Cite the source when applying.

### material-3 — hamen/material-3-skill  (installed)
`~/.claude/skills/material-3` · MIT · installed 2026-08-25

The user likes how Google designs apps: the simplicity, the self-explanatory
options, the themes. The four mechanisms behind that, and they are
mechanisms rather than a look:

- **Colour is roles, never values.** Every fill ships with an `on-` partner
  and you never pair outside it. Contrast is guaranteed by construction,
  which is why Google themes hold up in light and dark with no tuning.
- **Depth is tonal.** Five surface-container levels, higher = lighter tone.
  Not shadows, not borders. Do not mix in the other two.
- **Type roles are named by purpose.** Display / Headline / Title / Body /
  Label at L/M/S. `label-large` (14/20/500) is button text. You pick the
  role and the size follows.
- **Shape carries meaning.** Buttons `full`, cards 12, dialogs 28, inputs 4.

Tone in M3 is CIE L*, so palettes are computable: hold the seed hue, walk
lightness, clamp chroma to gamut. Do not hand-pick tonal steps.

Caveat: the skill targets Jetpack Compose and Flutter first; its web support
is "limited, maintenance mode". Its **token references are exact and worth
using**; its component code is not for a plain-CSS project.

### interface-design — Dammyjay93/interface-design
`https://github.com/Dammyjay93/interface-design` · MIT

Design engineering skill for Claude Code. Its **Precision & Density**
direction is the right default for tools and dashboards. The parts worth
holding on to:

- **Four checks before showing.** *Swap test:* swap your type and layout for
  the usual ones — would anything feel different? *Squint test:* blur your
  eyes; is hierarchy still readable and nothing harsh? *Signature test:*
  point at five specific elements carrying it. *Token test:* read the CSS
  variables aloud — do they belong to this product's world or any project?
- **Token names carry the world.** `--wire` and `--signal` evoke something;
  `--gray-700` and `--surface-2` evoke a template.
- **Intent first:** who the human is, the verb they need, and what it should
  feel like in words that mean something. "Clean and modern" means nothing.
- **Depth: choose one and commit.** Borders-only for dense technical tools.
  Do not mix strategies.
- **Borders as low-opacity rgba**, not solid hex, so they disappear until
  you look for them.
- **Surface elevation in small lightness steps**, one hue.
- **Motion:** ease-out only, `cubic-bezier(.23,1,.32,1)`, under 300ms,
  transform and opacity only, and none at all on actions repeated all day.
- **Concentric radius:** outer = inner + padding.

Install if you want the skill itself rather than these notes:
`npx skills add https://github.com/dammyjay93/interface-design --skill interface-design --agent claude-code -g`
