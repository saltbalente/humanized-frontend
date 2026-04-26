# Motion Physics — animations with physical intent

> Default `transition: all 200ms ease-in-out` is the AI-tell of motion design.
> Real-feeling motion mimics physical materials: weight, anticipation, follow-through, asymmetric easing.

This file gives you ready-to-paste **Framer Motion**, **GSAP**, and **plain CSS** patterns that follow the 12 principles of animation, adapted to web UI.

---

## Core principles

1. **Anticipation > arrival.** UI reacts *before* the click commits (hover spring, magnetic pull, slight lift).
2. **Asymmetric easing.** Real objects accelerate fast, decelerate slowly. `easeOutExpo` ≫ `easeInOut`.
3. **Mass implies motion.** A heavy card moves slower than a light tooltip. Use `mass`, `damping`, `stiffness`.
4. **Staggered, not synchronized.** UI elements enter in cascade, irregular delays (8ms, 23ms, 31ms — not 100/200/300).
5. **Squash and stretch (subtle).** Buttons compress 1px on press. Modals scale from 0.96 → 1.
6. **Follow-through.** When animation "ends", let it overshoot slightly (spring) before settling.
7. **Always respect `prefers-reduced-motion`.**

---

## 1. Curated easing library (pick by tone, never use defaults)

| Easing token | cubic-bezier | Feels like | DNA fit |
|---|---|---|---|
| `--ease-spring` | `0.34, 1.56, 0.64, 1` | bouncy ball | playful, indie, kids |
| `--ease-soft` | `0.22, 1, 0.36, 1` | warm decel | kinfolk, organic, wellness |
| `--ease-snap` | `0.4, 0, 0.2, 1` | crisp Material | technical, swiss |
| `--ease-organic` | `0.65, 0, 0.35, 1` | breathing | meditation, editorial |
| `--ease-anticipate` | `0.68, -0.55, 0.27, 1.55` | overshoot | brutalism, manifesto |
| `--ease-quick` | `0.4, 0, 0.6, 1` | fast in/out | fintech, dashboards |
| `--ease-magnetic` | `0.16, 1, 0.3, 1` | pulled | premium, editorial |
| `--ease-thud` | `0.83, 0, 0.17, 1` | heavy weight | brutalism, industrial |

```css
:root {
  --ease-spring:     cubic-bezier(0.34, 1.56, 0.64, 1);
  --ease-soft:       cubic-bezier(0.22, 1, 0.36, 1);
  --ease-snap:       cubic-bezier(0.4, 0, 0.2, 1);
  --ease-organic:    cubic-bezier(0.65, 0, 0.35, 1);
  --ease-anticipate: cubic-bezier(0.68, -0.55, 0.27, 1.55);
  --ease-magnetic:   cubic-bezier(0.16, 1, 0.3, 1);
  --ease-thud:       cubic-bezier(0.83, 0, 0.17, 1);

  --dur-instant: 80ms;
  --dur-quick:   180ms;
  --dur-base:    240ms;
  --dur-slow:    420ms;
  --dur-cinema:  720ms;
}
```

Pick **one** primary easing per project (matches DNA tone). Use `--ease-snap` only for utility transitions (hover, focus).

---

## 2. Anticipatory hover (the "press is coming" feeling)

### Plain CSS
```css
.btn {
  transition:
    transform var(--dur-quick) var(--ease-spring),
    box-shadow var(--dur-quick) var(--ease-soft),
    background-color var(--dur-quick) var(--ease-snap);
  will-change: transform;
}
.btn:hover {
  transform: translateY(-2px) scale(1.02);
  box-shadow: 6px 8px 0 var(--ink);  /* shadow grows */
}
.btn:active {
  transform: translateY(1px) scale(0.99);
  box-shadow: 1px 1px 0 var(--ink);  /* shadow compresses */
  transition-duration: var(--dur-instant);
}
```
The asymmetry (200ms hover, 80ms active) makes the press feel responsive while the lift feels alive.

### Framer Motion
```tsx
import { motion } from "framer-motion";

<motion.button
  whileHover={{ y: -2, scale: 1.02, transition: { type: "spring", stiffness: 400, damping: 17 } }}
  whileTap={{ y: 1, scale: 0.99, transition: { duration: 0.08 } }}
  className="btn"
>
  Comprar
</motion.button>
```

### GSAP
```js
const btn = document.querySelector(".btn");
btn.addEventListener("pointerenter", () => {
  gsap.to(btn, { y: -2, scale: 1.02, duration: 0.18, ease: "back.out(1.7)" });
});
btn.addEventListener("pointerleave", () => {
  gsap.to(btn, { y: 0, scale: 1, duration: 0.24, ease: "power2.out" });
});
btn.addEventListener("pointerdown", () => {
  gsap.to(btn, { y: 1, scale: 0.99, duration: 0.08, ease: "power2.in" });
});
```

---

## 3. Magnetic CTA (cursor pulls the button slightly)

```jsx
import { useRef } from "react";
import { motion, useMotionValue, useSpring } from "framer-motion";

function MagneticButton({ children }) {
  const ref = useRef(null);
  const x = useMotionValue(0);
  const y = useMotionValue(0);
  const sx = useSpring(x, { stiffness: 200, damping: 20, mass: 0.5 });
  const sy = useSpring(y, { stiffness: 200, damping: 20, mass: 0.5 });

  const onMove = (e) => {
    const r = ref.current.getBoundingClientRect();
    const dx = e.clientX - (r.left + r.width / 2);
    const dy = e.clientY - (r.top + r.height / 2);
    x.set(dx * 0.25);  // 25% follow strength
    y.set(dy * 0.25);
  };

  return (
    <motion.button
      ref={ref}
      onMouseMove={onMove}
      onMouseLeave={() => { x.set(0); y.set(0); }}
      style={{ x: sx, y: sy }}
      className="btn"
    >{children}</motion.button>
  );
}
```
Use sparingly — ONE magnetic CTA per page max.

---

## 4. Stagger entrances (irregular)

### ❌ Linear (AI default)
```js
items.forEach((el, i) => {
  el.style.animationDelay = `${i * 100}ms`;  // 0, 100, 200, 300… metronomic
});
```

### ✅ Irregular cascade
```js
const irregular = [80, 230, 310, 480, 590, 720];  // hand-picked, irregular
items.forEach((el, i) => {
  el.style.animationDelay = `${irregular[i % irregular.length]}ms`;
});
```

### Framer Motion variant
```tsx
const container = {
  hidden: {},
  show: {
    transition: {
      staggerChildren: 0.07,
      delayChildren: 0.1,
      staggerDirection: 1,
      // pseudo-random stagger via custom delay below
    },
  },
};

const item = {
  hidden: { opacity: 0, y: 12 },
  show: (i) => ({
    opacity: 1, y: 0,
    transition: {
      delay: [0.08, 0.23, 0.31, 0.48][i % 4],
      duration: 0.42,
      ease: [0.22, 1, 0.36, 1],  // soft
    },
  }),
};

<motion.ul variants={container} initial="hidden" animate="show">
  {arr.map((x, i) => (
    <motion.li key={i} custom={i} variants={item}>{x}</motion.li>
  ))}
</motion.ul>
```

### GSAP timeline (irregular)
```js
gsap.from(".feature-card", {
  opacity: 0,
  y: 24,
  duration: 0.5,
  ease: "expo.out",
  stagger: { amount: 0.6, from: "start", ease: "power2.inOut" },  // amount instead of each
});
```

---

## 5. Scroll-triggered reveals (with mass)

### Framer Motion + viewport
```tsx
<motion.section
  initial={{ opacity: 0, y: 40 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true, margin: "-15% 0px" }}
  transition={{ duration: 0.7, ease: [0.22, 1, 0.36, 1] }}
>
  …
</motion.section>
```
- Always `once: true` (don't re-animate on scroll back).
- `margin: "-15%"` triggers BEFORE element fully enters viewport (anticipatory).

### GSAP ScrollTrigger
```js
gsap.utils.toArray("[data-reveal]").forEach((el) => {
  gsap.from(el, {
    opacity: 0,
    y: 32,
    duration: 0.8,
    ease: "expo.out",
    scrollTrigger: {
      trigger: el,
      start: "top 85%",
      toggleActions: "play none none none",
    },
  });
});
```

---

## 6. Modal / dialog physics

```tsx
<motion.div
  initial={{ opacity: 0, scale: 0.96, y: 8 }}
  animate={{ opacity: 1, scale: 1, y: 0 }}
  exit={{ opacity: 0, scale: 0.98, y: 4 }}
  transition={{
    type: "spring",
    stiffness: 380,
    damping: 30,
    mass: 0.8,
  }}
>
  <Dialog />
</motion.div>
```
- Scale from 0.96 (not 0.5 — that's old Material).
- Spring with `mass: 0.8` (light dialog) or `mass: 1.4` (heavy modal).

---

## 7. Page transitions

### Next.js App Router + Framer
```tsx
"use client";
import { motion } from "framer-motion";

export default function Template({ children }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 12 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.45, ease: [0.22, 1, 0.36, 1] }}
    >
      {children}
    </motion.div>
  );
}
```

### View Transitions API (browser native)
```css
::view-transition-old(root) { animation: fade-out 280ms var(--ease-snap); }
::view-transition-new(root) { animation: fade-in 360ms var(--ease-soft); }
```
```js
document.startViewTransition(() => {
  // nav code
});
```

---

## 8. Marquee / ticker (with reduced-motion stop)

```css
@keyframes marquee { from { transform: translateX(0); } to { transform: translateX(-50%); } }
.ticker { animation: marquee 35s linear infinite; }
.ticker:hover { animation-play-state: paused; }

@media (prefers-reduced-motion: reduce) {
  .ticker { animation: none; transform: none; }
}
```

---

## 9. Mandatory: respect prefers-reduced-motion EVERYWHERE

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

In React:
```tsx
import { useReducedMotion } from "framer-motion";
const prefersReduced = useReducedMotion();
<motion.div animate={{ y: prefersReduced ? 0 : -10 }} />;
```

---

## 10. Per-DNA-system motion fingerprints

| DNA system | Easing | Duration | Notes |
|---|---|---|---|
| `swiss-minimal` | `--ease-snap` | quick (180ms) | minimal stagger, no bounce |
| `soft-brutalism` | `--ease-thud` + `--ease-spring` | base/quick | hard transforms, stepped not smooth |
| `kinfolk-warm` | `--ease-organic` | slow (420ms+) | breathing-like, low motion |
| `terminal-cli` | `linear` + step() | instant | NO smooth transitions, blink/cursor only |
| `editorial-magazine` | `--ease-magnetic` | base | scroll reveals, parallax-light |
| `cyberpunk-neon` | `--ease-anticipate` | quick | glitch, flicker, rapid |
| `art-deco` | `--ease-soft` | slow | symmetric reveals, fade-in golden |
| `riso-print` | none / step() | instant | jumpy, frame-by-frame, like print run |
| `y2k-revival` | `--ease-spring` | base | bouncy, springy, playful |
| `japanese-ma` | `--ease-organic` | very slow (720ms) | space-aware, generous timing |
| `dashboard-dense` | `--ease-snap` | instant | utility only, no cinema |
| `vaporwave` | `--ease-soft` | slow | dreamy, no bounce |

---

## 11. Animation testing checklist

```
☐ No transition uses default ease-in-out
☐ Easing matches DNA tone (table above)
☐ Stagger delays are irregular (not 100/200/300)
☐ Hover state has anticipatory motion (lift/scale/shadow)
☐ Active state is faster than hover (compresses on press)
☐ Modal scales from ≥0.96 (not 0.5)
☐ prefers-reduced-motion handled (in CSS AND in JS hooks)
☐ Marquees pause on hover and stop on reduced-motion
☐ No more than 1 magnetic CTA per page
☐ Page-transition or scroll-reveal is present (not static)
☐ will-change used only on actively animating elements (then removed)
```

## 12. Tools

- **Framer Motion** (React/Next): `pnpm add framer-motion`
- **GSAP** (vanilla, complex timelines): `pnpm add gsap`
- **Motion One** (lightweight, web-animations-API): `pnpm add motion`
- **Lenis** (smooth scroll, mass-aware): `pnpm add @studio-freight/lenis`
- **easings.net** — visualize all named easings
- **cubic-bezier.com** — design custom curves
