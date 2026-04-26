#!/usr/bin/env bash
# humanized-frontend :: vibe-coded smell detector
# Usage: bash audit.sh <path>
# Scans HTML/JSX/TSX/Vue/Svelte/CSS files for common AI-look smells and prints a score.

set -uo pipefail

TARGET="${1:-.}"
if [[ ! -e "$TARGET" ]]; then
  echo "❌ path not found: $TARGET" >&2
  exit 1
fi

# colors
R=$'\e[31m'; G=$'\e[32m'; Y=$'\e[33m'; B=$'\e[1m'; N=$'\e[0m'

EXTS='\.(html|jsx|tsx|vue|svelte|astro|css|mdx|md)$'

scan() {
  local label="$1" pattern="$2" weight="$3"
  local count
  count=$(grep -REn --include='*.html' --include='*.jsx' --include='*.tsx' \
                    --include='*.vue' --include='*.svelte' --include='*.astro' \
                    --include='*.css' --include='*.mdx' --include='*.md' \
                    -E "$pattern" "$TARGET" 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$count" -gt 0 ]]; then
    printf "  ${R}✗${N} %-45s %s match(es)  ${Y}[-%s]${N}\n" "$label" "$count" "$weight"
    SCORE=$((SCORE - weight))
    HITS=$((HITS + 1))
  else
    printf "  ${G}✓${N} %s\n" "$label"
  fi
}

echo "${B}humanized-frontend audit${N}  ::  scanning ${B}$TARGET${N}"
echo "------------------------------------------------------------"

SCORE=100
HITS=0

echo "${B}Visual smells${N}"
scan "purple/pink/blue gradients"        'from-(purple|pink|fuchsia|violet|indigo|blue)-[0-9]+|to-(purple|pink|fuchsia|violet|indigo)-[0-9]+' 8
scan "glassmorphism (backdrop-blur)"      'backdrop-blur' 6
scan "shadow-xl + rounded-2xl combo"      '(shadow-(xl|2xl)).*(rounded-(2xl|3xl))|rounded-(2xl|3xl).*(shadow-(xl|2xl))' 5
scan "universal rounded-2xl/3xl"          'rounded-(2xl|3xl)' 2
scan "pure white background"              'bg-white\b|background:\s*#fff(fff)?\b|background-color:\s*#fff(fff)?\b' 3
scan "soft glow/elevation shadows"        'shadow-(xl|2xl|inner)' 2

echo
echo "${B}Iconography${N}"
scan "Heroicons import"                   '@heroicons/react|heroicons' 5
scan "Lucide default usage"               'from\s+["'\'']lucide-react["'\'']' 4

echo
echo "${B}Typography / Copy${N}"
scan "em dashes (—)"                      '—' 6
scan "AI buzzwords"                       '\b(unleash|empower|seamless|seamlessly|elevate|leverage|robust|holistic|game-changer|revolutionary|cutting-edge|synergy|transform your|take it to the next level)\b' 7
scan "generic CTA copy"                   '>(Get Started|Learn More|Sign Up Now|Book a Demo|Try for Free)<' 3
scan "Inter as headline font"             'font-(display|heading|serif).*Inter|h[1-3].*font-\[?["\x27]?Inter' 2

echo
echo "${B}Layout${N}"
scan "everything centered (text-center spam)"  '(text-center.*){4,}' 2
scan "default shadcn primitives untouched"     'cn\(buttonVariants\(\)\)' 1

echo "------------------------------------------------------------"
[[ $SCORE -lt 0 ]] && SCORE=0

if   [[ $SCORE -ge 80 ]]; then VERDICT="${G}✅ feels human — ship it${N}"
elif [[ $SCORE -ge 60 ]]; then VERDICT="${Y}⚠️  decent, still some AI smell — one more pass${N}"
elif [[ $SCORE -ge 40 ]]; then VERDICT="${Y}⚠️  vibe-coded vibes — refactor visible${N}"
else                            VERDICT="${R}❌ heavily vibe-coded — restart from Phase 5${N}"
fi

printf "\n  Score: ${B}%s/100${N}   (%s smell categories triggered)\n" "$SCORE" "$HITS"
printf "  %s\n\n" "$VERDICT"
echo "  Next: open references/anti-ai-checklist.md and fix every ✗ above."
