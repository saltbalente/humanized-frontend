# Design Principles — Anti-AI Visual System

The goal: **soft brutalism + controlled chaos + tactile warmth.** Premium, opinionated, hand-made.

## 1. Color

| ❌ AI look                              | ✅ Humanized                                      |
|----------------------------------------|--------------------------------------------------|
| Purple→pink→blue gradients             | One solid background + one unexpected accent     |
| `bg-gradient-to-br from-purple-500`    | `bg-[#F4EFE6]` (warm off-white) + `#FF5C39` accent |
| Neon saturated palettes                 | Earthy, muted, slightly desaturated              |
| 5+ colors fighting                      | 2 base + 1 accent + 1 ink (black/charcoal)       |

**Recommended starter palettes:**

- *Warm paper*: `#F4EFE6` bg · `#1A1A1A` ink · `#FF5C39` accent · `#2E5E4E` deep
- *Cold studio*: `#ECECEA` bg · `#0B0B0B` ink · `#3D5AFE` accent · `#C9A227` mustard
- *Risograph*: `#FFF8E7` bg · `#111` ink · `#E63946` red · `#1D3557` blue

Rule: pick ONE accent and use it sparingly (CTAs, underlines, a single illustration).

## 2. Layout & Spacing

- **Break the grid intentionally.** Offset 1–2 elements by 4–12px. Rotate a card -1.5°.
- **Asymmetric heros.** Headline left, image overflowing right edge of viewport.
- **Irregular vertical rhythm.** Don't reuse `py-24` everywhere. Mix `py-16 / py-32 / py-20`.
- **Negative space as a design element.** Big empty areas > cramming features.
- **Off-canvas bleed.** Let images, text or shapes touch/exit the viewport edge.

## 3. Typography

- **Mix two voices**: a serif/display with character + a clean sans for body.
  - Try: *Fraunces + Inter*, *Instrument Serif + Geist*, *PP Editorial New + IBM Plex Sans*, *Migra + Söhne*.
- **Oversize the hero.** `clamp(3.5rem, 9vw, 8rem)` with `leading-[0.9]`.
- **Use actual punctuation.** Curly quotes ("" '') feel human. Em dashes (—) feel AI — use commas, parentheses, or short sentences.
- **Underline links** like in 1998. It's back and feels human.
- **Allow widows/orphans** on purpose for poetic line breaks.

## 4. Surfaces & Effects

| ❌ Avoid                                | ✅ Prefer                                         |
|----------------------------------------|--------------------------------------------------|
| `backdrop-blur` glassmorphism          | Solid blocks with hard 1–2px borders             |
| `shadow-xl rounded-2xl` combo          | `border border-black` or `shadow-[4px_4px_0_#000]` (offset shadow) |
| Soft Material elevations               | Flat layers, no elevation OR brutal hard shadows |
| Glossy highlights, inner shadows       | Paper grain texture, halftone, subtle noise SVG  |
| `rounded-3xl` everywhere               | `rounded-none` or `rounded-[2px]`; mix radii     |

Add a **noise texture** overlay (5–8% opacity SVG) on backgrounds — instantly less digital.

## 5. Iconography & Imagery

- **Kill Heroicons / Lucide defaults.** Replace with: hand-drawn SVGs, Phosphor Duotone, custom emoji-as-glyph (`▲ ◆ ✦ →`), or a single illustrated set (e.g. by an artist on Iconfinder).
- **Real photos > stock.** Founder, workspace, product in messy real context. Slight grain. Avoid flawless 4K renders.
- **Sketches and arrows.** A scribbled circle around a CTA, a hand-drawn arrow connecting two ideas.
- **Avoid 3D blob shapes** and floating glossy cards (peak 2022 AI vibe).

## 6. Motion

- **Slow & physical.** Spring (stiffness 120, damping 14) > linear ease.
- **Micro-interactions with personality.** A button that wiggles -2°/+2° on hover. A cursor that drags a tiny label.
- **No parallax on every section.** Pick one moment.
- **Respect `prefers-reduced-motion`.**

## 7. Components — humanized recipes

### Button
```html
<button class="border-2 border-black bg-[#FF5C39] px-6 py-3 font-medium text-black
               shadow-[4px_4px_0_#000] transition-transform
               hover:translate-x-[-2px] hover:translate-y-[-2px]
               hover:shadow-[6px_6px_0_#000] active:translate-x-[2px] active:translate-y-[2px]
               active:shadow-[0_0_0_#000]">
  Empieza ahora →
</button>
```

### Card (no glossy)
```html
<article class="border-2 border-black bg-[#F4EFE6] p-6 -rotate-[0.6deg]
                hover:rotate-0 transition-transform">
  <h3 class="font-serif text-2xl">Título con carácter</h3>
  <p class="mt-2 text-[15px] leading-snug">Una idea breve, sin filler.</p>
</article>
```

### Hero
- Headline serif XXL, broken in 2 lines on purpose.
- One real photo bleeding to the right edge.
- A single accent-colored underline under one keyword.
- A tiny handwritten note with arrow pointing at the CTA.

## 8. Tendencias 2026 a abrazar

- **Soft brutalism** (brutalism + warm palette + serif).
- **Editorial / magazine layouts** (column grids, drop caps, pull quotes).
- **Anti-design intentional** (raw HTML feel, system fonts, no animations).
- **Warm SaaS** (cream backgrounds, mustard/terracotta accents).
- **Tactile / paper / risograph** textures.
- **Personal first-person hero copy.**

## 9. Tendencias a evitar (peak vibe-coded)

- Purple-pink gradient hero with floating 3D blob.
- Glassmorphism cards with `backdrop-blur-xl`.
- "Empower / Unleash / Seamless / Elevate" copy.
- Heroicons + Inter + `shadow-xl` + `rounded-2xl`.
- Perfectly centered everything.
- Stock photos of diverse people pointing at laptops.
- Emoji in every section title.
