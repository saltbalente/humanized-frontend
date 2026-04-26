# Niche Playbooks

The DNA engine biases choices per niche. This file is the human-readable reference for each niche's conventions — load it when you need extra context beyond what `dna.sh` outputs.

> Format per niche: **vibe** · **systems welcomed** · **palettes welcomed** · **must-haves** · **traps to avoid**

---

## fintech / legal / law-firm / consulting / real-estate
- **Vibe:** trust, precision, restraint.
- **Systems:** swiss-minimal, editorial-magazine, monochrome-noir, luxury-quiet, blueprint-technical, scandi-soft.
- **Palettes:** cold-studio, charcoal-gold, nordic-fjord, gallery-white, espresso-cream, deep-ocean.
- **Must:** real names + headshots, transparent pricing/fees, regulatory badges, last-updated dates, jurisdiction.
- **Avoid:** playful illustrations, emoji in copy, unverifiable testimonials, "AI-powered" hype.

## wellness-yoga / beauty-cosmetics / sustainability / coffee-roaster / winery
- **Vibe:** sensory, slow, intimate.
- **Systems:** kinfolk-warm, tactile-paper, organic-eco, japanese-ma, scandi-soft, handmade-zine.
- **Palettes:** oat-milk, sage-terracotta, forest-fog, cloudberry, dusty-rose, eco-moss.
- **Must:** real product/process photography (with grain), origin story, ingredient/process transparency.
- **Avoid:** stock photos of people meditating in white robes, "Empower your wellness journey" copy, before/after grids.

## crypto-web3 / ai-startup / dev-tools / saas-b2b
- **Vibe:** technical credibility, fast, smart, occasionally edgy.
- **Systems:** terminal-cli, swiss-minimal, blueprint-technical, cyberpunk-neon, monochrome-noir, sci-fi-spatial.
- **Palettes:** midnight-terminal, gunmetal-citrus, midnight-magenta, iceberg-mint, graphite-flame.
- **Must:** show real product UI / code / metrics. Quickstart in <60s. Open changelog.
- **Avoid:** abstract "AI brain" illustrations, neural network gradients, "synergy" copy, Heroicons.

## indie-hacker / productivity / newsletter / publishing-books
- **Vibe:** founder-led, opinionated, transparent.
- **Systems:** editorial-magazine, handmade-zine, tactile-paper, anti-design-raw, swiss-minimal, kinfolk-warm.
- **Palettes:** warm-paper, parchment-ink, oat-milk, espresso-cream, cloudberry, riso-classic.
- **Must:** founder photo, first-person voice, real revenue/numbers, build-in-public link, single CTA.
- **Avoid:** "Trusted by 10,000+ teams" if false, generic feature grid, $$$$ pricing tier called "Enterprise".

## music-artist / artist-portfolio / photography / film-video / tattoo-studio / fashion-ecommerce / luxury-fashion
- **Vibe:** image-led, editorial, work-first.
- **Systems:** editorial-magazine, art-deco-modern, swiss-minimal, monochrome-noir, luxury-quiet, raw-brutalism, anti-design-raw.
- **Palettes:** gallery-white, monochrome-noir, charcoal-gold, plum-velvet, bubblegum-noir, japanese-shoyu.
- **Must:** full-bleed gallery, image preloading, project case studies, contact one click away.
- **Avoid:** wordy copy that obscures the work, autoplay audio with sound, Lightbox plugins from 2012.

## esports-gaming / kids-toys / pet-brand
- **Vibe:** loud, playful, immersive.
- **Systems:** y2k-revival, vaporwave-neo-pop, retro-arcade, cyberpunk-neon, neo-memphis, sci-fi-spatial.
- **Palettes:** neon-tokyo, vapor-pink-cyan, miami-pastel, midnight-magenta, bubblegum-noir, retro-pastel.
- **Must:** sound design (off by default, easy to enable), motion, mascot, leaderboards or live elements.
- **Avoid:** restrained corporate type, gray UI, hiding personality.

## restaurant-food / barbershop / automotive / hardware-product / architecture
- **Vibe:** craft, materiality, hands-on.
- **Systems:** editorial-magazine, tactile-paper, swiss-minimal, risograph-print, raw-brutalism, blueprint-technical, constructivist.
- **Palettes:** brick-cream, copper-rust, sahara-sand, cherry-coke, espresso-cream, riso-classic.
- **Must:** address + hours + phone in hero, photos of the actual space/product/people, materials list.
- **Avoid:** SaaS-style feature grids, "Book a Demo" copy, generic team illustrations.

## healthcare / nonprofit / religious-spiritual / edtech
- **Vibe:** clear, accessible, human.
- **Systems:** editorial-magazine, swiss-minimal, kinfolk-warm, scandi-soft, handmade-zine, tactile-paper.
- **Palettes:** iceberg-mint, nordic-fjord, forest-fog, warm-paper, cocoa-mint, mediterranean-blue.
- **Must:** WCAG AA min, AAA preferred. Plain language (grade ≤7). Real consented photos. Multilingual links.
- **Avoid:** medical jargon, pity imagery, stock "diverse hands holding earth" photos, fake urgency.

## travel / podcast / news-media / creative-agency / marketplace / dating-app / fitness-gym / pet-brand
- **Vibe:** narrative, image-rich, lively.
- **Systems:** editorial-magazine, neo-memphis, risograph-print, kinfolk-warm, swiss-minimal, tactile-paper, handmade-zine, scandi-soft, raw-brutalism.
- **Palettes:** sunset-desert, coral-reef, mediterranean-blue, miami-pastel, raspberry-cream, berry-cream, cloudberry.
- **Must:** at least one map, location, or scene image. Story-driven hero. Author/host bio.
- **Avoid:** generic "join our community" copy, identical-looking testimonial cards, fake "as featured in" logos.

---

## Niche-specific signature elements

When generating, ALWAYS include at least one of these per niche to anchor authenticity:

| Niche                       | Signature elements                                                       |
|-----------------------------|--------------------------------------------------------------------------|
| fintech                     | Live exchange rate ticker, regulator badge, last-audited date            |
| wellness/coffee/winery      | Origin map, ingredient list with provenance, batch number                |
| crypto/web3                 | Live block explorer link, contract address, gas price widget             |
| dev tools                   | Embedded terminal demo, GitHub stars live count, latest commit hash      |
| indie hacker                | MRR / user count widget, founder polaroid, "built in X days" badge       |
| music artist                | Audio sample with custom waveform, tour dates list, bandcamp link        |
| photography                 | EXIF data on hover (camera, lens, ISO), large image preloader            |
| restaurant                  | Today's menu pulled live, hours-open status indicator, Google Maps embed |
| healthcare                  | "Read this in 3 min" indicator, language switcher, phone number first    |
| esports                     | Live stream embed, leaderboard widget, sponsor logos done well           |
| barbershop / tattoo         | Booking calendar inline, artist portfolios with style filter             |
| coffee roaster              | Roast date stamp, brew method recommender, farm photo carousel           |
| nonprofit                   | Live impact counter (real data), transparency report link                |
| podcast                     | Latest episode embed (audio only by default), full transcript link       |
| newsletter                  | Single email field, latest issue preview, subscriber count if >1k        |
| real estate                 | Map-first listing, sqft + price + year built in callout                  |

---

## How to combine with DNA

1. Run `bash scripts/dna.sh <niche>` → get unique system + palette + type combo.
2. Read the niche playbook above for **must-haves** and **traps**.
3. Read the corresponding system in [design-systems.md](./design-systems.md).
4. Build. Add at least ONE signature element from the table above.
5. Run `bash scripts/audit.sh <output>` before shipping.

> The combination of (DNA randomness × niche playbook × signature element) means **no two humanized-frontend projects look alike**, even within the same niche.
