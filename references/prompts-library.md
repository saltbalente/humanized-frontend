# Prompt Library — DNA-aware

Every prompt has a **`{{DNA}}` placeholder**. Always run `bash scripts/dna.sh <niche>` first and paste the full output where indicated. This is what guarantees uniqueness.

## Universal "Avoid List" snippet (paste into every prompt)

```
NEVER, under any circumstance, output:
- Purple/pink/blue gradients (no `from-purple-500`, `to-pink-500`, etc.)
- Glassmorphism / backdrop-blur (unless DNA system is sci-fi-spatial)
- shadow-xl + rounded-2xl combo
- Heroicons or Lucide default icons
- Em dashes (—) in any copy
- Words: unleash, empower, seamless, elevate, transform, leverage, robust, game-changer, synergy
- Perfectly centered symmetric layouts (unless DNA layout is `centered-editorial-drop-cap-intro`)
- Floating 3D blobs or glossy cards (unless DNA system is y2k-revival or neo-skeuomorphic)
- Default shadcn/ui look out of the box
- Stock-photo people pointing at laptops
```

---

## 1. MASTER PROMPT — DNA-driven build (works for any tool)

```
You are building a [PROJECT TYPE: landing / dashboard / portfolio / e-commerce / blog]
in [STACK: Next.js + Tailwind v4 / Astro / SvelteKit / plain HTML / etc].

═══ DESIGN DNA — TREAT AS CONTRACT ═══
{{DNA}}
═══════════════════════════════════════

RULES:
1. Apply the DNA system EXACTLY. Read references/design-systems.md for that system.
2. Use ONLY the 4 colors from the DNA palette. No additions.
3. Use ONLY the typography pair from DNA. Import from Google Fonts or Fontshare.
4. Apply the surface treatment to ALL surfaces. Do not mix.
5. The signature element MUST appear at least once and must feel intentional.
6. Copy tone is locked to the DNA tone. Apply rules from references/copywriting-humanizer.md.
7. Niche must-haves: read references/niche-playbooks.md for the niche in DNA.

[paste universal AVOID LIST here]

DELIVERABLE: production-ready code, semantic HTML, accessible (WCAG AA min),
responsive (test 360 / 768 / 1280 / 1920), respects prefers-reduced-motion.

Generate 3 hero variants under the same DNA constraints — let me pick.
```

---

## 2. Refactor / humanize an existing UI

```
Refactor the file [path]. Functionality unchanged.

═══ TARGET DESIGN DNA ═══
{{DNA}}
═════════════════════════

Steps:
1. Replace background, borders, shadows, radii to match DNA system + surface.
2. Replace fonts with DNA typography pair (load from Google Fonts).
3. Recolor to DNA's 4-token palette only.
4. Apply DNA layout archetype to the page skeleton.
5. Inject DNA signature element (one place is enough, must feel earned).
6. Rewrite copy in DNA tone. Strip em dashes, banned buzzwords.
7. Replace any Heroicons/Lucide with custom SVGs, glyphs, or DNA-system-appropriate icons.

[universal AVOID LIST]

Return only the refactored file(s).
```

---

## 3. Hero section only (fast iteration)

```
Generate ONE hero section. {{DNA}}

Constraints:
- Headline: max 7 words, in DNA copy tone, in DNA display font.
- One real photo placeholder (use unsplash with descriptive query, NOT generic).
- Single CTA, styled per DNA system (e.g. brutalist offset shadow / hairline link / arcade pixel).
- Signature element from DNA visible.
- Mobile first, no horizontal scroll.

[universal AVOID LIST]
```

---

## 4. Pricing section

```
Generate a pricing section. {{DNA}}

Per-system rules:
- swiss-minimal / editorial-magazine: typographic table, no cards, sentence-case plan names.
- soft-brutalism / raw-brutalism: 1px borders + offset shadow on the recommended plan.
- terminal-cli: render as `[ FREE ] [ PRO ] [ TEAM ]` ASCII boxes.
- y2k-revival / vaporwave: chrome buttons OK, sparkles OK.
- luxury-quiet: 2 plans max, prices in display serif, no "Most Popular" badges.

Plan names: avoid "Starter / Pro / Enterprise". Use real-feeling names that match the DNA tone.
Copy: state what the plan does NOT include — honesty is humanizing.

[universal AVOID LIST]
```

---

## 5. v0.dev / Lovable / Bolt prompt (overrides shadcn defaults)

```
Use shadcn/ui ONLY as primitives (Button, Card, Input). Override every default style.

═══ DNA ═══
{{DNA}}
═══════════

Required overrides:
- Card: remove default shadow + radius, apply DNA surface treatment.
- Button default variant: apply DNA system's button recipe (read references/design-systems.md).
- No Lucide icons → replace with inline SVG, unicode glyph (▲ ◆ ✦ →), or DNA-appropriate.
- Fonts: replace Inter/Geist defaults with DNA typography pair (Google Fonts).
- Background: replace bg-background with DNA palette bg.

Copy in DNA tone, first person, one strong opinion.

[universal AVOID LIST]
```

---

## 6. Cursor / Codex inline edit

```
@file: components/Hero.tsx
@skill: humanized-frontend
@dna: {{DNA inline or path to dna-output.md}}

Apply DNA exactly. Keep props/types. Return diff only.
```

---

## 7. Iterate-with-restraint prompt ("don't dump 200 lines")

```
Look at the current state of [file]. Score it 0–10 on "matches DNA".
Then list the top 5 deviations from DNA.
Propose a refactor for #1 only. Wait for me to approve before #2.
```

---

## 8. Midjourney / Flux — DNA-aware imagery

For hero photo (real-feeling):
```
candid documentary photo, [DNA palette name] color grading, natural light,
slight 35mm film grain, slightly off-center composition, no posed smiling at camera,
real workspace context, --ar 4:5 --style raw --v 6
```

For hand-drawn icons (when DNA system is soft-brutalism / handmade-zine / organic-eco):
```
single-weight ink line icon, slightly wobbly hand drawn, on [DNA bg color] paper,
risograph print feel, no shading, no color fill, minimal, 1024x1024 --style raw --v 6
```

For background texture:
```
seamless texture of [paper / concrete / linen / blueprint grid / halftone],
subtle, scannable, 2048x2048, no logo, no watermark
```

---

## 9. Re-roll DNA (when the first one doesn't fit)

If the agent / user doesn't love the DNA, re-roll instead of compromising:
```bash
bash scripts/dna.sh <niche>           # new random
bash scripts/dna.sh <niche> 7         # try a new explicit seed
bash scripts/dna.sh auto              # let DNA pick the niche too
```

Generate 3 DNAs, pick the strongest, then build. **Do not blend two DNAs.**

---

## 10. Audit prompt (final QC)

```
Run `bash scripts/audit.sh <output-dir>`. Report the score and every ✗.
For each ✗, propose the minimal fix that respects the locked DNA.
Apply fixes one by one with my approval.
```

---

## 11. Variable Fonts Animation (master prompt)

> Full reference: [variable-fonts.md](./variable-fonts.md). This is the prompt to drop into Cursor / Claude / GPT / v0.

```
Act as a Senior Creative Developer expert in digital typography and fluid design.
Implement Variable Fonts Animation in this component to give it a unique,
modern, author-driven visual identity.

═══ DESIGN DNA — TREAT AS CONTRACT ═══
{{DNA}}
═══════════════════════════════════════

TECHNICAL REQUIREMENTS:

1. FONT
   - Use a variable font ONLY (Inter Variable, Geist, Fraunces, Recursive,
     Bricolage Grotesque, Roboto Flex, or whatever the DNA's typography slot
     specifies — pick the variable equivalent).
   - Declare @font-face with `font-weight: 100 900` to enable the full range.
   - Self-host or use next/font with explicit `axes` option.

2. FLUID TYPOGRAPHY
   - Configure the type scale with clamp() so font-size responds to viewport
     without hard breakpoints. Pull values from --text-* tokens in
     design-tokens.css when present.

3. AXIS ANIMATION (CORE)
   - You MUST use `font-variation-settings`. NEVER `font-weight: bold` or 700.
   - Resting:  font-variation-settings: 'wght' 400, 'slnt' 0;
   - Hover:    transition wght 400→800 AND slnt 0→-8.
   - Transition: font-variation-settings 0.5s var(--ease-soft, cubic-bezier(0.22,1,0.36,1));
   - Apply same hover state on :focus-visible (a11y).

4. BREATHING ANIMATION (hero / display only)
   - Add an infinite, very subtle keyframes that vary wght by ±5% (e.g. 400↔440)
     over 6-8s. Like breathing.
   - WRAP in @media (prefers-reduced-motion: no-preference) — never under
     reduced-motion.

5. AESTHETIC GOAL
   - Text must feel alive, react like flexible material.
   - All weight changes through font-variation-settings.
   - All transitions on font-variation-settings, NOT on font-weight.

6. DESIGN TOKEN INTEGRATION
   - Use --font-display, --font-body, --ease-soft, --text-* from
     design-tokens.css. Do NOT hardcode font-family inline.

DELIVERABLE:
- A single component (HTML+CSS or React or Tailwind arbitrary values).
- The CSS must demonstrate axis interpolation, fluid sizing, hover, breathing,
  and reduced-motion respect.
- Brief comment explaining which axes you animated for THIS font and why.
```

### Tip for Tailwind users
Append:
```
Use Tailwind v4 arbitrary value syntax for variable axes:
  [font-variation-settings:'wght'_420,'opsz'_144]
  hover:[font-variation-settings:'wght'_760,'slnt'_-6]
  transition-[font-variation-settings] duration-500
  [transition-timing-function:cubic-bezier(0.22,1,0.36,1)]
```
