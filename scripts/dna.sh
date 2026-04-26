#!/opt/homebrew/bin/bash
# humanized-frontend :: Design DNA generator
# Produces a UNIQUE, niche-aware design brief every run.
#
# Usage:
#   bash dna.sh                              # auto niche, random seed
#   bash dna.sh fintech                      # niche, random seed
#   bash dna.sh fintech 42                   # niche + explicit seed (deterministic)
#   bash dna.sh --list                       # list all niches
#   bash dna.sh --json fintech 42            # JSON output (for piping into agents)
#
# The output is a Markdown brief that the agent MUST follow verbatim
# when designing the project. No two seeds produce the same combo.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ───────────────────────────────────────────────────────────── arrays
# Each array intentionally large. Combos: 25*50*40*15*12*12 = ~10^9 unique briefs.

SYSTEMS=(
  "soft-brutalism"           "editorial-magazine"      "swiss-minimal"
  "neo-memphis"              "y2k-revival"             "terminal-cli"
  "japanese-ma"              "art-deco-modern"         "risograph-print"
  "vaporwave-neo-pop"        "cyberpunk-neon"          "organic-eco"
  "raw-brutalism"            "kinfolk-warm"            "sci-fi-spatial"
  "retro-arcade"             "luxury-quiet"            "handmade-zine"
  "anti-design-raw"          "neo-skeuomorphic"        "tactile-paper"
  "constructivist"           "monochrome-noir"         "blueprint-technical"
  "scandi-soft"
)

PALETTES=(
  "warm-paper:#F4EFE6,#1A1A1A,#FF5C39,#2E5E4E"
  "cold-studio:#ECECEA,#0B0B0B,#3D5AFE,#C9A227"
  "riso-classic:#FFF8E7,#111111,#E63946,#1D3557"
  "midnight-terminal:#0A0E14,#E6E1CF,#39FF14,#FF6B6B"
  "sunset-desert:#F5E6D3,#3E2723,#E76F51,#F4A261"
  "forest-fog:#E8EDE7,#1B2A1F,#52796F,#D4A373"
  "oat-milk:#F5F1E8,#2C2416,#A47551,#6B4423"
  "neon-tokyo:#0F0F1E,#FAFAFA,#FF2A6D,#05D9E8"
  "mediterranean-blue:#FBF6E9,#0A2647,#144272,#FCBF49"
  "dusty-rose:#F5E6E8,#2D1B2E,#C08497,#7B6079"
  "mustard-clay:#FAF3E0,#3A2618,#D4A017,#A0522D"
  "blackboard-chalk:#1F2421,#F2F1E8,#FCD0A1,#B0BEC5"
  "parchment-ink:#EDE0C8,#1A1A1A,#8B0000,#4A4A4A"
  "bauhaus-primary:#F2F2F2,#000000,#E63946,#1D3557"
  "lavender-haze:#F0EBF4,#231942,#9F86C0,#E0B1CB"
  "copper-rust:#F4E9D8,#2C1810,#B7410E,#5C4033"
  "deep-ocean:#E8F1F2,#001F3F,#0074D9,#7FDBFF"
  "coral-reef:#FFF8F0,#2A2D34,#FF6B6B,#4ECDC4"
  "mint-cream:#F0FFF4,#1B3A2D,#2D6A4F,#B7E4C7"
  "charcoal-gold:#1C1C1C,#F5F5F5,#D4AF37,#8B7355"
  "retro-pastel:#FFE5EC,#3A2E2E,#FFB3C6,#A8DADC"
  "vapor-pink-cyan:#FFE0F7,#1A0033,#FF00FF,#00FFFF"
  "eco-moss:#EDE9DD,#2D3A2E,#5A7A3F,#A07C3D"
  "monochrome-noir:#FAFAFA,#0A0A0A,#5C5C5C,#A8A8A8"
  "brick-cream:#F5EBDD,#3D1F0E,#8B4513,#CC7722"
  "cherry-coke:#F8E5D6,#2D0E10,#8B0000,#D4A574"
  "scandi-pine:#F7F4EF,#1F2937,#4A6741,#C19A6B"
  "gallery-white:#FFFFFF,#0A0A0A,#FF3B30,#000000"
  "nordic-fjord:#E8EEF1,#1B262C,#3282B8,#BBE1FA"
  "miami-pastel:#FFE0E9,#0F4C75,#FF6B9D,#7FE7DC"
  "espresso-cream:#F0E5D8,#2A1810,#6F4E37,#C9A66B"
  "sahara-sand:#F4E4C1,#3E2723,#D4A574,#8B4513"
  "plum-velvet:#1A0B1E,#F5E6F0,#C71585,#FFD700"
  "butter-yellow:#FFFBE6,#1A1A1A,#FFD60A,#003566"
  "evergreen-amber:#1B2D1F,#F5E6C9,#D4A017,#7A9E7E"
  "raspberry-cream:#FAF0E6,#3D0814,#C71F37,#E8B4BC"
  "concrete-rose:#D5D2C9,#1A1A1A,#E91E63,#37474F"
  "soviet-red:#F5E8D0,#1B0E0E,#CC0000,#4A4A4A"
  "japanese-shoyu:#FAF7F2,#1C1C1C,#9B2D20,#3E3E3E"
  "iceberg-mint:#F0F9F8,#0A2540,#00B894,#74B9FF"
  "midnight-magenta:#0C0032,#E5E5E5,#FF0080,#7B2CBF"
  "wheat-field:#F4E5BC,#3F2D1B,#A57A36,#5C7A29"
  "cocoa-mint:#F5F0E8,#2D1810,#5D4037,#81C784"
  "bubblegum-noir:#0A0A0A,#FFE0F0,#FF1493,#FFFFFF"
  "vintage-petrol:#E8DCC4,#003B46,#07575B,#C4A57B"
  "sage-terracotta:#EDE6DA,#3E2C1C,#9CAF88,#C97D5E"
  "gunmetal-citrus:#2C3539,#F5F5DC,#C5E063,#E8E8E8"
  "berry-cream:#FFF0F5,#2C1810,#8B1A4F,#D4A574"
  "graphite-flame:#1F1F1F,#E8E8E8,#FF4500,#808080"
  "cloudberry:#FAF6F0,#2A1A0A,#D4622A,#7A8B69"
)

TYPE_PAIRS=(
  "Fraunces|Inter"             "Instrument Serif|Geist"
  "PP Editorial New|IBM Plex Sans"  "Migra|Söhne"
  "Playfair Display|Work Sans" "DM Serif Display|DM Sans"
  "Cormorant Garamond|Manrope" "Bricolage Grotesque|Inter"
  "Space Grotesque|Space Mono" "Syne|Inter"
  "Tiempos Headline|Söhne"     "GT Sectra|GT America"
  "Recoleta|Satoshi"           "Editorial Old|Neue Haas"
  "Newsreader|Public Sans"     "Caslon|Helvetica Now"
  "Gambetta|Switzer"           "Reckless Neue|General Sans"
  "Söhne Breit|Söhne"          "Migra Italic|Söhne Mono"
  "Authentic Sans|Authentic Sans" "Departure Mono|Departure Mono"
  "Berkeley Mono|Berkeley Mono" "JetBrains Mono|JetBrains Mono"
  "Boldonse|Inter"             "PP Mori|PP Mori"
  "Gloock|Inter"               "Old Standard TT|Karla"
  "Vollkorn|Quattrocento Sans" "Spectral|Source Sans 3"
  "Crimson Pro|Lato"           "Lora|Open Sans"
  "Bodoni Moda|Mulish"         "Italiana|Montserrat"
  "Abril Fatface|Poppins"      "Anton|Inter"
  "Archivo Black|Archivo"      "Bebas Neue|Roboto"
  "Unica One|Roboto Mono"      "Major Mono Display|Inter"
)

SURFACES=(
  "hard-1px-borders+offset-shadow"     "no-borders+heavy-noise-grain"
  "thick-3px-borders+no-shadow"        "dotted-borders+halftone-bg"
  "single-hairline-divider+flat"       "double-stroke+ascii-decoration"
  "torn-paper-edges+collage"           "blueprint-grid-bg+technical-callouts"
  "duotone-photos+riso-misregistration" "negative-space-only+no-cards"
  "bordered-rounded-2px+inset-shadow"  "mixed-radii+brutalist-shadow"
  "raw-html-feel+system-fonts"         "tactile-paper-bg+pencil-underlines"
  "frosted-glass-restrained+thin-borders"
)

MOTIONS=(
  "spring-physical-slow"          "no-motion-static-typographic"
  "letter-by-letter-reveal"       "scroll-driven-horizontal"
  "cursor-trail-with-label"       "wiggle-on-hover-2deg"
  "magnetic-cta-attraction"       "color-invert-section-transition"
  "marquee-ticker-headline"       "drag-to-explore-canvas"
  "page-curl-transitions"         "minimal-fade-only-200ms"
)

LAYOUTS=(
  "asymmetric-hero-photo-bleed-right"     "centered-editorial-drop-cap-intro"
  "split-50-50-with-rotated-card"         "magazine-multi-column-grid"
  "single-long-column-blog-style"         "bento-mixed-tile-sizes"
  "horizontal-scroll-galleria"            "diagonal-section-dividers"
  "swiss-strict-12-col-no-decoration"     "off-canvas-bleed-typography"
  "stacked-cards-with-rotation"           "manifesto-fullscreen-quotes"
)

SIGNATURES=(
  "hand-drawn-arrow-pointing-at-CTA"      "founder-polaroid-photo-rotated"
  "scribbled-circle-around-keyword"       "ascii-art-divider-between-sections"
  "ticker-marquee-of-real-customer-quotes" "tiny-handwritten-margin-notes"
  "running-system-clock-in-footer"        "guestbook-or-now-page-section"
  "single-easter-egg-konami-code"         "real-screenshot-of-handwritten-todo"
  "sketch-doodle-on-section-headers"      "collage-of-real-objects-photographed"
  "blinking-cursor-after-headline"        "dot-matrix-printed-receipt-section"
  "audio-clip-of-founder-explaining"      "live-edit-mode-cursor-on-text"
)

COPY_TONES=(
  "first-person-self-deprecating"   "manifesto-opinionated-bold"
  "deadpan-dry-humor"               "warm-conversational-friend"
  "technical-precise-no-fluff"      "poetic-fragments-short-lines"
  "confessional-vulnerable"         "academic-with-footnotes"
  "blue-collar-direct"              "absurdist-playful"
  "documentary-journalistic"        "campfire-storyteller"
)

# ───────────────────────────────────────────────────────────── niche playbooks
# Each niche biases system/palette/tone choices. Format:
#   niche|systems-allowed|palette-vibes|tone-vibes|extra-rules
# Matching is loose substring; arrays are filtered before random pick.

declare -a NICHES=(
  "fintech"        "wellness-yoga"   "saas-b2b"        "crypto-web3"
  "indie-hacker"   "music-artist"    "edtech"          "real-estate"
  "healthcare"     "creative-agency" "artist-portfolio" "dev-tools"
  "ai-startup"     "nonprofit"       "news-media"      "photography"
  "fitness-gym"    "beauty-cosmetics" "travel"         "podcast"
  "newsletter"     "legal"           "consulting"      "sustainability"
  "kids-toys"      "luxury-fashion"  "automotive"      "esports-gaming"
  "pet-brand"      "hardware-product" "marketplace"    "dating-app"
  "productivity"   "publishing-books" "film-video"     "architecture"
  "restaurant-food" "coffee-roaster" "winery"          "barbershop"
  "tattoo-studio"  "fashion-ecommerce" "religious-spiritual" "law-firm"
)

niche_filter() {
  # $1 = niche; sets ALLOW_SYSTEMS / PALETTE_HINT / TONE_HINT / NOTES
  case "$1" in
    fintech|legal|law-firm|consulting|real-estate)
      ALLOW_SYSTEMS="swiss-minimal|editorial-magazine|monochrome-noir|luxury-quiet|blueprint-technical|scandi-soft"
      PALETTE_HINT="cold-studio|charcoal-gold|nordic-fjord|monochrome-noir|gallery-white|deep-ocean|espresso-cream"
      TONE_HINT="technical-precise-no-fluff|warm-conversational-friend|documentary-journalistic"
      NOTES="Trust signals are critical: real names, dates, numbers. Avoid playful illustrations. Type does the heavy lifting." ;;
    wellness-yoga|beauty-cosmetics|sustainability|coffee-roaster|winery)
      ALLOW_SYSTEMS="kinfolk-warm|tactile-paper|organic-eco|japanese-ma|editorial-magazine|scandi-soft|handmade-zine"
      PALETTE_HINT="oat-milk|sage-terracotta|forest-fog|cloudberry|wheat-field|eco-moss|cocoa-mint|warm-paper|dusty-rose"
      TONE_HINT="poetic-fragments-short-lines|warm-conversational-friend|campfire-storyteller"
      NOTES="Use real botanical/product photos with grain. Generous whitespace. Slow motion. Serif lowercase headlines feel intimate." ;;
    crypto-web3|ai-startup|dev-tools|saas-b2b)
      ALLOW_SYSTEMS="terminal-cli|swiss-minimal|blueprint-technical|cyberpunk-neon|monochrome-noir|sci-fi-spatial|constructivist"
      PALETTE_HINT="midnight-terminal|gunmetal-citrus|midnight-magenta|cold-studio|monochrome-noir|iceberg-mint|graphite-flame"
      TONE_HINT="deadpan-dry-humor|technical-precise-no-fluff|manifesto-opinionated-bold"
      NOTES="Show the actual product/code, not abstractions. Mono fonts welcome. Live data widgets > stock illustrations." ;;
    indie-hacker|productivity|newsletter|publishing-books)
      ALLOW_SYSTEMS="editorial-magazine|handmade-zine|tactile-paper|anti-design-raw|swiss-minimal|kinfolk-warm"
      PALETTE_HINT="warm-paper|parchment-ink|oat-milk|espresso-cream|cloudberry|riso-classic"
      TONE_HINT="first-person-self-deprecating|confessional-vulnerable|campfire-storyteller|deadpan-dry-humor"
      NOTES="Founder-led. First person mandatory. Real photos, real revenue numbers if possible. Newsletter signup over feature grid." ;;
    music-artist|artist-portfolio|photography|film-video|tattoo-studio|fashion-ecommerce|luxury-fashion)
      ALLOW_SYSTEMS="editorial-magazine|art-deco-modern|swiss-minimal|monochrome-noir|luxury-quiet|raw-brutalism|anti-design-raw"
      PALETTE_HINT="gallery-white|monochrome-noir|charcoal-gold|plum-velvet|bubblegum-noir|cherry-coke|japanese-shoyu"
      TONE_HINT="poetic-fragments-short-lines|manifesto-opinionated-bold|deadpan-dry-humor"
      NOTES="Image is the hero. Type plays support. Big galleries, full-bleed media, minimal nav. Mute on autoplay." ;;
    esports-gaming|kids-toys|y2k|miami)
      ALLOW_SYSTEMS="y2k-revival|vaporwave-neo-pop|retro-arcade|cyberpunk-neon|neo-memphis|sci-fi-spatial"
      PALETTE_HINT="neon-tokyo|vapor-pink-cyan|miami-pastel|midnight-magenta|bubblegum-noir|retro-pastel|plum-velvet"
      TONE_HINT="absurdist-playful|manifesto-opinionated-bold|deadpan-dry-humor"
      NOTES="Loud colors allowed. Pixel art, chrome text, blinking elements OK. Sound on hover. Break the rules of restraint." ;;
    restaurant-food|barbershop|automotive|auto|hardware-product|architecture)
      ALLOW_SYSTEMS="editorial-magazine|tactile-paper|swiss-minimal|risograph-print|raw-brutalism|blueprint-technical|constructivist"
      PALETTE_HINT="brick-cream|copper-rust|sahara-sand|cherry-coke|espresso-cream|concrete-rose|riso-classic|wheat-field"
      TONE_HINT="blue-collar-direct|warm-conversational-friend|documentary-journalistic"
      NOTES="Show the craft: hands working, materials, texture. Address, hours, phone in hero. No SaaS-speak." ;;
    healthcare|nonprofit|religious-spiritual|edtech)
      ALLOW_SYSTEMS="editorial-magazine|swiss-minimal|kinfolk-warm|scandi-soft|handmade-zine|tactile-paper"
      PALETTE_HINT="iceberg-mint|nordic-fjord|forest-fog|warm-paper|cocoa-mint|sage-terracotta|mediterranean-blue"
      TONE_HINT="warm-conversational-friend|documentary-journalistic|campfire-storyteller"
      NOTES="Real human photos (consented). Plain language, reading level grade 7. Accessibility ≥ AAA where possible." ;;
    travel|podcast|news-media|creative-agency|marketplace|dating-app|pet-brand|fitness-gym|real-estate)
      ALLOW_SYSTEMS="editorial-magazine|neo-memphis|risograph-print|kinfolk-warm|swiss-minimal|tactile-paper|handmade-zine|scandi-soft|raw-brutalism"
      PALETTE_HINT="sunset-desert|coral-reef|mediterranean-blue|miami-pastel|raspberry-cream|berry-cream|warm-paper|nordic-fjord|cloudberry"
      TONE_HINT="campfire-storyteller|warm-conversational-friend|absurdist-playful|documentary-journalistic"
      NOTES="Story-driven hero. Image-rich. Map or location element if relevant. Avoid generic 'community' copy." ;;
    *)
      ALLOW_SYSTEMS=""; PALETTE_HINT=""; TONE_HINT=""
      NOTES="Generic project — DNA picks freely from full library." ;;
  esac
}

# ───────────────────────────────────────────────────────────── helpers

pick_filtered() {
  # $1 = array variable name (string), $2 = pipe-separated allow list (or empty)
  # bash 3.2 compatible: uses eval instead of nameref
  local arr_name="$1"
  local allow="$2"
  local count
  eval "count=\${#${arr_name}[@]}"
  if [[ -z "$allow" ]]; then
    local idx=$((RANDOM % count))
    eval "echo \"\${${arr_name}[$idx]}\""
    return
  fi
  local pool=()
  local needles
  IFS='|' read -r -a needles <<< "$allow"
  local i item match n
  for ((i=0; i<count; i++)); do
    eval "item=\"\${${arr_name}[$i]}\""
    match=0
    for n in "${needles[@]}"; do
      case "$item" in *"$n"*) match=1; break;; esac
    done
    [[ $match -eq 1 ]] && pool+=("$item")
  done
  if [[ ${#pool[@]} -eq 0 ]]; then
    local idx=$((RANDOM % count))
    eval "echo \"\${${arr_name}[$idx]}\""
  else
    echo "${pool[$((RANDOM % ${#pool[@]}))]}"
  fi
}

list_niches() {
  printf '%s\n' "${NICHES[@]}" | sort -u
}

# ───────────────────────────────────────────────────────────── arg parse
JSON=0
if [[ "${1:-}" == "--list" ]]; then list_niches; exit 0; fi
if [[ "${1:-}" == "--json" ]]; then JSON=1; shift; fi

NICHE="${1:-auto}"
SEED="${2:-$(date +%s%N 2>/dev/null || date +%s)$$}"
RANDOM=$((SEED % 32767))
if [[ "$NICHE" == "auto" ]]; then
# auto niche → random pick
  NICHE="${NICHES[$((RANDOM % ${#NICHES[@]}))]}"
fi

niche_filter "$NICHE"

SYSTEM=$(pick_filtered SYSTEMS "$ALLOW_SYSTEMS")
PALETTE_RAW=$(pick_filtered PALETTES "$PALETTE_HINT")
TYPE=$(pick_filtered TYPE_PAIRS "")
SURFACE=$(pick_filtered SURFACES "")
MOTION=$(pick_filtered MOTIONS "")
LAYOUT=$(pick_filtered LAYOUTS "")
SIGNATURE=$(pick_filtered SIGNATURES "")
TONE=$(pick_filtered COPY_TONES "$TONE_HINT")

PALETTE_NAME="${PALETTE_RAW%%:*}"
PALETTE_HEX="${PALETTE_RAW#*:}"
IFS=',' read -r BG INK ACCENT SECONDARY <<< "$PALETTE_HEX"
TYPE_DISPLAY="${TYPE%%|*}"
TYPE_BODY="${TYPE##*|}"

# ───────────────────────────────────────────────────────────── output

if [[ $JSON -eq 1 ]]; then
cat <<EOF
{
  "seed": "$SEED",
  "niche": "$NICHE",
  "system": "$SYSTEM",
  "palette": { "name": "$PALETTE_NAME", "bg": "$BG", "ink": "$INK", "accent": "$ACCENT", "secondary": "$SECONDARY" },
  "typography": { "display": "$TYPE_DISPLAY", "body": "$TYPE_BODY" },
  "surface": "$SURFACE",
  "motion": "$MOTION",
  "layout": "$LAYOUT",
  "signature": "$SIGNATURE",
  "tone": "$TONE",
  "notes": "$NOTES"
}
EOF
  exit 0
fi

cat <<EOF
# 🧬 Design DNA — unique brief
> seed: \`$SEED\` · niche: \`$NICHE\`
> Re-run with the same seed to reproduce. Different seed = different design.

## Mandatory creative constraints (do NOT deviate)

| Slot       | Value |
|------------|-------|
| **Design system** | \`$SYSTEM\` |
| **Palette**       | \`$PALETTE_NAME\` — bg \`$BG\` · ink \`$INK\` · accent \`$ACCENT\` · secondary \`$SECONDARY\` |
| **Typography**    | display **$TYPE_DISPLAY** + body **$TYPE_BODY** |
| **Surface treatment** | \`$SURFACE\` |
| **Motion language** | \`$MOTION\` |
| **Layout archetype** | \`$LAYOUT\` |
| **Signature element** | \`$SIGNATURE\` (must appear at least once) |
| **Copy tone**     | \`$TONE\` |

## Niche notes ($NICHE)
$NOTES

## Instructions for the agent
1. Open \`references/design-systems.md\` and read the section for **\`$SYSTEM\`**. Apply its rules as the visual foundation.
2. Use ONLY the 4 colors above. No gradients unless the system explicitly allows them.
3. Use ONLY the typography pair above. Import via Google Fonts or Fontshare. Headlines display, body sans.
4. Apply the surface treatment to ALL cards/sections. Do not mix with other surfaces.
5. Apply the motion language consistently. Respect \`prefers-reduced-motion\`.
6. Build using the layout archetype as the page skeleton.
7. The signature element MUST appear (it's what makes this site unique).
8. Write copy in the specified tone. Audit with \`references/copywriting-humanizer.md\`.
9. Run \`scripts/audit.sh\` before declaring done.

## Forbidden in this DNA
- Switching to a different design system mid-build.
- Adding any color outside the 4-token palette.
- Using stock-AI tropes from \`references/anti-ai-checklist.md\`.

> Generated by humanized-frontend · regenerate: \`bash scripts/dna.sh $NICHE\`
EOF
