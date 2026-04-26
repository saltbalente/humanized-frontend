# Mobile & Touch Feel

> "Responsive" is the floor. "Tactile" is the goal.
> Most AI-generated sites pass `min-width: 768px` queries and fail every other mobile heuristic.

---

## 0. Test on real devices, not devtools

- Chrome's mobile emulator lies about touch feedback, scroll feel, and rubber-banding.
- Open the site on your actual phone before declaring done.
- Test in landscape too (one in twenty users).
- Test with iOS AND Android Chrome — they differ on overscroll, viewport units, and font rendering.

---

## 1. The Viewport Meta (do this first)

```html
<meta name="viewport"
      content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#F4EFE6">  <!-- DNA bg color -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
```

### `viewport-fit=cover` + safe areas
On iPhone with notch, content can extend behind it. Use:
```css
.container {
  padding-left: max(1rem, env(safe-area-inset-left));
  padding-right: max(1rem, env(safe-area-inset-right));
  padding-bottom: max(1rem, env(safe-area-inset-bottom));
}
```

---

## 2. Touch Target Sizes

- **Minimum 44×44 px** (Apple HIG / WCAG 2.5.5).
- **Comfortable 48×48 px** (Material).
- **Spacing 8 px+** between adjacent targets.
- Apply to: buttons, links, icons, form inputs.

```css
button, a.btn, input[type="checkbox"] + label {
  min-height: 44px;
  min-width: 44px;
  /* invisible padding to hit minimum without bloating visible size */
  padding: 12px 16px;
}
```

### Test
- Hit each target with your thumb in motion (walking, on a bus). If you miss, it's too small.
- Test with adult male thumb (largest contact patch).

---

## 3. Typography for Mobile

### Body text
- **Minimum 16px** body. iOS auto-zooms inputs <16px; same applies to perceived readability.
- Line length: 45–75 characters per line.
```css
.prose { max-width: 65ch; }
```

### Hero headlines
Use clamp() for fluid:
```css
h1 { font-size: clamp(2.25rem, 7vw + 1rem, 6rem); line-height: 1; }
```

### Avoid
- Fonts that don't subset well on mobile (load WOFF2 with `font-display: swap`).
- Custom fonts >120KB total.
- `font-weight: 100` on retina mobile — disappears.

---

## 4. Tactile Feedback (the "feels nice" layer)

### Active states
Every button needs a visible `:active` state. NOT just `:hover`. Mobile has no hover.

```css
button {
  transition: transform 80ms ease-out, box-shadow 80ms ease-out;
}
button:active {
  transform: translateY(1px);
  box-shadow: 0 0 0 var(--ink);  /* compress brutalist shadow */
}
```

### Haptic feedback (where supported)
```js
function buzz() {
  if ('vibrate' in navigator) navigator.vibrate(10);  // 10ms tap
}
button.addEventListener('pointerdown', buzz);
```
- Use sparingly: form submit success, important toggle, cart add.
- Never on every tap.

### Disable text selection on UI controls
```css
button, .nav, .tab {
  -webkit-user-select: none;
  user-select: none;
  -webkit-touch-callout: none;  /* disable iOS press-and-hold menu */
}
```

### Disable double-tap zoom on buttons
```css
button { touch-action: manipulation; }
```
This removes iOS's 300ms tap delay.

---

## 5. Scroll Feel

### Smooth scroll (with reduced-motion respect)
```css
@media (prefers-reduced-motion: no-preference) {
  html { scroll-behavior: smooth; }
}
```

### Snap scroll (galleries, carousels)
```css
.gallery {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  scroll-padding: 1rem;
  -webkit-overflow-scrolling: touch;  /* iOS momentum */
}
.gallery > * {
  scroll-snap-align: start;
  flex: 0 0 90%;
}
```

### Hide scrollbar on horizontal galleries (visual only)
```css
.gallery::-webkit-scrollbar { display: none; }
.gallery { scrollbar-width: none; }
```

### Sticky headers
- Make it short. Tall sticky headers eat 30% of mobile viewport.
- Auto-hide on scroll down, show on scroll up:
```js
let lastY = 0;
addEventListener('scroll', () => {
  const y = scrollY;
  header.dataset.hidden = y > lastY && y > 80 ? 'true' : 'false';
  lastY = y;
});
```
```css
header[data-hidden="true"] { transform: translateY(-100%); }
header { transition: transform 200ms ease-out; }
```

---

## 6. Forms on Mobile

### Right keyboard for the right input
```html
<input type="email"     inputmode="email"    autocomplete="email">
<input type="tel"       inputmode="tel"      autocomplete="tel">
<input type="number"    inputmode="numeric"  autocomplete="off" pattern="[0-9]*">
<input type="text"      inputmode="decimal"  step="0.01">
<input type="search"    inputmode="search"   autocomplete="off">
<input type="url"       inputmode="url">
```

### Prevent iOS auto-zoom on focus
```css
input, select, textarea { font-size: 16px; }
```

### Big, finger-friendly form controls
```css
input, select, textarea {
  min-height: 48px;
  padding: 12px 16px;
  font-size: 16px;
}
```

### Submit button at the bottom, full width on mobile
```css
@media (max-width: 640px) {
  .submit { width: 100%; }
}
```

---

## 7. Images & Media

### Responsive images
```html
<img
  srcset="hero-640.jpg 640w, hero-1024.jpg 1024w, hero-1920.jpg 1920w"
  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 90vw, 80vw"
  src="hero-1024.jpg"
  alt="…"
  loading="lazy"
  decoding="async"
  width="1024" height="1280"
>
```
- Always set `width` and `height` to prevent layout shift (CLS).
- `loading="lazy"` on everything except above-the-fold.

### Video on mobile
- Don't autoplay with sound. Ever.
- For decorative video: `autoplay muted playsinline loop`.
- Provide `<video poster="…">` always.
- Pause when off-screen with IntersectionObserver.

---

## 8. Bottom Nav vs Top Nav

For app-like sites or thumb-first browsing:
```html
<nav class="fixed bottom-0 inset-x-0 border-t-2 border-ink bg-paper grid grid-cols-4 pb-[env(safe-area-inset-bottom)]">
  <a href="/"     class="py-3 text-center">Inicio</a>
  <a href="/work" class="py-3 text-center">Trabajo</a>
  <a href="/now"  class="py-3 text-center">Ahora</a>
  <a href="/me"   class="py-3 text-center">Yo</a>
</nav>
```
- Thumb zone (bottom third of screen) is most ergonomic.
- 4 items max in bottom nav.

---

## 9. Performance budget for mobile

| Metric | Target | Why |
|---|---|---|
| LCP | < 2.5s | Google ranking |
| INP | < 200ms | Tap responsiveness |
| CLS | < 0.1 | No jumpy layouts |
| JS payload | < 150KB gzipped | 3G/4G users |
| Total page | < 1MB initial | Latam/Africa real-world |

### Quick wins
- Convert PNG/JPG → WebP/AVIF.
- Subset Google Fonts (only the weights/glyphs used).
- `<script defer>` for non-critical JS.
- Remove unused Tailwind classes (`content` config).
- No third-party analytics blocker scripts above the fold.

---

## 10. The 5-Minute Mobile Audit

```
☐ Open on real iPhone Safari + real Android Chrome
☐ Hit every interactive element with thumb (no missed taps)
☐ Form keyboards correct (numeric for tel, email for email)
☐ No iOS zoom on input focus
☐ Sticky header doesn't cover content
☐ Bottom CTA reachable without thumb stretch
☐ Safe areas respected (no content under notch)
☐ Lighthouse mobile score ≥ 90 perf, ≥ 95 a11y
☐ Tap a button — does it feel responsive within 100ms?
☐ Scroll a gallery — does it have momentum and snap?
```

If all 10 pass, mobile feels tactile. If 7+ pass, you're better than 95% of sites.

---

## 11. Per-Niche Mobile Priorities

| Niche | Priority |
|---|---|
| `restaurant-food` / `barbershop` | One-tap call button at top of mobile, address with maps link, hours up front. |
| `e-commerce` | Add-to-cart sticky on product page, big touch images, swipeable gallery. |
| `fintech` / `legal` | Big numbers/amounts, monospace for IDs, copy-to-clipboard buttons. |
| `dev-tools` | Code blocks horizontally scrollable with momentum, copy button. |
| `news-media` / `publishing` | Reading mode, font-size toggle, save-for-later. |
| `dating-app` / `social` | Bottom nav, swipe gestures, pull-to-refresh. |
| `wellness` / `meditation` | Quiet UI, no flash, prefers-reduced-motion automatic. |
| `kids-toys` / `gaming` | Big tap targets (≥56px), sound on/off prominent. |
