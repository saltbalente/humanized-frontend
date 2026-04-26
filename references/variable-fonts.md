# Variable Fonts Animation — typography that breathes

> Static fonts switch between weights with a hard jump (400 → 700 = different file).
> Variable fonts interpolate every value in between (400 → 401 → 402 → … → 700) at the cost of zero extra HTTP requests.
> This file shows you how to animate axes (`wght`, `slnt`, `wdth`, `opsz`, `GRAD`) so type feels alive, not pasted.

Less than 5% of sites use this. It is one of the highest-leverage modern signatures.

---

## 0. Why variable fonts beat static fonts (for humanization)

| | Static | Variable |
|---|---|---|
| HTTP requests for 5 weights | 5 files | 1 file |
| Total weight | ~250 KB | ~80 KB |
| `font-weight: bold` transition | binary jump | smooth interpolation across all 300 values |
| Custom optical sizing | no | `opsz` axis |
| Custom slant per pixel of scroll | no | yes |
| AI cliché score | high (Inter 400/700) | very low |

Variable fonts are **lighter, smoother, and rarer** — three multipliers at once.

---

## 1. Recommended variable fonts (free, production-ready)

| Font | Axes | Use |
|---|---|---|
| **Inter Variable** | wght, slnt, opsz | UI body (still common, but used variably ≠ default) |
| **Geist** / **Geist Mono** | wght | Vercel-style, technical |
| **Fraunces** | wght, slnt, opsz, SOFT, WONK | display serif, editorial, high personality |
| **Recursive** | wght, slnt, MONO, CASL, CRSV | maximally expressive, 5 axes |
| **Roboto Flex** | wght, wdth, opsz, slnt, GRAD, XOPQ | dashboard, technical |
| **Source Serif 4 Variable** | wght, opsz | premium serif |
| **Bricolage Grotesque** | wght, wdth, opsz | hero / display |
| **Instrument Serif** | wght (italic via slnt) | fashion, editorial |
| **DM Sans** | opsz, wght | clean, modern UI |
| **Outfit** | wght | display, big claims |
| **Crimson Pro** | wght, italic | long-form, editorial body |
| **Newsreader** | wght, opsz, italic | publishing, journalism |

### Per-DNA-system pick
| DNA system | Variable font choice |
|---|---|
| `editorial-magazine` | Fraunces (display) + Newsreader (body) |
| `swiss-minimal` | Inter Variable (body) + Bricolage (display) |
| `soft-brutalism` | Recursive (max expression) |
| `kinfolk-warm` | Fraunces + Crimson Pro |
| `terminal-cli` | Geist Mono Variable |
| `dashboard-dense` | Roboto Flex (multi-axis density control) |
| `cyberpunk-neon` | Recursive (with MONO + CASL) |
| `art-deco` | Fraunces (high SOFT axis) |
| `y2k-revival` | Bricolage Grotesque (wide axis) |
| `japanese-ma` | Instrument Serif + DM Sans |
| `luxury-premium` | Source Serif 4 Variable |
| `riso-print` | Outfit + Recursive |

---

## 2. Loading variable fonts

### Self-host (preferred — privacy, performance, control)
Download `.woff2` from [fontsource.org](https://fontsource.org/) or [Google Fonts](https://fonts.google.com/?vfonly=true).

```css
@font-face {
  font-family: "Inter Variable";
  src: url("/fonts/InterVariable.woff2") format("woff2-variations");
  font-weight: 100 900;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: "Inter Variable";
  src: url("/fonts/InterVariable-Italic.woff2") format("woff2-variations");
  font-weight: 100 900;
  font-style: italic;
  font-display: swap;
}
```

Note `font-weight: 100 900` is the **range** — required for variable.

### Google Fonts API (single line)
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght,SOFT,WONK@9..144,100..900,0..100,0..1&display=swap" rel="stylesheet">
```

### Next.js / `next/font`
```tsx
// app/layout.tsx
import { Fraunces } from "next/font/google";

const fraunces = Fraunces({
  subsets: ["latin"],
  variable: "--font-display",
  axes: ["opsz", "SOFT", "WONK"],   // explicit variable axes
  display: "swap",
});

<html className={fraunces.variable}>
```

---

## 3. The master prompt (paste into Cursor / Claude / GPT / v0)

```
Act as a Senior Creative Developer expert in digital typography and fluid design.
Implement the concept of Variable Fonts Animation in this component to give it a
unique, modern, author-driven visual identity.

TECHNICAL REQUIREMENTS:

1. FONT
   - Use a variable font ONLY (Inter Variable, Geist, Fraunces, Recursive, or
     Bricolage Grotesque from Google Fonts).
   - Declare the @font-face with `font-weight: 100 900` to enable the full range.
   - Self-host or use next/font with `axes` option.

2. FLUID TYPOGRAPHY
   - Configure the type scale with clamp() so font-size responds to the viewport
     without hard breakpoints. Example:
       font-size: clamp(2rem, 1.2rem + 4vw, 5rem);

3. AXIS ANIMATION (CORE)
   - You MUST use `font-variation-settings`. NEVER `font-weight: bold` or 700.
   - Define resting state: font-variation-settings: 'wght' 400, 'slnt' 0;
   - On :hover transition wght 400 → 800 AND slnt 0 → -8.
   - Transition: font-variation-settings 0.5s cubic-bezier(0.4, 0, 0.2, 1);
   - On :focus-visible apply the same as :hover plus the project focus ring.

4. BREATHING ANIMATION (for hero / display headlines only)
   - Add an infinite, very subtle keyframes animation that varies wght by ±5%
     (e.g. 400 ↔ 440) over 6-8s. Like breathing.
   - Wrap in @media (prefers-reduced-motion: no-preference) — never play under
     reduced-motion.

5. AESTHETIC GOAL
   - Text must feel alive, react to the user like flexible material.
   - No static font-weight bolding. All weight changes through
     font-variation-settings.
   - All transitions on font-variation-settings, NOT on font-weight.

6. DESIGN TOKEN INTEGRATION
   - Use the project's --font-display and --font-body variables from
     design-tokens.css. Do NOT hardcode font-family inline.
   - Use the project's --ease-soft (cubic-bezier(0.22, 1, 0.36, 1)) or
     the snap variant if defined.

DELIVERABLE:
- A single component (HTML+CSS or React+CSS-in-JS or Tailwind arbitrary values).
- The CSS must demonstrate axis interpolation, fluid sizing, hover, breathing,
  and reduced-motion respect.
- Include a brief comment explaining which axes are animated and why for THIS
  font choice.
```

---

## 4. Reference implementations

### Plain CSS (hero headline with hover + breathing)
```css
.hero-title {
  font-family: var(--font-display, "Fraunces"), serif;
  font-size: clamp(3rem, 2rem + 7vw, 9rem);
  font-variation-settings: "wght" 420, "opsz" 144, "SOFT" 50, "WONK" 0;
  letter-spacing: -0.04em;
  line-height: 1.02;
  transition: font-variation-settings 0.6s cubic-bezier(0.22, 1, 0.36, 1);
  will-change: font-variation-settings;
}

.hero-title:hover,
.hero-title:focus-visible {
  font-variation-settings: "wght" 760, "opsz" 144, "SOFT" 80, "WONK" 1;
}

@keyframes breathing {
  0%, 100% { font-variation-settings: "wght" 420, "opsz" 144, "SOFT" 50, "WONK" 0; }
  50%      { font-variation-settings: "wght" 460, "opsz" 144, "SOFT" 60, "WONK" 0; }
}

@media (prefers-reduced-motion: no-preference) {
  .hero-title { animation: breathing 7.2s ease-in-out infinite; }
}
```

### Inter Variable on body links
```css
a {
  font-family: var(--font-body), sans-serif;
  font-variation-settings: "wght" 480, "slnt" 0;
  text-decoration: underline;
  transition: font-variation-settings 0.35s cubic-bezier(0.22, 1, 0.36, 1),
              color 0.2s ease;
}
a:hover {
  font-variation-settings: "wght" 640, "slnt" -3;
  color: var(--color-accent);
}
```

### React hook — animate axis based on scroll
```tsx
import { useEffect, useState } from "react";

export function useScrollWeight(min = 300, max = 800) {
  const [wght, setWght] = useState(min);
  useEffect(() => {
    const onScroll = () => {
      const ratio = Math.min(1, window.scrollY / window.innerHeight);
      setWght(min + (max - min) * ratio);
    };
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, [min, max]);
  return wght;
}

export function ScrollHeading({ children }) {
  const wght = useScrollWeight(280, 760);
  return (
    <h1 style={{ fontVariationSettings: `"wght" ${wght}, "slnt" 0` }}>
      {children}
    </h1>
  );
}
```

### React hook — animate axis based on cursor proximity
```tsx
import { useRef, useEffect, useState } from "react";

export function MagneticType({ children }) {
  const ref = useRef<HTMLSpanElement>(null);
  const [vs, setVs] = useState({ wght: 400, slnt: 0 });

  useEffect(() => {
    const onMove = (e: MouseEvent) => {
      const r = ref.current?.getBoundingClientRect();
      if (!r) return;
      const dx = e.clientX - (r.left + r.width / 2);
      const dy = e.clientY - (r.top + r.height / 2);
      const dist = Math.hypot(dx, dy);
      const max = 320;
      const k = Math.max(0, 1 - dist / max);
      setVs({
        wght: 400 + k * 360,    // up to 760
        slnt: -k * 8,           // up to -8
      });
    };
    window.addEventListener("mousemove", onMove);
    return () => window.removeEventListener("mousemove", onMove);
  }, []);

  return (
    <span
      ref={ref}
      style={{
        fontVariationSettings: `"wght" ${vs.wght.toFixed(0)}, "slnt" ${vs.slnt.toFixed(2)}`,
        transition: "font-variation-settings 0.18s cubic-bezier(0.22,1,0.36,1)",
      }}
    >
      {children}
    </span>
  );
}
```

### Framer Motion + variable axes
```tsx
import { motion, useMotionValue, useTransform, useSpring } from "framer-motion";

function VariableHeading({ children }) {
  const x = useMotionValue(400);
  const sx = useSpring(x, { stiffness: 200, damping: 22 });
  const settings = useTransform(sx, (v) => `"wght" ${v.toFixed(0)}, "slnt" 0`);

  return (
    <motion.h1
      onHoverStart={() => x.set(820)}
      onHoverEnd={() => x.set(400)}
      style={{ fontVariationSettings: settings }}
    >
      {children}
    </motion.h1>
  );
}
```

---

## 5. Tailwind v4 / arbitrary value syntax

Tailwind doesn't ship variable-axis utilities, but arbitrary values cover everything:

```html
<h1 class="
  font-[var(--font-display)]
  text-[clamp(3rem,7vw+1rem,9rem)]
  [font-variation-settings:'wght'_420,'opsz'_144]
  hover:[font-variation-settings:'wght'_760,'opsz'_144,'slnt'_-6]
  transition-[font-variation-settings] duration-500
  [transition-timing-function:cubic-bezier(0.22,1,0.36,1)]
  motion-safe:animate-[breathing_7s_ease-in-out_infinite]
">
  Title
</h1>
```

Add the keyframe:
```css
@keyframes breathing {
  0%, 100% { font-variation-settings: "wght" 420; }
  50%      { font-variation-settings: "wght" 460; }
}
```

### tailwind.config.ts (load font + helper)
```ts
export default {
  theme: {
    extend: {
      fontFamily: {
        display: ['var(--font-display)'],
        body:    ['var(--font-body)'],
      },
    },
  },
};
```

---

## 6. Per-DNA axis recipes

Match the axis behavior to the DNA tone — don't apply the same hover everywhere.

| DNA tone / system | Resting | Hover | Breathing |
|---|---|---|---|
| `kinfolk-warm` (Fraunces) | `wght 380, opsz 144, SOFT 60` | `wght 540, SOFT 90` | ±20 wght, 8s |
| `manifesto-bold` (Recursive) | `wght 700, CASL 0, MONO 0` | `wght 900, CASL 0.4` | none |
| `swiss-minimal` (Inter) | `wght 460, slnt 0` | `wght 620, slnt 0` | none (too restrained) |
| `terminal-cli` (Geist Mono) | `wght 400` | `wght 700` | none |
| `editorial-magazine` (Fraunces) | `wght 420, SOFT 40, WONK 0` | `wght 720, SOFT 80, WONK 1` | ±25 wght, 9s |
| `art-deco` (Fraunces) | `wght 600, opsz 144, SOFT 100` | `wght 800, SOFT 100` | none (deco wants stillness) |
| `cyberpunk-neon` (Recursive) | `wght 600, CASL 0.6` | `wght 850, CASL 1, MONO 0.5` | wght glitch ±60, 0.4s 3-burst |
| `dashboard-dense` (Roboto Flex) | `wght 420, wdth 90, opsz 14` | `wght 600, wdth 95` | none |
| `wellness` (Newsreader) | `wght 380, opsz 144` | `wght 520` | ±15 wght, 10s (slow breath) |
| `y2k-revival` (Bricolage) | `wght 700, wdth 100, opsz 96` | `wght 800, wdth 110` | wdth ±5, 6s |

---

## 7. Pairing with motion-physics

Variable axes pair beautifully with the easing library in [motion-physics.md](./motion-physics.md):
- `--ease-soft` → for graceful weight transitions on links and headings.
- `--ease-spring` → for bouncy, playful hover (text bounces wider then settles).
- `--ease-organic` → for breathing animations (slow, asymmetric in/out).
- Avoid `--ease-anticipate` (overshoot) on type — it makes letters look broken.

---

## 8. Common mistakes (audit will catch)

| ❌ Wrong | ✅ Right |
|---|---|
| `font-weight: 700` | `font-variation-settings: "wght" 700` |
| `font-weight: bold` | `font-variation-settings: "wght" 800` |
| transition: `font-weight` | transition: `font-variation-settings` |
| Loading 5 separate weight files | Loading one variable file with `font-weight: 100 900` |
| `font-style: italic` (via separate file) | `font-variation-settings: "slnt" -10` (true italic axis if available, otherwise opt-italic) |
| Static `font-size: 3rem` | `font-size: clamp(2rem, 1.2rem + 4vw, 5rem)` |
| Breathing on body text | Breathing only on hero / display |
| Breathing without prefers-reduced-motion guard | Always wrap in `@media (prefers-reduced-motion: no-preference)` |

---

## 9. Performance notes

- A single variable font is ~80-120 KB. Load **subset** (latin only) when possible.
- Subset further with [glyphhanger](https://github.com/zachleat/glyphhanger) for production sites.
- `font-display: swap` is mandatory.
- Preload critical variable font:
  ```html
  <link rel="preload" href="/fonts/Fraunces-Variable.woff2" as="font" type="font/woff2" crossorigin>
  ```
- `font-variation-settings` triggers paint, not layout — generally cheap. But avoid animating on 50+ elements simultaneously.
- Use `will-change: font-variation-settings` ONLY while actively animating, then remove.

---

## 10. Browser support

All evergreen browsers (Chrome 62+, Safari 11+, Firefox 62+, Edge 17+). 99%+ global support.

For the rare ancient browser, fonts gracefully fall back to the closest static weight via the `font-weight: 100 900` range.

---

## 11. Audit checklist

```
☐ Page uses at least one variable font (font-weight: 100 900 in @font-face)
☐ All headings use font-variation-settings (NOT font-weight)
☐ Hero / display heading has axis hover transition (wght or slnt)
☐ Hero heading has subtle breathing animation
☐ Breathing animation wrapped in prefers-reduced-motion: no-preference
☐ font-size uses clamp() for fluid response
☐ font-family pulled from --font-display / --font-body tokens
☐ Transition timing uses cubic-bezier from --ease-* tokens
☐ No font-weight: bold / 700 anywhere (search and destroy)
☐ Variable font preloaded if above-the-fold
```

## 12. Tools

- **fontsource.org** — drop-in NPM packages for variable fonts
- **fonts.google.com/?vfonly=true** — Google Fonts variable filter
- **v-fonts.com** — gallery of variable fonts with live axis playgrounds
- **glyphhanger** — subset for production
- **Variable Fonts in Action** (Wakamai Fondue) — inspect axes of any font file
