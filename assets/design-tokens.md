# Design Tokens — strict architecture for AI

> If the AI can invent a value, it will. If every value is a token, it can't drift.
> This file explains the philosophy. The actual tokens live in [design-tokens.css](./design-tokens.css).

---

## Why tokens for AI workflows

When you tell an LLM "create a new section", it generates plausible CSS — usually drifting toward Tailwind defaults: `bg-white`, `text-gray-900`, `shadow-xl`, `rounded-2xl`, `font-sans`.

If those classes/values **don't exist** in your project (because you only have CSS variables), the AI is forced to pick from your tokens. The output stays cohesive without you correcting CSS every time.

This is the most important architectural decision for "vibecoding at scale".

---

## How to use

### Step 1 — Generate DNA
```bash
bash scripts/dna.sh <niche>
```

### Step 2 — Patch design-tokens.css
Open [design-tokens.css](./design-tokens.css) and replace the 4 marked palette colors and 2 fonts with the DNA values:

```css
--color-bg:      #YYYYYY;   /* DNA palette #1 */
--color-ink:     #YYYYYY;   /* DNA palette #2 */
--color-mute:    #YYYYYY;   /* DNA palette #3 */
--color-accent:  #YYYYYY;   /* DNA palette #4 */
--font-display:  "<DNA display>", serif;
--font-body:     "<DNA body>", sans-serif;
```

Also pick the DNA-appropriate `--radius-default` and `--shadow-default` (table at the bottom).

### Step 3 — Import as the FIRST stylesheet
```html
<link rel="stylesheet" href="/design-tokens.css">  <!-- before everything else -->
<link rel="stylesheet" href="/your-app.css">
```

In Next.js / Vite:
```tsx
// app/layout.tsx
import "../assets/design-tokens.css";
import "./globals.css";
```

### Step 4 — Lock the AI to tokens (paste into every prompt)

```
HARD CONSTRAINTS — read before generating any CSS:

You MUST use only the CSS variables defined in design-tokens.css.

✘ NEVER write hex codes (#xxxxxx).
✘ NEVER write Tailwind color names (bg-white, text-gray-900, bg-blue-500, etc).
✘ NEVER write box-shadow values inline. Use var(--shadow-*) only.
✘ NEVER use rounded-2xl, rounded-3xl. Use var(--radius-*) only.
✘ NEVER use Tailwind shadow-lg/xl/2xl. Use var(--shadow-soft/studio/float/brut).
✘ NEVER use 'Inter' or 'system-ui' as font-family. Use var(--font-display)
  for headings and var(--font-body) for everything else.
✘ NEVER use ease-in-out, ease-out, ease-in. Use var(--ease-*) only.

✓ Colors:    var(--color-bg | --color-ink | --color-mute | --color-accent)
✓ Spacing:   var(--space-1 ... --space-11)
✓ Type size: var(--text-sm ... --text-hero)
✓ Radius:    var(--radius-none/xs/sm/md/lg/xl/pill)
✓ Shadow:    var(--shadow-soft/studio/float/brut/glow)
✓ Easing:    var(--ease-spring/soft/snap/organic/anticipate/magnetic/thud)
✓ Duration:  var(--dur-instant/quick/base/slow/cinema)
✓ Border:    var(--border-hair/strong/thick/brutal/accent/dashed)

When using Tailwind: bg-[--color-bg], text-[--color-ink], shadow-[--shadow-soft],
rounded-[--radius-default], etc. (Tailwind v4 arbitrary value syntax.)
```

---

## The token contract (what's locked, what's free)

### Locked (NEVER override per component)
- The 4 palette colors.
- The 2-3 fonts.
- The duration ladder.
- The easing library.
- The z-index scale.
- The focus ring spec.

### Free per component (creative space)
- Combining tokens (e.g. `padding: var(--space-7) var(--space-5)` — asymmetric is fine).
- Choosing WHICH shadow/radius from the library.
- Custom transforms (`rotate-[-0.6deg]`).
- Composition (cards, layouts, grids).

This is the same principle as a design system: the materials are fixed, the composition is creative.

---

## Per-DNA defaults (set once, don't fight)

When you patch design-tokens.css after generating DNA, also set these defaults:

| DNA system | `--radius-default` | `--shadow-default` | `--ease-default` | `--noise-opacity` |
|---|---|---|---|---|
| `swiss-minimal` | `--radius-none` | `--shadow-xs` | `--ease-snap` | 0.03 |
| `editorial-magazine` | `--radius-none` | `--shadow-soft` | `--ease-magnetic` | 0.07 |
| `soft-brutalism` | `--radius-xs` | `--shadow-brut` | `--ease-thud` | 0.08 |
| `raw-brutalism` | `--radius-none` | `--shadow-brut-color` | `--ease-anticipate` | 0.10 |
| `kinfolk-warm` | `--radius-md` | `--shadow-soft` (warm) | `--ease-organic` | 0.07 |
| `organic-eco` | `--radius-lg` | `--shadow-soft` | `--ease-organic` | 0.06 |
| `terminal-cli` | `--radius-none` | `--shadow-none` | `linear` | 0.04 |
| `cyberpunk-neon` | `--radius-xs` | `--shadow-glow` | `--ease-anticipate` | 0.04 |
| `art-deco` | `--radius-none` | `--shadow-studio` | `--ease-soft` | 0.06 |
| `riso-print` | `--radius-none` | `--shadow-brut-color` | `step-end` | 0.10 |
| `glassmorphism` | `--radius-xl` | `--shadow-float` | `--ease-soft` | 0.04 |
| `y2k-revival` | `--radius-pill` | `--shadow-glow` | `--ease-spring` | 0.05 |
| `vaporwave` | `--radius-lg` | `--shadow-glow` | `--ease-soft` | 0.06 |
| `japanese-ma` | `--radius-none` | `--shadow-xs` | `--ease-organic` | 0.04 |
| `dashboard-dense` | `--radius-sm` | `--shadow-xs` | `--ease-snap` | 0.03 |
| `blueprint-technical` | `--radius-none` | `--shadow-xs` | `--ease-snap` | 0.05 |
| `monochrome-noir` | `--radius-none` | `--shadow-soft` | `--ease-magnetic` | 0.06 |
| `sci-fi-spatial` | `--radius-xl` | `--shadow-float` | `--ease-anticipate` | 0.05 |
| `luxury-premium` | `--radius-sm` | `--shadow-studio` | `--ease-magnetic` | 0.05 |

---

## Token files for other tools

### Figma → CSS via Style Dictionary
If your designer works in Figma, export tokens as JSON, then transform with [Style Dictionary](https://amzn.github.io/style-dictionary/) to produce the same `--color-*`, `--space-*` variables. The AI gets the same constraints whether the human edits Figma or CSS.

### Tailwind v4
```css
/* in your tailwind.css */
@import "../assets/design-tokens.css";

@theme {
  --color-bg:     var(--color-bg);
  --color-ink:    var(--color-ink);
  --color-accent: var(--color-accent);
  --font-display: var(--font-display);
  --font-sans:    var(--font-body);
  /* expose tokens that Tailwind utilities will generate (text-, bg-, etc.) */
}
```

### shadcn/ui override
Open `app/globals.css` and replace shadcn's HSL variables with your hex tokens. Comment out anything that doesn't match your DNA.

```css
/* in globals.css, after shadcn @layer base */
:root {
  --background: var(--color-bg);
  --foreground: var(--color-ink);
  --primary:    var(--color-accent);
  --primary-foreground: var(--color-bg);
  --border:     var(--color-ink);
  --radius:     var(--radius-default);
}
```

### CSS-in-JS (styled-components, Emotion)
```tsx
import { css } from "styled-components";
const tokens = {
  bg: "var(--color-bg)",
  ink: "var(--color-ink)",
  shadow: { soft: "var(--shadow-soft)", brut: "var(--shadow-brut)" },
  ease: { spring: "var(--ease-spring)", soft: "var(--ease-soft)" },
};
export default tokens;
```

---

## Token validation in CI (catch drift)

Add to package.json:
```json
"scripts": {
  "audit:tokens": "bash scripts/audit.sh ./src --fix",
  "audit:design": "bash scripts/audit.sh ./src --report audit-report.md"
}
```

The audit script will flag hardcoded hex codes, Tailwind defaults, and missing tokens.

---

## Anti-patterns to spot in PRs

```
✘ background: white                  → background: var(--color-bg)
✘ background: #fff                   → background: var(--color-bg)
✘ color: #1f2937                     → color: var(--color-ink)
✘ box-shadow: 0 25px 50px rgba(…)    → box-shadow: var(--shadow-studio)
✘ border-radius: 16px                → border-radius: var(--radius-lg)
✘ font-family: Inter                 → font-family: var(--font-body)
✘ transition: all 200ms ease-in-out  → transition: opacity var(--dur-quick) var(--ease-soft)
✘ padding: 16px 24px                 → padding: var(--space-4) var(--space-5)
```

If you find any of these in a PR, reject. The whole point of tokens is collapsing inconsistency.

---

## Files in this system

- [design-tokens.css](./design-tokens.css) — the actual token definitions (CSS variables)
- [tailwind-humanized-config.md](./tailwind-humanized-config.md) — Tailwind/shadcn integration recipe
- [brief-template.md](./brief-template.md) — strategy brief

## Reading order for new contributors

1. Read [SKILL.md](../SKILL.md).
2. Read this file (design-tokens.md).
3. Read the actual [design-tokens.css](./design-tokens.css).
4. Read [references/design-systems.md](../references/design-systems.md) for the system rules.
5. Generate DNA, patch tokens, ship.
