# humanized-frontend

> **Anti-vibe-coded design skill for AI coding agents.** With a Design DNA engine that produces a unique design every run — 25 systems × 50 palettes × 40 type pairings × 30+ niche playbooks = **>10 billion combinations**.

By [saltbalente](https://github.com/saltbalente) · MIT

---

## The problem

In 2026 every AI-built website looks the same: purple gradients, glossy cards, Heroicons, em dashes, "Empower your workflow" copy. Even "humanized" skills tend to produce the same humanized look on every project.

## The solution

Two layers:

1. **Anti-AI principles** — rules that strip the AI smell (kill gradients, kill Heroicons, kill em dashes, add real photos, add opinion).
2. **Design DNA engine** — a deterministic-or-random generator that picks a unique combination of `system × palette × typography × surface × motion × layout × signature × tone`, biased by your niche. Two projects in the same niche won't look alike.

## Quickstart

```bash
git clone https://github.com/saltbalente/humanized-frontend.git
cd humanized-frontend

# 1. Generate a unique design DNA for your project
bash scripts/dna.sh fintech              # niche-aware
bash scripts/dna.sh wellness-yoga 42     # deterministic with seed
bash scripts/dna.sh auto                 # surprise me

# 2. Paste DNA into your AI coding tool with a prompt from references/prompts-library.md
# 3. Build
# 4. Audit
bash scripts/audit.sh ./my-app           # vibe-coded smell scanner
```

## Install as a skill

| Tool                | Command |
|---------------------|---------|
| Claude Code / Desktop | `cp -r humanized-frontend ~/.claude/skills/` |
| VS Code Copilot     | `cp -r humanized-frontend ~/.agents/skills/` (or `.github/skills/`) |
| Cursor              | `cp -r humanized-frontend .cursor/rules/` |
| Codex CLI           | Reference `SKILL.md` from your project's `AGENTS.md` |
| v0 / Lovable / Bolt | Run `dna.sh` locally → paste DNA + prompt into the chat |

## What's inside

```
humanized-frontend/
├── SKILL.md                              # entry point for AI agents
├── scripts/
│   ├── dna.sh                            # ⭐ Design DNA generator
│   └── audit.sh                          # vibe-coded smell scanner
├── references/
│   ├── design-systems.md                 # 25 design languages
│   ├── niche-playbooks.md                # 30+ niches × must-haves × signatures
│   ├── design-principles.md              # universal anti-AI rules
│   ├── copywriting-humanizer.md          # voice & copy rules
│   ├── anti-ai-checklist.md              # 30+ pre-publish checks
│   └── prompts-library.md                # DNA-aware prompts (Claude/Codex/Cursor/v0)
└── assets/
    ├── brief-template.md                 # strategy brief
    └── tailwind-humanized-config.md      # drop-in design tokens
```

## Design systems available
`soft-brutalism` · `editorial-magazine` · `swiss-minimal` · `neo-memphis` · `y2k-revival` · `terminal-cli` · `japanese-ma` · `art-deco-modern` · `risograph-print` · `vaporwave-neo-pop` · `cyberpunk-neon` · `organic-eco` · `raw-brutalism` · `kinfolk-warm` · `sci-fi-spatial` · `retro-arcade` · `luxury-quiet` · `handmade-zine` · `anti-design-raw` · `neo-skeuomorphic` · `tactile-paper` · `constructivist` · `monochrome-noir` · `blueprint-technical` · `scandi-soft`

## Niches with custom playbooks
`fintech` · `wellness-yoga` · `saas-b2b` · `crypto-web3` · `indie-hacker` · `music-artist` · `edtech` · `real-estate` · `healthcare` · `creative-agency` · `artist-portfolio` · `dev-tools` · `ai-startup` · `nonprofit` · `news-media` · `photography` · `fitness-gym` · `beauty-cosmetics` · `travel` · `podcast` · `newsletter` · `legal` · `consulting` · `sustainability` · `kids-toys` · `luxury-fashion` · `automotive` · `esports-gaming` · `pet-brand` · `hardware-product` · `marketplace` · `dating-app` · `productivity` · `publishing-books` · `film-video` · `architecture` · `restaurant-food` · `coffee-roaster` · `winery` · `barbershop` · `tattoo-studio` · `fashion-ecommerce` · `religious-spiritual` · `law-firm`

Run `bash scripts/dna.sh --list` for the live list.

## Example DNA outputs

**`bash scripts/dna.sh fintech 1`** →
> System: `blueprint-technical` · Palette: `charcoal-gold` · Type: `Unica One + Roboto Mono` · Signature: `running system clock in footer`

**`bash scripts/dna.sh fintech 2`** →
> System: `luxury-quiet` · Palette: `nordic-fjord` · Type: `Syne + Inter` · Signature: `live edit-mode cursor on text`

**`bash scripts/dna.sh wellness-yoga 99`** →
> System: `kinfolk-warm` · Palette: `dusty-rose` · Type: `Major Mono Display + Inter` · Signature: `tiny handwritten margin notes`

Same niche, three completely different looks. That's the point.

## Requirements

- `bash` 3.2+ (macOS default works)
- `grep` with `-E` (BSD or GNU)
- No Python, no Node, no installs.

## Contributing

PRs welcome to add more design systems, palettes, type pairings, or niche playbooks. Keep entries concise; the discovery surface is the `description` field in `SKILL.md`.

## License

MIT — use it commercially, fork it, remix it. Credit appreciated, not required.

## Creed

> If two sites built with this skill look alike, the skill failed.
> If a non-techie can't tell your site was AI-built, the skill won.

— saltbalente
