# Accessibility Humanized

> AI fails accessibility constantly. Default Tailwind colors fail contrast. Default focus rings get removed. Default motion has no escape hatch.
> This file gives you the patterns to ship accessible AND beautiful.

---

## Core principle
**Accessibility is not the opposite of personality.** A site can be brutal AND screen-reader friendly. Editorial AND high-contrast. Playful AND keyboard-navigable.

---

## 1. Focus States — Creative AND Visible

The default `outline: none` is the #1 a11y crime. The default browser focus ring is ugly. Both are wrong.

### ❌ Don't
```css
*:focus { outline: none; }
button:focus { outline: 2px solid blue; }  /* default ring */
```

### ✅ Do — match focus to your DNA system

#### `soft-brutalism` / `raw-brutalism`
```css
:focus-visible {
  outline: 3px solid var(--accent);
  outline-offset: 3px;
  box-shadow: 6px 6px 0 var(--ink);
}
```

#### `swiss-minimal` / `editorial-magazine`
```css
:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 4px;
  border-radius: 0;
}
```

#### `terminal-cli`
```css
:focus-visible {
  outline: none;
  background: var(--accent);
  color: var(--bg);
  /* "selected" terminal feel */
}
:focus-visible::before { content: "▶ "; }
```

#### `kinfolk-warm` / `organic-eco`
```css
:focus-visible {
  outline: 2px dashed var(--accent);
  outline-offset: 5px;
}
```

#### `cyberpunk-neon`
```css
:focus-visible {
  outline: 1px solid var(--accent);
  box-shadow: 0 0 0 3px var(--bg), 0 0 0 5px var(--accent),
              0 0 12px var(--accent);
}
```

### Rules
- Always use `:focus-visible`, never `:focus` (avoids ring on mouse click).
- Minimum 3:1 contrast against adjacent colors.
- Minimum 2px width.
- Visible in both light and dark sections.
- Test with keyboard only (Tab, Shift+Tab, Enter, Space).

---

## 2. Real Color Contrast (not assumed contrast)

### The trap
AI loves these palettes:
- Light gray text `text-gray-400` on white → contrast 2.8:1 → ❌ FAILS WCAG AA.
- Mute pastel button on cream → often 2.1:1 → ❌ FAILS.

### The fix
Test EVERY foreground/background pair. Minimum:
- **WCAG AA**: 4.5:1 for body, 3:1 for large text (≥18pt or ≥14pt bold).
- **WCAG AAA**: 7:1 for body, 4.5:1 for large text.
- Healthcare/legal/nonprofit: aim for AAA.

### Tools
```bash
# Test a pair manually
# https://webaim.org/resources/contrastchecker/

# Or in code:
# pnpm dlx @adobe/leonardo-contrast-colors
```

### DNA-safe combos (pre-validated AA+)
| Background | Body text | Ratio |
|---|---|---|
| `#F4EFE6` warm-paper | `#1A1A1A` | 14.8:1 ✅ AAA |
| `#FFF8E7` riso bg | `#111111` | 17.6:1 ✅ AAA |
| `#0A0E14` midnight | `#E6E1CF` | 13.2:1 ✅ AAA |
| `#ECECEA` cold-studio | `#0B0B0B` | 18.1:1 ✅ AAA |
| `#1F2421` blackboard | `#F2F1E8` | 15.4:1 ✅ AAA |

### Watch out
- **Accent on bg.** Often fails. `#FF5C39` on `#F4EFE6` = 3.4:1 → OK only for large text or non-text decoration. NEVER for body copy.
- **Mute text.** `#8A8278` mute on `#F4EFE6` = 3.6:1 → only for large text.

---

## 2.5 Creative High-Contrast / Dark Modes (NOT just black)

A "dark mode" that is `#000000` background with `#FFFFFF` text is the AI default and the laziest option. It also creates harsh contrast that hurts at night. Real high-contrast modes can be **deep navy, forest green, oxblood, midnight indigo** — all WCAG-AAA capable while keeping personality.

### Pre-validated dark backgrounds (≥7:1 with off-white #E6E1CF)
| Hex | Mood | DNA fit | Contrast vs #E6E1CF |
|---|---|---|---|
| `#0E1A24` | midnight navy | fintech, swiss, dev-tools | 14.1:1 ✅ AAA |
| `#1A1F1B` | deep forest | wellness, organic, eco | 13.8:1 ✅ AAA |
| `#1B1414` | warm cocoa | kinfolk, coffee, food | 14.2:1 ✅ AAA |
| `#0F0F1E` | dusk indigo | sci-fi, cyberpunk, gaming | 16.0:1 ✅ AAA |
| `#1F1310` | oxblood / wine | art-deco, luxury, editorial | 14.6:1 ✅ AAA |
| `#101A1A` | abyssal teal | ocean, travel, retreat | 15.0:1 ✅ AAA |
| `#0B1119` | space black | space, astronomy, premium | 16.5:1 ✅ AAA |
| `#1A1612` | smoked oak | architecture, craft | 14.0:1 ✅ AAA |

### Implementation pattern
```css
:root {
  color-scheme: light dark;
  /* light mode tokens */
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-bg:     #0E1A24;       /* not #000! */
    --color-ink:    #E6E1CF;       /* warm off-white */
    --color-mute:   #8E8B7E;
    --color-accent: #FF7A5C;       /* slightly warmer in dark */
    --noise-opacity: 0.04;          /* less noise to avoid banding */
  }
}

[data-theme="dark"] { /* manual toggle override */
  --color-bg: #0E1A24;
  /* … */
}
```

### Rules for creative dark modes
- Never `#000000` bg with `#FFFFFF` text — too harsh, causes "halation" on OLED.
- Body text: warm off-white (`#E6E1CF`, `#EFE9DC`, `#F2F0E6`) instead of pure white.
- Accent: shift slightly warmer in dark mode (orange → coral, blue → teal).
- Reduce noise overlay opacity by ~30% — dark backgrounds amplify grain.
- Reduce shadow intensity — darker bg means lower contrast for shadow visibility.
- Test on OLED (iPhone) AND IPS (most laptops). They render dark very differently.

### Manual theme toggle UX
```html
<button
  type="button"
  aria-label="Cambiar tema"
  data-theme-toggle
  class="btn"
>
  <span data-show="light">🌙</span>
  <span data-show="dark">☀️</span>
</button>
```
```js
const root = document.documentElement;
const stored = localStorage.getItem("theme");
if (stored) root.setAttribute("data-theme", stored);

document.querySelector("[data-theme-toggle]").addEventListener("click", () => {
  const next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
  root.setAttribute("data-theme", next);
  localStorage.setItem("theme", next);
});
```
- Always persist in `localStorage`.
- Always respect `prefers-color-scheme` as the initial value when no stored preference.
- Toggle should NOT cause a flash of wrong theme on load — set `data-theme` synchronously before paint.

---

## 3. Reduced Motion — Mandatory

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

### Beyond the snippet
- Marquees: stop entirely under reduced-motion.
- Auto-playing video: pause and show poster.
- Parallax: disable.
- Letter-by-letter reveals: show full text immediately.

```jsx
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

useEffect(() => {
  if (prefersReducedMotion) {
    videoRef.current?.pause();
  }
}, []);
```

---

## 4. Keyboard Navigation

### Required
- All interactive elements reachable with Tab.
- Skip link as first focusable element:
```html
<a href="#main" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:px-4 focus:py-2 focus:bg-ink focus:text-paper">
  Saltar al contenido
</a>
```
- Focus order matches visual order (don't break with `tabindex`).
- Modals trap focus and return it to trigger on close.
- ESC closes modals/menus.

### Test
Unplug your mouse. Navigate the entire site. Note every spot where you got stuck.

---

## 5. Screen Reader Friendly

### Semantic HTML wins
```html
<!-- ❌ -->
<div class="button" onclick="...">Comprar</div>

<!-- ✅ -->
<button type="button" onclick="...">Comprar</button>
```

### Decorative vs informative images
```html
<!-- Decorative: signature element, ornament -->
<svg aria-hidden="true">…</svg>
<img src="grain.svg" alt="" role="presentation">

<!-- Informative -->
<img src="founder.jpg" alt="Edwar trabajando en su escritorio en Medellín, marzo 2026">
```

### Hand-drawn icons
```html
<button>
  <svg aria-hidden="true">…</svg>
  <span class="sr-only">Cerrar menú</span>
  Menú
</button>
```

### Headings hierarchy
- One `<h1>` per page.
- Don't skip levels (`h1` → `h3` is wrong).
- Headings reflect outline, not visual size (use CSS for size).

### Live regions for dynamic content
```html
<div aria-live="polite" aria-atomic="true">
  Suscritos: <span id="count">237</span>
</div>
```

---

## 6. Color Is Never Alone

```html
<!-- ❌ Status communicated only by color -->
<span class="text-red-600">Falló</span>

<!-- ✅ Color + icon + text -->
<span class="text-red-700 inline-flex items-center gap-2">
  <svg aria-hidden="true">⚠</svg> Falló — reintenta en 30s
</span>
```

For required form fields:
```html
<label>
  Email <span aria-label="requerido">*</span>
</label>
<input required aria-required="true" type="email">
```

---

## 7. Forms Done Right

```html
<label for="email" class="block text-sm font-medium">
  Tu email <span class="text-accent" aria-label="requerido">*</span>
</label>
<input
  id="email"
  type="email"
  required
  autocomplete="email"
  inputmode="email"
  aria-describedby="email-help email-error"
  class="border-2 border-ink px-4 py-3 focus-visible:outline-2 focus-visible:outline-accent focus-visible:outline-offset-2"
>
<p id="email-help" class="text-sm text-mute">Para mandarte la confirmación.</p>
<p id="email-error" role="alert" class="hidden text-sm text-red-700"></p>
```

### Rules
- `<label>` always present. `placeholder` is NOT a label.
- `autocomplete` always set (email, name, current-password, etc).
- `inputmode` set on mobile (email, numeric, tel, decimal).
- Errors: `role="alert"` and `aria-describedby` on input.
- Don't disable submit button — show error after click instead.

---

## 8. Touch Targets (also a11y)

- Minimum 44×44 px hit area (Apple HIG, WCAG 2.5.5).
- 8px minimum spacing between adjacent targets.
- Test with thumb on real phone, not devtools.

---

## 9. Per-Niche A11y Priorities

| Niche | Priority |
|---|---|
| `healthcare` | AAA contrast. Plain language ≤grade 7. Multi-language. |
| `legal` / `law-firm` | AAA contrast. Long-form readable. Skip nav. |
| `nonprofit` | AAA. Plain language. No autoplay media. |
| `edtech` | AA min, prefer AAA. Caption all video. Math in MathML. |
| `fintech` | AA. Numerical clarity (no decorative typography on amounts). |
| `e-commerce` | AA. Real `<button>`s for cart actions. Price + currency for screen readers. |
| `marketplace` | AA. Filter forms with proper labels. |
| Everyone else | AA minimum. |

---

## 10. Quick Test Checklist

```
☐ Tab through entire page — focus visible always
☐ Focus order matches visual order
☐ ESC closes modals
☐ Skip link present and works
☐ Body text contrast ≥ 4.5:1
☐ Large text contrast ≥ 3:1
☐ All <img> have alt or alt=""
☐ All <button> are real <button>
☐ All <form> inputs have <label>
☐ prefers-reduced-motion respected
☐ No color-only state
☐ Page works at 200% zoom
☐ Page works with images disabled
☐ Lighthouse a11y score ≥ 95
☐ axe DevTools: 0 violations
```

## Tools
- **axe DevTools** (browser extension)
- **Lighthouse** (Chrome devtools)
- **WAVE** (wave.webaim.org)
- **Headers** (cmd+opt+i → Accessibility tree)
- Real screen reader: **VoiceOver** (cmd+F5 on macOS), **NVDA** (Windows free)
