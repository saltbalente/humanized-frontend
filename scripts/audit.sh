#!/usr/bin/env bash
# humanized-frontend :: Anti-Vibe-Coded Audit (v2.1)
# Categorized score, Markdown report, optional --fix recommendations.
#
# Usage:
#   bash audit.sh                          # audit current dir
#   bash audit.sh ./src                    # audit a path
#   bash audit.sh ./src --report out.md    # write Markdown report
#   bash audit.sh ./src --fix              # print actionable fix recommendations
#   bash audit.sh ./src --json             # machine-readable
#
# Categories: Color · Layout · Typography · Iconography · Copy · Imperfection · Personality · A11y

set -uo pipefail

# ── args
TARGET="."
REPORT=""
JSON=0
FIX=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --report) REPORT="$2"; shift 2 ;;
    --json)   JSON=1; shift ;;
    --fix)    FIX=1; shift ;;
    -h|--help)
      sed -n '2,12p' "$0"; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

[[ -e "$TARGET" ]] || { echo "❌ path not found: $TARGET" >&2; exit 1; }

# ── colors
R=$'\e[31m'; G=$'\e[32m'; Y=$'\e[33m'; B=$'\e[1m'; D=$'\e[2m'; N=$'\e[0m'

# ── greppable extensions
GREP_INC='--include=*.html --include=*.htm --include=*.jsx --include=*.tsx \
--include=*.js --include=*.ts --include=*.vue --include=*.svelte \
--include=*.astro --include=*.css --include=*.scss --include=*.mdx --include=*.md'

# ── result accumulators (parallel arrays for bash 3.2 compat)
CAT_NAMES=(); CAT_SCORES=(); CAT_MAX=()
HIT_CAT=();  HIT_LABEL=(); HIT_COUNT=(); HIT_FIX=(); HIT_SAMPLE=()

cat_init() {
  CAT_NAMES+=("$1"); CAT_SCORES+=("$2"); CAT_MAX+=("$2")
}

cat_hit() {
  # $1=cat $2=weight
  local i
  for i in "${!CAT_NAMES[@]}"; do
    if [[ "${CAT_NAMES[$i]}" == "$1" ]]; then
      CAT_SCORES[$i]=$((CAT_SCORES[$i] - $2))
      [[ ${CAT_SCORES[$i]} -lt 0 ]] && CAT_SCORES[$i]=0
      return
    fi
  done
}

scan() {
  # $1=category $2=label $3=regex $4=weight $5=fix-recommendation
  local cat="$1" label="$2" pattern="$3" weight="$4" fix="$5"
  local raw count sample
  raw=$(eval grep -REn $GREP_INC -E \"$pattern\" \"$TARGET\" 2>/dev/null || true)
  count=$(printf "%s" "$raw" | grep -c . || true)
  if [[ "$count" -gt 0 ]]; then
    sample=$(printf "%s" "$raw" | head -1 | cut -c1-120)
    printf "  ${R}✗${N} [%s] %-46s %3s match  ${Y}-%s${N}\n" "$cat" "$label" "$count" "$weight"
    cat_hit "$cat" "$weight"
    HIT_CAT+=("$cat"); HIT_LABEL+=("$label"); HIT_COUNT+=("$count")
    HIT_FIX+=("$fix"); HIT_SAMPLE+=("$sample")
  else
    printf "  ${G}✓${N} [%s] %s\n" "$cat" "$label"
  fi
}

# ── Categories (max points each)
cat_init "COLOR"        20
cat_init "LAYOUT"       15
cat_init "TYPOGRAPHY"   15
cat_init "ICONOGRAPHY"  10
cat_init "COPY"         20
cat_init "IMPERFECTION" 10
cat_init "PERSONALITY"  10
cat_init "A11Y"         10

echo "${B}humanized-frontend audit v2.1${N} :: ${B}$TARGET${N}"
echo "─────────────────────────────────────────────────────────────"

# ╔══ COLOR
echo; echo "${B}▸ Color (max 20)${N}"
scan COLOR "purple/pink gradients"           'from-(purple|pink|fuchsia|violet|indigo)-[0-9]+|to-(purple|pink|fuchsia|violet|indigo)-[0-9]+|via-(purple|pink|fuchsia)-[0-9]+' 6 \
"Replace gradient with a solid warm color from your DNA palette. Run dna.sh and use bg/ink/accent only."
scan COLOR "blue→purple gradient (Stripe-clone)" 'from-blue-[0-9]+.*to-(purple|indigo|violet)' 4 \
"This is the #1 AI-cliché gradient of 2024-26. Solid color or one DNA accent only."
scan COLOR "bg-gradient-to-r/br/tr (any)"    'bg-gradient-to-(r|br|tr|tl|bl)' 3 \
"Avoid linear gradients on backgrounds. If you need depth, use a noise SVG overlay instead."
scan COLOR "pure white background"           'bg-white\b|background(-color)?:\s*#fff(fff)?\b' 3 \
"Replace #FFFFFF with a warm off-white from DNA (e.g. #F4EFE6, #FFF8E7, #FAF7F2)."
scan COLOR "pure black text"                 'text-black\b|color:\s*#000(000)?\b' 2 \
"Use ink color from DNA (#1A1A1A, #0A0A0A, #1B262C) for warmth. #000 is harsh."
scan COLOR "shadcn default chart palette"    '\bchart-1\b|\bchart-2\b|\bchart-3\b|hsl\(var\(--chart-' 2 \
"Override shadcn chart colors with your DNA palette."

# ╔══ LAYOUT
echo; echo "${B}▸ Layout (max 15)${N}"
scan LAYOUT "shadow-xl/2xl + rounded-2xl combo"  '(shadow-(xl|2xl)).*(rounded-(2xl|3xl))|rounded-(2xl|3xl).*(shadow-(xl|2xl))' 5 \
"This combo screams shadcn-default. Use offset shadow + rounded-none/sm, or no shadow + 1px border."
scan LAYOUT "universal rounded-2xl/3xl"      'rounded-(2xl|3xl)' 3 \
"Mix radii. Use rounded-none, rounded-[2px], rounded-sm. The rounded-2xl monoculture is over."
scan LAYOUT "glassmorphism (backdrop-blur)"   'backdrop-blur(-(sm|md|lg|xl|2xl|3xl))?' 4 \
"Glassmorphism is dated unless DNA system is sci-fi-spatial. Use solid bg + 1-2px border instead."
scan LAYOUT "soft elevation shadows"          'shadow-(lg|xl|2xl|inner)\b' 2 \
"Soft Material shadows = AI default. Use hard offset shadow [4px_4px_0_#000] or remove."
scan LAYOUT "everything text-center spam"     'text-center.*text-center.*text-center.*text-center' 1 \
"Break symmetry. Mix text-left, text-center, off-center placement."

# ╔══ TYPOGRAPHY
echo; echo "${B}▸ Typography (max 15)${N}"
scan TYPOGRAPHY "Inter as the only font"      'font-(sans|inter|geist).*Inter|family:\s*[\x27"]Inter' 3 \
"Inter is the AI-default. Pair it with a serif/display from DNA (Fraunces, Instrument Serif, etc.)."
scan TYPOGRAPHY "system font stack only"      'font-family:\s*-apple-system,\s*BlinkMacSystemFont' 2 \
"Unless DNA system is anti-design-raw, load real fonts from Google Fonts/Fontshare."
scan TYPOGRAPHY "no display font for headings" 'h1.*font-sans|h1.*font-medium\b' 2 \
"Headlines should use display/serif font from DNA, not body sans."
scan TYPOGRAPHY "tracking-tight on every heading" 'h[1-3].*tracking-tight.*tracking-tight.*tracking-tight' 1 \
"Variation > consistency. Mix tracking-normal, tracking-wide on different sections."

# ╔══ ICONOGRAPHY
echo; echo "${B}▸ Iconography (max 10)${N}"
scan ICONOGRAPHY "Heroicons import"           '@heroicons/react|heroicons' 4 \
"Replace with: hand-drawn SVG, Phosphor Duotone, unicode glyph (▲ ◆ ✦ →), or DNA-system icon."
scan ICONOGRAPHY "Lucide default"             'from\s+["\x27]lucide-react["\x27]|from\s+["\x27]lucide["\x27]' 3 \
"Lucide is the new Heroicons. Override or replace at least 50% of icons with custom SVG."
scan ICONOGRAPHY "Tabler / React-Icons defaults" 'from\s+["\x27]@tabler/icons|from\s+["\x27]react-icons' 2 \
"Default icon libraries are an AI tell. Customize or replace key icons."

# ╔══ COPY
echo; echo "${B}▸ Copy (max 20)${N}"
scan COPY "em dashes (—)"                     '—' 4 \
"#1 LLM fingerprint in 2026. Replace ALL em dashes with commas, periods or parentheses."
scan COPY "AI buzzwords (verbs)"              '\b(unleash|empower|elevate|leverage|revolutionize|supercharge|streamline|amplify|maximize|accelerate)\b' 5 \
"Banned verbs. Rewrite with concrete actions. See references/copywriting-humanizer.md §1."
scan COPY "AI buzzwords (adjectives)"         '\b(seamless|effortless|cutting-edge|game-changing|revolutionary|innovative|robust|holistic|world-class|industry-leading|next-generation|state-of-the-art|enterprise-grade)\b' 5 \
"Banned adjectives. Replace with specifics: 'fast' → 'p95 < 200ms'. 'Robust' → '99.9% over 18 months'."
scan COPY "vague nouns (platform/solution/ecosystem)" '\b(platform|solution|ecosystem)\b' 1 \
"Replace 'platform/solution/ecosystem' with what the thing literally IS (an app, a script, a SaaS, a tool)."
scan COPY "generic CTA copy"                  '>(Get Started|Learn More|Sign Up Now|Book a Demo|Try for Free|Contact Sales|Subscribe Now)\s*<' 3 \
"Replace with conversational CTA. See copywriting-humanizer.md §2."
scan COPY "trusted-by-thousands cliché"       '(trusted by|join (thousands|millions|10,000|100,000)|loved by [0-9])' 2 \
"Use real numbers ('used by 237 people') or remove. Lying about scale is the worst AI smell."

# ╔══ IMPERFECTION
echo; echo "${B}▸ Imperfection (max 10)${N}"
# These are positive signals — count their ABSENCE.
HAS_ROTATE=$(eval grep -REl $GREP_INC -E '(rotate-\[?-?[0-9])|transform.*rotate' \"$TARGET\" 2>/dev/null | head -1)
HAS_OFFSET_SHADOW=$(eval grep -REl $GREP_INC -E 'shadow-\[[0-9]+px[_ ][0-9]+px[_ ]0' \"$TARGET\" 2>/dev/null | head -1)
HAS_HANDDRAWN=$(eval grep -REl $GREP_INC -E '(hand-drawn|handwritten|font-(hand|cursive|caveat))' \"$TARGET\" 2>/dev/null | head -1)
HAS_NOISE=$(eval grep -REl $GREP_INC -E '(noise|grain|texture|paper)' \"$TARGET\" 2>/dev/null | head -1)
[[ -z "$HAS_ROTATE" ]]        && { printf "  ${R}✗${N} [IMPERFECTION] no rotated elements (asymmetry)              ${Y}-3${N}\n"; cat_hit IMPERFECTION 3; HIT_CAT+=(IMPERFECTION); HIT_LABEL+=("no rotated elements"); HIT_COUNT+=("0"); HIT_FIX+=("Add rotate-[-0.6deg] or rotate-[1deg] to at least one card or photo."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [IMPERFECTION] rotated/asymmetric elements present\n"
[[ -z "$HAS_OFFSET_SHADOW" ]] && { printf "  ${R}✗${N} [IMPERFECTION] no brutalist offset shadow                  ${Y}-2${N}\n"; cat_hit IMPERFECTION 2; HIT_CAT+=(IMPERFECTION); HIT_LABEL+=("no offset shadow"); HIT_COUNT+=("0"); HIT_FIX+=("Use shadow-[4px_4px_0_#000] for at least one element instead of shadow-xl."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [IMPERFECTION] brutalist offset shadow used\n"
[[ -z "$HAS_HANDDRAWN" ]]     && { printf "  ${R}✗${N} [IMPERFECTION] no hand-drawn / handwritten element         ${Y}-3${N}\n"; cat_hit IMPERFECTION 3; HIT_CAT+=(IMPERFECTION); HIT_LABEL+=("no hand-drawn element"); HIT_COUNT+=("0"); HIT_FIX+=("Add a hand-drawn SVG arrow, a Caveat-font margin note, or a sketch."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [IMPERFECTION] hand-drawn / handwritten present\n"
[[ -z "$HAS_NOISE" ]]         && { printf "  ${R}✗${N} [IMPERFECTION] no texture / grain / paper background       ${Y}-2${N}\n"; cat_hit IMPERFECTION 2; HIT_CAT+=(IMPERFECTION); HIT_LABEL+=("no texture/grain"); HIT_COUNT+=("0"); HIT_FIX+=("Add a noise SVG overlay (5-8% opacity) or paper background. See assets/tailwind-humanized-config.md."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [IMPERFECTION] texture / grain present\n"

# ╔══ PERSONALITY
echo; echo "${B}▸ Personality (max 10)${N}"
HAS_FIRST_PERSON=$(eval grep -REl $GREP_INC -iE '(\bI built\b|\bI made\b|\bsoy\s+[A-Z]|\byo (hice|construí)\b|\bme llamo\b|\bmy name is\b)' \"$TARGET\" 2>/dev/null | head -1)
HAS_NAMED_PERSON=$(eval grep -REl $GREP_INC -E '— [A-Z][a-z]+ [A-Z][a-z]+|by [A-Z][a-z]+ [A-Z][a-z]+,' \"$TARGET\" 2>/dev/null | head -1)
HAS_REAL_NUMBERS=$(eval grep -REc $GREP_INC -E '\b[0-9]{2,5}\s+(personas|users|customers|people|clientes|suscriptores)\b' \"$TARGET\" 2>/dev/null | awk -F: '{s+=$NF}END{print s+0}')
HAS_EASTER_EGG=$(eval grep -REl $GREP_INC -iE '(easter[- ]?egg|konami|404\.|secret|hidden)' \"$TARGET\" 2>/dev/null | head -1)
[[ -z "$HAS_FIRST_PERSON" ]]  && { printf "  ${R}✗${N} [PERSONALITY] no first-person voice detected               ${Y}-3${N}\n"; cat_hit PERSONALITY 3; HIT_CAT+=(PERSONALITY); HIT_LABEL+=("no first-person voice"); HIT_COUNT+=("0"); HIT_FIX+=("Add at least one 'soy/yo/I built/me llamo' sentence in About or Footer."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [PERSONALITY] first-person voice present\n"
[[ -z "$HAS_NAMED_PERSON" ]]  && { printf "  ${R}✗${N} [PERSONALITY] no named human (testimonial/author)          ${Y}-3${N}\n"; cat_hit PERSONALITY 3; HIT_CAT+=(PERSONALITY); HIT_LABEL+=("no named humans"); HIT_COUNT+=("0"); HIT_FIX+=("Use full real names + city in testimonials. Anonymous quotes feel fake."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [PERSONALITY] named humans (full name + context)\n"
[[ "${HAS_REAL_NUMBERS:-0}" -eq 0 ]] && { printf "  ${R}✗${N} [PERSONALITY] no real-number social proof                 ${Y}-2${N}\n"; cat_hit PERSONALITY 2; HIT_CAT+=(PERSONALITY); HIT_LABEL+=("no real numbers"); HIT_COUNT+=("0"); HIT_FIX+=("Replace 'thousands of users' with the real number ('237 people use it')."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [PERSONALITY] real numbers used as social proof\n"
[[ -z "$HAS_EASTER_EGG" ]]    && { printf "  ${Y}~${N} [PERSONALITY] no easter egg / hidden detail                 ${Y}-2${N}\n"; cat_hit PERSONALITY 2; HIT_CAT+=(PERSONALITY); HIT_LABEL+=("no easter egg"); HIT_COUNT+=("0"); HIT_FIX+=("Add a small hidden detail: a 404 with humor, a console.log, a footer joke."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [PERSONALITY] easter egg / hidden detail found\n"

# ╔══ A11Y
echo; echo "${B}▸ Accessibility (max 10)${N}"
scan A11Y "no prefers-reduced-motion handling" '(?!.*prefers-reduced-motion).*animate-' 0 ""  # marker only
HAS_PRM=$(eval grep -REl $GREP_INC -E 'prefers-reduced-motion' \"$TARGET\" 2>/dev/null | head -1)
HAS_FOCUS=$(eval grep -REl $GREP_INC -E 'focus-visible|:focus-visible|focus-(ring|outline)' \"$TARGET\" 2>/dev/null | head -1)
HAS_ALT=$(eval grep -REc $GREP_INC -E '<img\s' \"$TARGET\" 2>/dev/null | awk -F: '{s+=$NF}END{print s+0}')
NO_ALT=$(eval grep -REc $GREP_INC -E '<img(?![^>]*alt=)' \"$TARGET\" 2>/dev/null | awk -F: '{s+=$NF}END{print s+0}')
[[ -z "$HAS_PRM" ]]   && { printf "  ${R}✗${N} [A11Y] no prefers-reduced-motion handling                   ${Y}-3${N}\n"; cat_hit A11Y 3; HIT_CAT+=(A11Y); HIT_LABEL+=("no prefers-reduced-motion"); HIT_COUNT+=("0"); HIT_FIX+=("Add @media (prefers-reduced-motion: reduce) { *{animation:none!important;transition:none!important} }"); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [A11Y] prefers-reduced-motion handled\n"
[[ -z "$HAS_FOCUS" ]] && { printf "  ${R}✗${N} [A11Y] no custom focus-visible state                        ${Y}-3${N}\n"; cat_hit A11Y 3; HIT_CAT+=(A11Y); HIT_LABEL+=("no focus-visible state"); HIT_COUNT+=("0"); HIT_FIX+=("Add focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-accent. See accessibility-humanized.md."); HIT_SAMPLE+=(""); } || printf "  ${G}✓${N} [A11Y] custom focus-visible present\n"
scan A11Y "color-only state (no underline/icon)" 'text-(red|green|blue|yellow)-[0-9]+\b(?!.*aria-)' 1 \
"Don't rely on color alone for state. Add icon or text label."

# ╔══ Compute totals
TOTAL=0; TOTAL_MAX=0
for i in "${!CAT_NAMES[@]}"; do
  TOTAL=$((TOTAL + CAT_SCORES[$i]))
  TOTAL_MAX=$((TOTAL_MAX + CAT_MAX[$i]))
done

echo
echo "─────────────────────────────────────────────────────────────"
echo "${B}Score by category${N}"
for i in "${!CAT_NAMES[@]}"; do
  pct=$((CAT_SCORES[$i] * 100 / CAT_MAX[$i]))
  if   [[ $pct -ge 80 ]]; then col=$G
  elif [[ $pct -ge 50 ]]; then col=$Y
  else                          col=$R; fi
  printf "  %-14s ${col}%3s/%-3s${N}  ${D}(%s%%)${N}\n" "${CAT_NAMES[$i]}" "${CAT_SCORES[$i]}" "${CAT_MAX[$i]}" "$pct"
done

PCT=$((TOTAL * 100 / TOTAL_MAX))
echo "─────────────────────────────────────────────────────────────"
if   [[ $PCT -ge 85 ]]; then VERDICT="${G}✅ feels human — ship it${N}"
elif [[ $PCT -ge 70 ]]; then VERDICT="${G}✔︎ humanized, minor polish remaining${N}"
elif [[ $PCT -ge 50 ]]; then VERDICT="${Y}⚠️  decent, still some AI smell — one more pass${N}"
elif [[ $PCT -ge 30 ]]; then VERDICT="${Y}⚠️  vibe-coded vibes — refactor visible${N}"
else                          VERDICT="${R}❌ heavily vibe-coded — restart from Phase 0 (re-roll DNA)${N}"; fi

printf "  ${B}TOTAL: %s/%s   (%s%%)${N}\n  %s\n\n" "$TOTAL" "$TOTAL_MAX" "$PCT" "$VERDICT"

# ╔══ --fix mode: actionable recommendations
if [[ $FIX -eq 1 && ${#HIT_LABEL[@]} -gt 0 ]]; then
  echo "${B}▸ Recommended fixes (in priority order)${N}"
  for i in "${!HIT_LABEL[@]}"; do
    printf "\n  ${R}%2s.${N} [${B}%s${N}] %s\n" "$((i+1))" "${HIT_CAT[$i]}" "${HIT_LABEL[$i]}"
    printf "      ${G}→${N} ${HIT_FIX[$i]}\n"
    [[ -n "${HIT_SAMPLE[$i]}" ]] && printf "      ${D}example: ${HIT_SAMPLE[$i]}${N}\n"
  done
  echo
fi

# ╔══ --report mode: write Markdown
if [[ -n "$REPORT" ]]; then
  {
    echo "# humanized-frontend audit report"
    echo "_Target: \`$TARGET\` · Date: $(date '+%Y-%m-%d %H:%M')_"
    echo
    echo "## Score: **$TOTAL / $TOTAL_MAX** ($PCT%)"
    echo
    echo "$(echo "$VERDICT" | sed 's/\x1b\[[0-9;]*m//g')"
    echo
    echo "## By category"
    echo "| Category | Score | % |"
    echo "|---|---|---|"
    for i in "${!CAT_NAMES[@]}"; do
      pct=$((CAT_SCORES[$i] * 100 / CAT_MAX[$i]))
      echo "| ${CAT_NAMES[$i]} | ${CAT_SCORES[$i]} / ${CAT_MAX[$i]} | $pct% |"
    done
    if [[ ${#HIT_LABEL[@]} -gt 0 ]]; then
      echo
      echo "## Issues & Fixes"
      for i in "${!HIT_LABEL[@]}"; do
        echo
        echo "### ${HIT_CAT[$i]} — ${HIT_LABEL[$i]}"
        [[ "${HIT_COUNT[$i]}" != "0" ]] && echo "- **Matches:** ${HIT_COUNT[$i]}"
        echo "- **Fix:** ${HIT_FIX[$i]}"
        [[ -n "${HIT_SAMPLE[$i]}" ]] && echo "- **Example:** \`${HIT_SAMPLE[$i]//\`/\\\`}\`"
      done
    fi
    echo
    echo "---"
    echo "_Generated by humanized-frontend audit v2.1_"
  } > "$REPORT"
  echo "  📄 Report written to ${B}$REPORT${N}"
fi

# ╔══ --json
if [[ $JSON -eq 1 ]]; then
  echo "{"
  echo "  \"target\": \"$TARGET\","
  echo "  \"total\": $TOTAL,"
  echo "  \"max\": $TOTAL_MAX,"
  echo "  \"percent\": $PCT,"
  echo "  \"categories\": {"
  for i in "${!CAT_NAMES[@]}"; do
    sep=","; [[ $i -eq $((${#CAT_NAMES[@]}-1)) ]] && sep=""
    echo "    \"${CAT_NAMES[$i]}\": { \"score\": ${CAT_SCORES[$i]}, \"max\": ${CAT_MAX[$i]} }$sep"
  done
  echo "  },"
  echo "  \"issues\": ${#HIT_LABEL[@]}"
  echo "}"
fi

echo "  ${D}Next: bash audit.sh $TARGET --fix    or    --report report.md${N}"
