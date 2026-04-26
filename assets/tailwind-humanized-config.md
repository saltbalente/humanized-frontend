# Humanized Tailwind Tokens (drop-in)

Replace your default theme with these to instantly de-AI any Tailwind/shadcn project.

## `tailwind.config.ts`

```ts
import type { Config } from "tailwindcss";

export default {
  content: ["./src/**/*.{ts,tsx,html}"],
  theme: {
    extend: {
      colors: {
        paper:   "#F4EFE6",  // warm off-white
        ink:     "#1A1A1A",  // not pure black
        accent:  "#FF5C39",  // single accent — use sparingly
        deep:    "#2E5E4E",  // optional secondary
        mute:    "#8A8278",  // muted text
      },
      fontFamily: {
        display: ['"Fraunces"', '"Instrument Serif"', "ui-serif", "Georgia"],
        sans:    ['"Inter"', "ui-sans-serif", "system-ui"],
        hand:    ['"Caveat"', "ui-serif", "cursive"],
        mono:    ['"JetBrains Mono"', "ui-monospace"],
      },
      fontSize: {
        // oversized hero
        hero: ["clamp(3.5rem, 9vw, 8rem)", { lineHeight: "0.9", letterSpacing: "-0.03em" }],
      },
      borderRadius: {
        // mostly none, sometimes a tiny crisp 2px
        none: "0",
        xs:   "2px",
        sm:   "4px",
      },
      boxShadow: {
        // brutalist offset shadows, no blur
        brut:    "4px 4px 0 0 #1A1A1A",
        "brut-lg":"6px 6px 0 0 #1A1A1A",
        "brut-accent":"4px 4px 0 0 #FF5C39",
      },
      backgroundImage: {
        noise: "url('/textures/noise.svg')", // 5–8% opacity SVG noise
        paper: "url('/textures/paper.jpg')",
      },
      transitionTimingFunction: {
        spring: "cubic-bezier(0.34, 1.56, 0.64, 1)",
      },
    },
  },
} satisfies Config;
```

## `globals.css`

```css
@import "tailwindcss";

@layer base {
  html { background: theme('colors.paper'); color: theme('colors.ink'); }
  body { font-family: theme('fontFamily.sans'); font-feature-settings: "ss01", "cv11"; }
  h1, h2, h3 { font-family: theme('fontFamily.display'); letter-spacing: -0.02em; }
  a   { text-decoration: underline; text-underline-offset: 3px; text-decoration-thickness: 1.5px; }
  ::selection { background: theme('colors.accent'); color: white; }
}

/* subtle paper grain on body */
body::before {
  content: "";
  position: fixed; inset: 0;
  background-image: url("/textures/noise.svg");
  opacity: 0.06;
  mix-blend-mode: multiply;
  pointer-events: none;
  z-index: 9999;
}

@media (prefers-reduced-motion: reduce) {
  * { animation: none !important; transition: none !important; }
}
```

## shadcn/ui overrides (`components.json` style)

```ts
// components/ui/button.tsx — replace the default variants
const buttonVariants = cva(
  "inline-flex items-center justify-center font-medium transition-transform duration-150 ease-spring",
  {
    variants: {
      variant: {
        default: "border-2 border-ink bg-accent text-ink shadow-brut " +
                 "hover:-translate-x-0.5 hover:-translate-y-0.5 hover:shadow-brut-lg " +
                 "active:translate-x-0.5 active:translate-y-0.5 active:shadow-none",
        ghost:   "border-b-2 border-ink hover:bg-ink hover:text-paper rounded-none",
        link:    "underline underline-offset-4 decoration-2 hover:decoration-accent",
      },
      size: {
        default: "px-6 py-3 text-base",
        lg:      "px-8 py-4 text-lg",
        sm:      "px-4 py-2 text-sm",
      },
    },
  }
);
```

## Recommended Google Fonts import

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,800&family=Inter:wght@400;500;700&family=Caveat:wght@500&display=swap" rel="stylesheet">
```

## Noise SVG (`public/textures/noise.svg`)

```xml
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200">
  <filter id="n">
    <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" stitchTiles="stitch"/>
    <feColorMatrix values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 0.5 0"/>
  </filter>
  <rect width="100%" height="100%" filter="url(#n)"/>
</svg>
```
