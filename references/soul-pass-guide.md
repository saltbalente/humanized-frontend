# Soul Pass Guide — the manual 30-60 minute ritual

> Phase 5 of the pipeline. NO AI for this. Just you, the file, and intention.
> This is what makes the difference between "humanized" and "actually human."

---

## When to do it
- After Phase 4 (code generation) — before Phase 6 (audit).
- Always at least 30 min. Ideally 60. Set a timer.
- Close ChatGPT/Claude/Cursor chat windows. Real ones only.

## The 8-step ritual

### Step 1 — Re-read out loud (5 min)
- Read every word on the page out loud.
- Mark every sentence that you wouldn't say to a friend at a bar.
- Don't fix yet. Just mark with `// FIX` comments.

### Step 2 — Add the DNA Signature Element (10 min) ⭐
This is the most important step. Your DNA gave you ONE signature element. It MUST appear.

#### How to choose where to place it
| Signature element | Best location |
|-------------------|---------------|
| `hand-drawn-arrow-pointing-at-CTA` | Hero, between subhead and CTA button |
| `founder-polaroid-photo-rotated` | About section or footer |
| `scribbled-circle-around-keyword` | Hero headline, around the most important word |
| `ascii-art-divider-between-sections` | Between every major section |
| `ticker-marquee-of-real-customer-quotes` | Below hero or above footer |
| `tiny-handwritten-margin-notes` | Right margin of long-form content (desktop only) |
| `running-system-clock-in-footer` | Footer left, mono font |
| `guestbook-or-now-page-section` | New `/now` route or footer link |
| `single-easter-egg-konami-code` | Anywhere — leave a console.log hint |
| `real-screenshot-of-handwritten-todo` | About or hero secondary image |
| `sketch-doodle-on-section-headers` | Inline SVG before each h2 |
| `collage-of-real-objects-photographed` | Hero background or about section |
| `blinking-cursor-after-headline` | Hero headline final character |
| `dot-matrix-printed-receipt-section` | Pricing or invoice section |
| `audio-clip-of-founder-explaining` | Hero, optional play button, muted by default |
| `live-edit-mode-cursor-on-text` | Headline — typewriter effect with `\|` cursor |

#### Implementation hints
- Hand-drawn SVG: draw on paper, scan, vectorize in Figma → inline SVG. ~2 min.
- Polaroid photo: real selfie + CSS `border-8 border-white shadow-brut rotate-[-2deg]`.
- ASCII divider: `<hr>` replaced with `<pre>········· · · ·········</pre>` mono.
- System clock: `setInterval` updating `<time>` every second in mono.

---

### Step 3 — The 10 Micro-Imperfections (15 min)
Pick at least **6** of these. Apply with intention, not randomness.

1. **Off-grid nudge.** Move 2-3 elements by `translate-x-[4px]` or `-translate-y-[6px]`. Random pixel offsets feel hand-placed.

2. **Rotation on cards.** `rotate-[-0.6deg]` on one card, `rotate-[0.4deg]` on another, `rotate-[-1.1deg]` on a third. Never the same angle twice.

3. **Variable line-height.** Don't use `leading-tight` everywhere. Try `leading-[1.05]` on hero, `leading-[1.7]` on body, `leading-[1.3]` on captions.

4. **Inconsistent border-radius.** Card 1: `rounded-none`. Card 2: `rounded-[2px]`. Card 3: `rounded-sm`. Looks hand-curated, not templated.

5. **Imperfect alignment.** Footer links: don't justify them perfectly — let them break naturally with mixed lengths.

6. **Asymmetric padding.** `pt-12 pb-8 pl-6 pr-10` instead of `p-8`. Looks composed, not generated.

7. **Hand-tweaked font sizes.** `text-[27px]` instead of `text-2xl` (24px) or `text-3xl` (30px). Specific sizes feel chosen.

8. **Mixed text-decoration.** Some links: `underline`. Some: `border-b-2`. Some: `decoration-wavy`. Visual rhythm.

9. **Unequal margins between sections.** `mt-24` then `mt-32` then `mt-20`. Don't reuse spacing tokens religiously.

10. **One element that "shouldn't" be there.** A small drawing in a corner, a weird typographic flourish, a horizontal rule with text in the middle (`/// chapter two ///`). Confusion = personality.

---

### Step 4 — Real human content injection (10 min)

#### One real photo
- Founder at desk, on a walk, with the product in hand.
- Not a stock smile-at-camera. Slight grain. CSS: `filter: grayscale(15%) contrast(1.05);` for unity.
- Place: about, hero corner, or footer.

#### One personal anecdote
- See [copywriting-humanizer.md §5](./copywriting-humanizer.md) for the framework.
- Place in About section. Always.

#### One real number
- "237 personas lo usan", "construido en 14 días", "v3, llevo 2 años en esto".
- Replace any "trusted by thousands" cliché.

#### One easter egg
- Console.log a message: `console.log("Si llegaste hasta acá, escríbeme: edwar@…")`.
- A 404 with humor.
- A hidden `/now` page (à la nownownow.com).
- A footer joke nobody requested.

---

### Step 5 — Humanized motion pass (10 min)

#### Custom easings (replace default `ease-in-out`)
```css
/* Use one of these depending on the feeling: */
--ease-spring:    cubic-bezier(0.34, 1.56, 0.64, 1);   /* bouncy, playful */
--ease-soft:      cubic-bezier(0.22, 1, 0.36, 1);      /* warm, kinfolk */
--ease-snappy:    cubic-bezier(0.4, 0, 0.2, 1);        /* technical, swiss */
--ease-organic:   cubic-bezier(0.65, 0, 0.35, 1);      /* slow start, slow end */
--ease-anticipate: cubic-bezier(0.68, -0.55, 0.27, 1.55); /* extreme overshoot */
```

#### Irregular delays
Instead of:
```css
.fade-in:nth-child(1) { animation-delay: 0.1s; }
.fade-in:nth-child(2) { animation-delay: 0.2s; }
.fade-in:nth-child(3) { animation-delay: 0.3s; }
```
Do this:
```css
.fade-in:nth-child(1) { animation-delay: 0.08s; }
.fade-in:nth-child(2) { animation-delay: 0.23s; }
.fade-in:nth-child(3) { animation-delay: 0.31s; }
```
Irregular timing feels human. Linear feels metronomic.

#### Personality micro-interactions (pick ONE per project)
- Button wiggle: `hover:rotate-[-2deg] active:rotate-[1deg]` with spring transition.
- Magnetic CTA: button slightly attracts the cursor within 100px.
- Cursor companion: a small text that follows the cursor with delay.
- Hover preview: link shows a tiny image preview on hover.
- Scroll-triggered text reveal letter by letter (slow, like a typewriter).

#### Always include
```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

---

### Step 6 — Manual proofread of copy (5 min)
- Search for em dashes (—). Replace ALL.
- Search for buzzwords from [copywriting-humanizer.md §1](./copywriting-humanizer.md). Replace ALL.
- Make sure first-person voice is present at least once.
- Make sure ONE strong opinion is stated.

---

### Step 7 — Show a non-techie friend (5 min)
- Open the page on your phone in front of them.
- Watch their face for 30 seconds. Don't explain.
- Ask: "what does this feel like?"
- If they say generic words ("clean", "professional") → not human enough.
- If they react ("ese tipo en serio dice esto?", "qué raro/lindo/divertido") → ✅
- If they laugh, get curious, or lean in → ✅✅

---

### Step 8 — Run audit
```bash
bash scripts/audit.sh ./your-project --fix
```
Score must be ≥ 70%. Fix top 3 issues. Re-run.

If still < 70%, you're missing soul. Repeat steps 2-5 with more conviction.

---

## What soul pass is NOT
- Adding more decorations randomly. (Decorations need intent.)
- Asking AI to "make it more human". (That defeats the point.)
- Copying another humanized site. (Then your site looks like that one.)

## What soul pass IS
- Decisions you couldn't have made with a prompt.
- The 5-10 things that make THIS project unmistakably yours.
- The reason a stranger will remember the site a week later.

---

## Soul Pass Checklist (print and tape to monitor)

```
☐ Read out loud, every word
☐ DNA signature element placed (mandatory)
☐ At least 6 of 10 micro-imperfections applied
☐ One real photo
☐ One personal anecdote in About
☐ One real number replacing fake "thousands"
☐ One easter egg
☐ Custom easings + irregular delays
☐ One personality micro-interaction
☐ prefers-reduced-motion handled
☐ Em dashes purged
☐ Banned buzzwords purged
☐ Non-techie reaction tested
☐ Audit score ≥ 70%
```

If all 14 are checked: ship it.
