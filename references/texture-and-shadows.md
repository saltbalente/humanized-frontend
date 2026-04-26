# Texture & Shadows — depth without cliché

> Flat solid colors look digital and cold. Default `shadow-xl` looks shadcn.
> This file gives you grain, layered shadows, and material-aware depth that elevates UI from "fine" to "premium editorial".

---

## 1. Grain / Noise overlay (the #1 upgrade)

A 5-8% noise overlay across the entire page makes solid colors feel like printed paper, not screen pixels. Editorial print magazines have done this forever.

### Inline SVG noise (zero HTTP request, perfect quality)
```html
<svg class="noise-overlay" aria-hidden="true">
  <filter id="grain">
    <feTurbulence type="fractalNoise" baseFrequency="0.85" numOctaves="2" stitchTiles="stitch"/>
    <feColorMatrix values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 0.6 0"/>
  </filter>
  <rect width="100%" height="100%" filter="url(#grain)"/>
</svg>
```

```css
.noise-overlay {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 9999;
  opacity: 0.06;          /* 5-8% is sweet spot */
  mix-blend-mode: overlay; /* let underlying color breathe */
}

@media (prefers-reduced-motion: reduce) {
  .noise-overlay { opacity: 0.04; }
}
```

### Tailwind utility
```html
<div class="relative bg-[--bg-warm] before:fixed before:inset-0 before:z-[9999] before:pointer-events-none before:opacity-[0.06] before:[background-image:url('/noise.svg')] before:mix-blend-overlay">
  …
</div>
```

### Per-niche noise intensity
| Niche / DNA | Opacity | Type |
|---|---|---|
| `kinfolk-warm`, `editorial-magazine`, `coffee-roaster` | 0.07 | fractalNoise, baseFrequency 0.9 |
| `riso-print`, `art-deco`, `vaporwave` | 0.10 | turbulence, baseFrequency 0.65 |
| `swiss-minimal`, `dashboard-dense`, `dev-tools` | 0.03 | fractalNoise, baseFrequency 1.0 (very fine) |
| `soft-brutalism`, `raw-brutalism` | 0.08 | fractalNoise, baseFrequency 0.7 (visible grain) |
| `terminal-cli`, `cyberpunk-neon` | 0.04 | scanlines (different — see §6) |
| `wellness`, `meditation`, `healthcare` | 0.04 | fractalNoise, baseFrequency 1.1 |

### Don't
- Apply noise > 0.12 opacity (looks broken).
- Apply noise to UI controls (only to backgrounds and large surfaces).
- Use a lossy JPEG noise texture (banding artifacts).

---

## 2. Layered shadows (studio lighting, not blur-fest)

The default Material/Tailwind shadow is a single soft blur. Real shadows have **multiple layers**: a tight dark contact shadow + a soft ambient shadow.

### ❌ Generic AI shadow
```css
box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);  /* Tailwind shadow-2xl */
```

### ✅ Studio-lit layered shadows
```css
:root {
  /* "Soft daylight" - kinfolk, wellness, editorial */
  --shadow-soft:
    0 1px 2px rgba(15, 12, 10, 0.04),
    0 4px 8px rgba(15, 12, 10, 0.06),
    0 16px 32px rgba(15, 12, 10, 0.08);

  /* "Studio key light" - product, premium */
  --shadow-studio:
    0 2px 4px rgba(0, 0, 0, 0.06),
    0 8px 16px rgba(0, 0, 0, 0.08),
    0 24px 48px rgba(0, 0, 0, 0.10),
    0 48px 96px rgba(0, 0, 0, 0.06);

  /* "Late afternoon long shadow" - editorial */
  --shadow-long:
    8px 16px 0 rgba(0, 0, 0, 0.08),
    16px 32px 32px rgba(0, 0, 0, 0.06);

  /* "Brutalist offset" - hard, no blur */
  --shadow-brut:
    4px 4px 0 var(--ink);
  --shadow-brut-color:
    6px 6px 0 var(--accent);

  /* "Embedded / pressed in" - inputs, wells */
  --shadow-inset:
    inset 0 1px 2px rgba(0, 0, 0, 0.06),
    inset 0 0 0 1px rgba(0, 0, 0, 0.04);

  /* "Floating dialog" - modals */
  --shadow-float:
    0 0 0 1px rgba(0, 0, 0, 0.04),
    0 4px 8px rgba(0, 0, 0, 0.04),
    0 24px 48px rgba(0, 0, 0, 0.12),
    0 56px 112px rgba(0, 0, 0, 0.08);

  /* "Glow neon" - cyberpunk */
  --shadow-glow:
    0 0 0 1px var(--accent),
    0 0 20px rgba(255, 0, 200, 0.4),
    0 0 60px rgba(255, 0, 200, 0.2);
}

.card { box-shadow: var(--shadow-soft); }
.card-premium { box-shadow: var(--shadow-studio); }
.modal { box-shadow: var(--shadow-float); }
```

### Shadow color = warm, not gray
For warm DNA palettes (kinfolk, coffee, wellness), tint shadows with the ink color, not pure black:
```css
/* Instead of rgba(0,0,0,0.1) */
--shadow-warm:
  0 2px 4px rgba(74, 50, 30, 0.06),   /* tinted toward warm ink */
  0 8px 16px rgba(74, 50, 30, 0.08),
  0 24px 48px rgba(74, 50, 30, 0.10);
```

### Per-DNA-system shadow choice
| DNA system | Shadow token |
|---|---|
| `kinfolk-warm`, `editorial-magazine` | `--shadow-soft` (warm-tinted) |
| `swiss-minimal`, `dashboard-dense` | `--shadow-soft` (very subtle) or none |
| `soft-brutalism`, `raw-brutalism` | `--shadow-brut` (no blur, hard offset) |
| `cyberpunk-neon`, `vaporwave` | `--shadow-glow` |
| `art-deco`, `luxury` | `--shadow-long` |
| `terminal-cli` | none |
| `glassmorphism` | `--shadow-float` + backdrop-blur |
| `riso-print` | `--shadow-brut-color` (offset in accent color, no blur) |
| `japanese-ma` | none or `--shadow-soft` at 50% intensity |

---

## 3. Material textures (paper, fabric, concrete)

Beyond noise — full texture backgrounds for hero sections or featured cards.

### Recycled paper (kinfolk, organic)
```css
.paper {
  background-color: #F4EFE6;
  background-image:
    radial-gradient(at 20% 30%, rgba(180,150,110,0.04) 0, transparent 40%),
    radial-gradient(at 80% 70%, rgba(140,100,70,0.05) 0, transparent 40%),
    url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='0.9'/><feColorMatrix values='0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 0.5 0'/></filter><rect width='100%' height='100%' filter='url(%23n)' opacity='0.4'/></svg>");
  background-blend-mode: multiply;
}
```

### Linen / fabric
```css
.linen {
  background-color: #E8E2D5;
  background-image:
    repeating-linear-gradient(45deg, rgba(0,0,0,0.02) 0 1px, transparent 1px 3px),
    repeating-linear-gradient(-45deg, rgba(0,0,0,0.02) 0 1px, transparent 1px 3px);
}
```

### Blueprint grid (architecture, dev-tools, fintech)
```css
.blueprint {
  background-color: #0E2A47;
  background-image:
    linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 24px 24px;
}
```

### Dot matrix (techy, retro)
```css
.dotgrid {
  background-color: var(--bg);
  background-image: radial-gradient(circle, var(--ink) 0.7px, transparent 0.7px);
  background-size: 12px 12px;
  opacity: 0.95;
}
```

### Concrete / stone (brutalism)
```css
.concrete {
  background:
    radial-gradient(at 30% 20%, #D9D5CF 0%, transparent 50%),
    radial-gradient(at 70% 80%, #C7C2BB 0%, transparent 50%),
    #CFCAC3;
}
.concrete::before {
  content: "";
  position: absolute; inset: 0;
  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='400'><filter id='n'><feTurbulence baseFrequency='0.65' numOctaves='3'/></filter><rect width='100%' height='100%' filter='url(%23n)' opacity='0.35'/></svg>");
  mix-blend-mode: multiply;
  pointer-events: none;
}
```

---

## 4. Glassmorphism done right (when DNA allows it)

Default glass = blurred white with low opacity. Looks cheap.

### Premium glass
```css
.glass {
  background: linear-gradient(135deg,
    rgba(255, 255, 255, 0.10) 0%,
    rgba(255, 255, 255, 0.04) 100%
  );
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.18);
  /* layered shadow gives depth so glass doesn't look pasted on */
  box-shadow:
    0 1px 0 rgba(255, 255, 255, 0.18) inset,
    0 8px 32px rgba(0, 0, 0, 0.12);
}
```

### Rules
- Only use glass when DNA system is `glassmorphism`, `cyberpunk-neon`, `sci-fi-spatial`, or `luxury`.
- Always add `saturate(180%)` for that "premium" iOS look.
- Always add a top inner border highlight (`0 1px 0 rgba(255,255,255,0.18) inset`).
- Background behind glass MUST have content (a photo, a gradient blob) — glass over solid color is pointless.

---

## 5. Highlight + Bevel (subtle 3D, not skeuomorph)

For buttons that should feel "raised" without being skeuomorphic:
```css
.btn-raised {
  background: var(--bg);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.5),   /* top highlight */
    inset 0 -1px 0 rgba(0, 0, 0, 0.05),        /* bottom shadow */
    0 1px 2px rgba(0, 0, 0, 0.05),             /* drop shadow */
    0 4px 8px rgba(0, 0, 0, 0.04);
}
.btn-raised:active {
  box-shadow:
    inset 0 1px 2px rgba(0, 0, 0, 0.08),       /* pressed in */
    inset 0 0 0 1px rgba(0, 0, 0, 0.04);
}
```

---

## 6. Niche-specific texture patterns

### `terminal-cli` / `cyberpunk-neon` — scanlines
```css
.scanlines::before {
  content: "";
  position: absolute; inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(
    0deg,
    transparent 0,
    transparent 2px,
    rgba(0, 0, 0, 0.06) 2px,
    rgba(0, 0, 0, 0.06) 3px
  );
  z-index: 1;
}
```

### `riso-print` — halftone dots
```css
.halftone {
  background-image: radial-gradient(circle, var(--accent) 1.2px, transparent 1.2px);
  background-size: 6px 6px;
  mix-blend-mode: multiply;
  opacity: 0.4;
}
```

### `editorial-magazine` — column rule
```css
.editorial-cols { column-count: 2; column-gap: 3rem; column-rule: 1px solid var(--ink); }
```

### `art-deco` — geometric pattern
```css
.deco {
  background:
    repeating-linear-gradient(135deg, var(--accent) 0 1px, transparent 1px 12px),
    repeating-linear-gradient(45deg, var(--accent) 0 1px, transparent 1px 12px);
  opacity: 0.08;
}
```

---

## 7. Texture audit checklist

```
☐ Page has a noise overlay (3-10% opacity)
☐ Noise opacity matches DNA system (table §1)
☐ Cards use layered shadows, NOT shadow-xl
☐ Shadow color is warm-tinted if DNA bg is warm
☐ Modals use --shadow-float (4 layers)
☐ Hero or feature section has a real material texture (paper/linen/blueprint/dotgrid)
☐ NO glassmorphism unless DNA system explicitly allows
☐ If glass IS used: saturate(180%) + inner top highlight + content behind
☐ No box-shadow values copied from Tailwind defaults (shadow-lg/xl/2xl)
☐ Buttons have asymmetric press shadows (compress on :active)
```

## 8. Combos that always look professional

1. **Warm paper bg + soft warm-tinted shadow + subtle fractal noise + rotated polaroid card** = editorial / kinfolk.
2. **Solid bg + brutalist offset shadow (no blur) + paper noise + bold display type** = soft-brutalism.
3. **Dark bg + glow shadow + scanline overlay + monospace** = cyberpunk-terminal.
4. **Off-white bg + studio shadow (4-layer) + clean linen texture + serif headlines** = premium product.
5. **Cream bg + halftone overlay + brutalist accent shadow + display sans** = riso-print zine.
