# Prompt Library (Claude Code · Codex · Cursor · v0)

All prompts are pre-tested. Always **attach a reference screenshot** of a real human-made site you love (Pitch, Linear pre-2024, Are.na, personal portfolios on awwwards "anti-design" tag, etc.).

---

## 1. Universal "Avoid List" snippet (paste into every prompt)

```
AVOID AT ALL COSTS:
- Purple/pink/blue gradients (no `from-purple-500`, `to-pink-500`, etc.)
- Glassmorphism / backdrop-blur
- shadow-xl + rounded-2xl combo
- Heroicons or Lucide default icons
- Em dashes (—) in any copy
- Words: unleash, empower, seamless, elevate, transform, leverage, robust, game-changer
- Perfectly centered symmetric layouts
- Floating 3D blobs or glossy cards
- Pure white #FFFFFF backgrounds
- Default shadcn/ui look out of the box
```

---

## 2. Landing page — soft brutalism

```
Build a landing page in [Next.js 15 + Tailwind v4 + TypeScript].

REFERENCE: I'm attaching a screenshot of [name a real human site]. Match its energy, not its exact layout.

STYLE: Soft brutalism + warm SaaS. Cream background (#F4EFE6), ink black (#1A1A1A),
single accent #FF5C39. Serif display font (Fraunces or Instrument Serif) + Inter for body.
Use 1–2px solid black borders and offset shadows like `shadow-[4px_4px_0_#000]` instead of soft shadows.
Mix radii (mostly rounded-none, some rounded-[2px]).

LAYOUT:
- Hero: headline left, oversized serif (clamp(3.5rem, 9vw, 8rem), leading-[0.9]),
  one keyword underlined in accent. Real photo bleeding to right edge.
  CTA is a brutalist button with offset shadow.
- 3 asymmetric value props (rotate cards -0.6° / +0.4° / -1°).
- One section with a hand-drawn SVG arrow connecting two ideas.
- Testimonials: only 2, with full name + city, slightly off-aligned.
- Footer: opinionated, first person.

COPY: First-person voice. Short and long sentences mixed. Include one anecdote
and one "what this is NOT". No motivational filler.

[paste universal AVOID LIST here]

Generate 3 variants of the hero and let me pick.
```

---

## 3. SaaS hero refactor (humanize an existing one)

```
Here is my current hero component: [paste code].

Refactor it to feel hand-made and opinionated. Keep functionality identical.

Changes required:
1. Replace the gradient background with a solid warm color of your choice from
   {#F4EFE6, #ECECEA, #FFF8E7}.
2. Replace the headline font with a serif with character.
3. Break symmetry: offset the CTA group by 8px to the right and rotate the
   product image -1.5°.
4. Replace the "Get Started" button with a brutalist button (border-2 border-black,
   offset shadow, hover translate effect).
5. Rewrite the headline in first person, max 7 words, with one strong opinion.
6. Remove all em dashes, replace with periods or commas.
7. Add a tiny handwritten-style note (use a script-y Google Font like Caveat) with
   an arrow SVG pointing at the CTA.

[paste universal AVOID LIST]

Return only the refactored component.
```

---

## 4. Portfolio (personal, indie)

```
Build a single-page portfolio for [name, role, city].

VIBE: Editorial magazine + personal blog from 2008 + 2026 polish.
- System font for body (-apple-system, ui-sans-serif).
- Big serif drop cap on the intro paragraph.
- Underlined links, no hover-only states.
- One real photo of me, treated with subtle grain.
- Project list as a typographic table, not cards.
- A "now" section (à la nownownow.com) with what I'm doing this month.
- Footer with my actual email, no contact form.

Tone: first person, slightly self-deprecating, opinions about my craft.

[universal AVOID LIST]
```

---

## 5. v0.dev starter prompt

v0 tends to default to shadcn-glossy. Force it:

```
Generate a [hero section / pricing / feature grid] using shadcn/ui ONLY as
primitives (Button, Card), but override every default style.

Required overrides:
- Card: remove shadow, add `border-2 border-black`, background #F4EFE6.
- Button variant="default": override with brutalist offset shadow style.
- No gradients, no backdrop-blur, no rounded-2xl (use rounded-none).
- Replace any Lucide icon with a custom inline SVG or a unicode glyph (▲ ◆ ✦ →).
- Use Fraunces for headings (import from Google Fonts) and Inter for body.

Copy must be first-person and contain one opinion.
```

---

## 6. Cursor / Codex inline edit prompt

When editing a single component:

```
@file: components/Hero.tsx
Apply humanized-frontend skill rules:
- kill gradient, use solid warm bg
- serif headline, oversized, leading-[0.9]
- brutalist CTA with offset shadow
- break symmetry on hero image
- rewrite copy: first person, no em dashes, one opinion
Keep props and types unchanged.
```

---

## 7. Midjourney / Flux (illustrations & photos)

For hand-drawn icons:
```
hand-drawn icon, single weight ink line, slightly wobbly, on cream paper background,
risograph print feel, no shading, no color fill, minimal, 1024x1024 --style raw --v 6
```

For founder photo (if no real one available — last resort):
```
candid documentary photo of [description], natural window light, slight film grain,
35mm, slightly off-center composition, no smiling at camera, lived-in workspace, --ar 4:5
```

---

## 8. Iteration prompt ("make it more human")

```
Look at the current state of [file]. Score it 0–10 on "feels hand-made vs feels AI-generated".
Then list the top 5 things making it feel AI-generated.
Then propose a refactor for each, one at a time, and apply only #1.
Wait for me to approve before #2.
```

This forces the agent to slow down and not vibe-dump 200 lines of glossy code.
