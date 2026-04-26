# Design Systems Library (25)

Each system is a complete visual language. The DNA engine (`scripts/dna.sh`) picks ONE per project — apply it strictly, do not blend.

Quick index → click to jump:
`soft-brutalism` · `editorial-magazine` · `swiss-minimal` · `neo-memphis` · `y2k-revival` · `terminal-cli` · `japanese-ma` · `art-deco-modern` · `risograph-print` · `vaporwave-neo-pop` · `cyberpunk-neon` · `organic-eco` · `raw-brutalism` · `kinfolk-warm` · `sci-fi-spatial` · `retro-arcade` · `luxury-quiet` · `handmade-zine` · `anti-design-raw` · `neo-skeuomorphic` · `tactile-paper` · `constructivist` · `monochrome-noir` · `blueprint-technical` · `scandi-soft`

---

## soft-brutalism
Warm brutalism. Hard borders, offset shadows, but on cream backgrounds with serif headlines.
- **Borders:** 2px solid ink. **Shadows:** `4px 4px 0 ink` (no blur). **Radii:** mostly 0, occasional 2px.
- **Headlines:** big serif (Fraunces, Instrument Serif), `leading-[0.9]`.
- **Buttons:** brutalist offset, hover `-translate-x-0.5 -translate-y-0.5`.
- **Decoration:** one hand-drawn arrow. Real photos with grain.
- **Avoid:** glassmorphism, soft shadows, gradient backgrounds.

## editorial-magazine
A printed magazine pretending to be a website.
- **Layout:** 12-col grid with multi-column body, drop caps, pull quotes, small caps subheads.
- **Type:** serif everywhere. Italic for emphasis. Body justified. Hyphenation on.
- **Imagery:** full-bleed photos with caption + photographer credit in micro type.
- **Color:** restrained — mostly paper + ink + 1 accent.
- **Avoid:** cards, icons, motion (max: a slow scroll-driven section).

## swiss-minimal
Helvetica-style grid orthodoxy. Information first, ego nowhere.
- **Type:** geometric/neo-grotesque sans (Inter, Söhne, Helvetica Now, GT America).
- **Grid:** strict 12-col, generous gutters, baseline rhythm.
- **Color:** monochrome + 1 saturated accent (often red or yellow).
- **No decoration.** No icons (or hairline only). No shadows. No radii.
- **Headlines:** sentence case, tight tracking, short.

## neo-memphis
1980s Memphis Group revival: shapes, squiggles, primary pop.
- **Decoration:** confetti shapes (squiggles, dots, zigzags) sprinkled around hero.
- **Color:** 4–5 saturated primaries (red, blue, yellow, mint, hot pink).
- **Type:** chunky geometric sans (Archivo Black, Anton) + a wild display.
- **Shapes:** circles, triangles, arches as backgrounds.
- **Use for:** kids, creative agencies, food, music.

## y2k-revival
Late 90s / early 00s web aesthetic. Chrome, blobs, frutiger aero meets MSN.
- **Effects:** chrome text gradients, blurry star shapes, glossy buttons (yes here it's allowed).
- **Type:** Eurostile/Bank Gothic vibes; or pixel display (Departure Mono).
- **Color:** baby blue + white + neon accents. Or all chrome.
- **Decoration:** sparkles ✨, hearts, butterflies — earnest, not ironic.
- **Use for:** music, fashion, art, gaming.

## terminal-cli
The site IS a terminal. ASCII art, mono everything, prompts and cursors.
- **Type:** mono only (Berkeley Mono, JetBrains Mono, Departure Mono).
- **Color:** single dark bg + green/amber/white text + 1 accent.
- **Layout:** single column, fixed-width characters, ASCII dividers.
- **Interactions:** typed-out reveal animations. Real `_` cursor blink.
- **Use for:** dev tools, hacker brands, AI agents, indie hackers.

## japanese-ma
Ma (間) = negative space. Restraint and breath.
- **Layout:** 70%+ whitespace. One thing per screen.
- **Type:** very small body (12–14px), generous tracking.
- **Color:** ivory + sumi black + one zen accent (vermilion #9B2D20 or indigo).
- **Imagery:** asymmetric placement, lots of crop, minimal subject matter.
- **Motion:** slow fades only.

## art-deco-modern
Geometric symmetry, gold accents, vertical type.
- **Decoration:** hairline frames, sunburst patterns, stepped pyramids.
- **Type:** display geometric (Italiana, Bodoni) + clean sans body.
- **Color:** ink + cream + gold/brass + one jewel tone (emerald, sapphire).
- **Layout:** strong vertical axis, centered hero, framed sections.
- **Use for:** luxury, hospitality, perfume, theater.

## risograph-print
Printed on a riso machine: limited inks, misregistration, halftone.
- **Color:** 2–3 ink palette (e.g. fluorescent pink + blue + black). Overlay = third color.
- **Effects:** halftone dot patterns, slight misregistration offset (translate text 1px).
- **Imagery:** posterized photos, single-weight illustrations.
- **Type:** chunky sans, Old Standard, Authentic Sans.
- **Use for:** zines, indie publishing, art studios, food markets.

## vaporwave-neo-pop
A E S T H E T I C. Sunset gradients allowed here only.
- **Color:** pink/cyan/purple gradients on black or pastel.
- **Decoration:** Roman busts, palm trees, grids stretching to vanishing point.
- **Type:** wide-tracked uppercase, Japanese characters as decoration.
- **Motion:** chromatic aberration on hover, slow tape glitches.
- **Use for:** music, fashion, art, ironic SaaS.

## cyberpunk-neon
Blade Runner UI. Dark + neon + glitch.
- **Color:** near-black bg + magenta/cyan/lime glow accents.
- **Effects:** scanlines, glitch on hover, terminal text.
- **Type:** mono + condensed sans.
- **Layout:** HUD-style overlays, corner brackets `┏ ┓ ┗ ┛` on cards.
- **Use for:** crypto, gaming, AI, security tools.

## organic-eco
Nature-inspired, hand-drawn, earthy.
- **Color:** sage, moss, terracotta, cream, clay.
- **Type:** rounded humanist sans (Recoleta, Quattrocento, Spectral).
- **Imagery:** botanical illustrations, real plant photos, hand-lettered headlines.
- **Shapes:** organic blobs (hand-drawn, NOT 3D), leaf motifs.
- **Use for:** sustainability, wellness, food, beauty.

## raw-brutalism
Maximum brutalism. Ugly-on-purpose, system fonts, default browser styling.
- **Type:** Times New Roman or system serif. Default `<a>` blue underlines.
- **Layout:** left-aligned, no max-width, full text reflow.
- **Color:** white + black + #0000EE links. Maybe one shock color.
- **Imagery:** raw, unedited, even broken-image alt text shown.
- **Use for:** anti-design statements, art, manifestos.

## kinfolk-warm
Slow living magazine. Cream, serif, lifestyle photography.
- **Color:** off-white, taupe, dusty sage, warm gray.
- **Type:** classical serif (Cormorant, Lora, Playfair) + clean sans body.
- **Imagery:** moody real-life photos, hands, textures, food.
- **Layout:** generous, asymmetric, magazine-style.
- **Use for:** wellness, food, lifestyle, hospitality, slow brands.

## sci-fi-spatial
Apple Vision Pro / spatial OS. Volumetric, depth, restrained.
- **Color:** dark glass + soft glow + one warm accent. (Glass IS allowed here.)
- **Type:** rounded sans (SF Pro vibe, Manrope).
- **Effects:** depth via blur layers, smooth spring physics, parallax.
- **Layout:** floating cards in space, but minimal — no clutter.
- **Use for:** AR/VR, hardware, spatial computing.

## retro-arcade
8-bit / 16-bit pixel art. CRT scanlines.
- **Type:** pixel fonts (Press Start 2P, VT323, Departure Mono).
- **Color:** NES/Genesis palette (8 colors max).
- **Effects:** CRT curve overlay, scanlines, dithering.
- **Imagery:** sprite-style illustrations.
- **Use for:** indie games, esports, nostalgia brands.

## luxury-quiet
Quiet luxury. Almost nothing on screen but the right thing.
- **Color:** off-white + ink + brass. No accent unless absolutely needed.
- **Type:** classical serif uppercase tracked (Bodoni, Caslon) for logo; clean sans body.
- **Layout:** centered hero photograph, tiny logo, single nav line.
- **Motion:** slow fade only.
- **Use for:** luxury fashion, jewelry, high-end real estate.

## handmade-zine
Photocopied, cut-and-paste, taped together.
- **Imagery:** scanned doodles, taped polaroids, marker arrows.
- **Type:** mix typewriter + handwriting + cutout newspaper headlines.
- **Layout:** intentionally crooked, overlapping elements.
- **Color:** photocopy black + 1 highlighter color.
- **Use for:** music zines, indie publishing, punk brands, art.

## anti-design-raw
Embraces ugliness. Default fonts, unstyled forms, broken grids.
- **Type:** browser default. `<select>` and `<input>` look like 1998.
- **Layout:** none. `<table>` allowed. No CSS framework.
- **Color:** body bg only. Link blue. Visited purple.
- **Use for:** statements, art projects, documentation that doesn't apologize.

## neo-skeuomorphic
2010-style skeuomorphism, but tasteful and modern.
- **Effects:** subtle inner shadows, leather/paper textures, real material gradients.
- **Use cases:** notebooks, audio apps, music, books, journaling.
- **Restraint:** ONE skeuomorphic element per screen, not everywhere.

## tactile-paper
Everything looks printed on paper.
- **Bg:** paper texture (subtle grain), slight off-white tint.
- **Effects:** torn edges, deckled borders, pencil underlines, rubber-stamp accents.
- **Type:** classical serif + handwritten accents.
- **Color:** ink + cream + one stamp red/blue.
- **Use for:** publishing, education, writing tools.

## constructivist
Russian Constructivism. Diagonal grids, red+black, propaganda type.
- **Color:** red, black, white, sometimes mustard.
- **Type:** condensed bold sans, often diagonal.
- **Layout:** strong diagonals, geometric blocks, photomontage.
- **Decoration:** geometric shapes (circles, triangles) as flat color.
- **Use for:** manifestos, agencies, bold brands.

## monochrome-noir
Black and white only. Type and photography are everything.
- **Color:** pure b&w (or near-black + off-white) + maybe 1 ultra-restrained accent (rare).
- **Type:** strong contrast — heavy display + light body.
- **Imagery:** high-contrast b&w photography.
- **Use for:** photography portfolios, fashion, agencies, film.

## blueprint-technical
Technical drawings, blueprints, engineering schematics.
- **Color:** blueprint blue + white lines, OR cream + technical pen black.
- **Decoration:** dimension lines, callouts with leader lines, grid backgrounds.
- **Type:** technical mono + condensed sans for labels.
- **Use for:** hardware, architecture, engineering tools, dev tools.

## scandi-soft
Scandinavian minimalism with warmth.
- **Color:** off-white + soft beige + muted pine green or terracotta.
- **Type:** humanist sans (Söhne, General Sans, Inter) + occasional serif.
- **Layout:** generous, clean, but not cold. Soft borders 1px.
- **Imagery:** natural light, wood, simple objects.
- **Use for:** lifestyle, furniture, books, education, healthcare.

---

> **Rule of one:** Pick ONE system per project. Mixing two = vibe-coded mess.
> Re-roll DNA if the system doesn't fit the brief: `bash scripts/dna.sh <niche> <new-seed>`.
