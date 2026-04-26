# Anti-Vibe-Coded Checklist (pre-publish)

Run through every item. Each ❌ left = points off your "human score".

## Visual

- [ ] No purple→pink, blue→purple, or pink→orange gradients.
- [ ] No `backdrop-blur` glassmorphism cards.
- [ ] No `shadow-xl` + `rounded-2xl` combo on every card.
- [ ] At least one element intentionally off-grid (4–12px or rotated).
- [ ] Background is NOT pure white (`#FFFFFF`) — use warm off-white, cream, paper.
- [ ] One (and only one) accent color, used sparingly.
- [ ] Subtle noise/grain texture on at least one section.
- [ ] Mixed border-radii or no radii at all (kill the universal `rounded-2xl`).

## Typography

- [ ] Display/serif font with character (not Inter for headlines).
- [ ] Hero headline ≥ `clamp(3rem, 8vw, 7rem)` and `leading-[0.9–1]`.
- [ ] No em dashes (—) anywhere in copy.
- [ ] Curly quotes ("" '') instead of straight ones.
- [ ] At least one underlined link in the body (not just hover).

## Iconos / Imágenes

- [ ] Zero Heroicons / Lucide defaults left in production.
- [ ] At least one hand-drawn or custom SVG element.
- [ ] At least one real photo (founder, workspace, product in context). Not stock.
- [ ] No floating 3D blobs.
- [ ] Favicon is custom (not a letter on a gradient circle).

## Copy

- [ ] No banned words: *unleash, empower, seamless, elevate, transform your, leverage, robust, holistic, game-changer, revolutionary, cutting-edge, synergy*.
- [ ] First-person voice present somewhere ("yo", "soy", "construí").
- [ ] At least one anecdote or personal story.
- [ ] At least one strong opinion or "what we are NOT".
- [ ] CTAs are conversational, not "Get Started" / "Learn More".
- [ ] Testimonials have full name + city + real photo (or removed entirely).
- [ ] Sentence lengths vary (mix short and long).
- [ ] No emojis in section titles (max 2 emojis on the whole page, in body copy).

## Estructura & UX

- [ ] Layout breaks symmetry at least once.
- [ ] Negative space generous (sections breathe).
- [ ] Mobile tested on a real phone, not just devtools.
- [ ] One easter egg or inside joke for the target audience.
- [ ] Loading states, empty states and 404 have humanized microcopy.
- [ ] `prefers-reduced-motion` respected.
- [ ] Lighthouse accessibility ≥ 95.

## Personalidad

- [ ] If you cover the logo, can you still tell which brand this is? (If no → add more soul.)
- [ ] A non-technical friend says "esto se ve diferente" (positive).
- [ ] You'd be proud to print this and put it on your wall.

## Score

- 30+ ✅ → Ship it. Feels human.
- 20–29 ✅ → Decent, but still has AI smell. One more pass.
- < 20 ✅ → Vibe-coded. Restart from Phase 5.
