---
name: humanized-frontend
description: "Anti-vibe-coded frontend design system with a Design DNA engine that produces a UNIQUE design every run (25 systems × 50 palettes × 40 type pairings × 44 niche playbooks = 10B+ combos). Use when building, designing, reviewing or refactoring websites, landing pages, SaaS, portfolios, e-commerce, dashboards, blogs in any stack (HTML, React, Next.js, Vue, Svelte, Tailwind, shadcn/ui). Triggers: humanize UI, anti-AI design, unique landing, niche-aware design, fintech site, wellness site, indie hacker site, crypto site, restaurant site, dev-tool site, brutalism, editorial, swiss minimal, art deco, y2k, terminal UI, organic eco, kinfolk, vaporwave, japanese ma, riso print, blueprint, monochrome noir, replace heroicons, kill purple gradient, humanize copy, em dash removal, real testimonials, audit ai look, accessibility humanized, focus states, prefers-reduced-motion, contrast WCAG, creative dark mode, mobile touch feel, touch targets, safe-area, soul pass, micro-imperfections, signature element, founder anecdote, motion physics, framer motion, gsap, springs, stagger, magnetic CTA, layered shadows, grain noise texture, neobrutalism, glassmorphism, design tokens, scalable AI design system, css variables, tailwind v4. Output is always opinionated, niche-appropriate, accessible, mobile-tactile, motion-aware, texture-rich, token-driven and visually distinct from any other site this skill has produced. Includes prompts for Claude Code, Codex, Cursor, v0, Lovable, Bolt."
argument-hint: "[dna|brief|audit|prompt|review|build] <niche or path>"
license: MIT
author: Edwar Bechara
version: 2.2.0
---

# Humanized Frontend — Anti-Vibe-Coded Design Skill

> "AI gives you speed. You give it soul. The DNA engine guarantees no two souls look alike."

This skill makes AI-built websites feel **hand-made, opinionated, niche-appropriate and visually unique**. The core innovation is the **Design DNA engine**: every invocation generates a different valid combination from a curated library, biased by the project's niche.

## ⚠️ MANDATORY First Step — Generate Design DNA

**Before designing anything**, run:

```bash
bash ./scripts/dna.sh <niche> [seed]
# examples:
bash ./scripts/dna.sh fintech
bash ./scripts/dna.sh wellness-yoga 42
bash ./scripts/dna.sh auto              # random niche, random seed
bash ./scripts/dna.sh --json saas-b2b   # machine-readable
bash ./scripts/dna.sh --list            # all 44 niches
```

The output is a Markdown brief with 8 locked-in slots: **system, palette (4 hex), typography pair, surface treatment, motion, layout, signature element, copy tone**. Treat it as a contract — do not deviate.

**Why:** without this step, you'll fall back to defaults and every project will look the same. The whole point of this skill is variation.

## When to Use

Load this skill **before** any of:
- Designing a landing, SaaS, portfolio, blog, dashboard, e-commerce or marketing site.
- Refactoring a UI that "looks AI-generated".
- Writing/editing UI copy that sounds robotic.
- Generating prompts for v0, Cursor, Codex, Lovable, Bolt where the goal is uniqueness.
- Pre-publish audit (`scripts/audit.sh`).

## When NOT to Use

- Strict brand systems (Material, Apple HIG, Carbon) — follow those.
- Internal admin tooling where neutral default is intentional.
- Backend / CLI work.

---

## Core Philosophy

1. **Niche dictates language.** A fintech site speaks Swiss. A coffee roaster whispers Kinfolk. A crypto tool clicks in Terminal. The DNA engine enforces this.
2. **Variation is the brand.** If two sites built with this skill look alike, the skill failed. The DNA picks ONE of ~10 billion combos.
3. **Imperfection = authenticity.** Off-grid 4–8px, hand-drawn arrow, real photo of the founder.
4. **Story > features.** Anecdotes, opinions, friction beat benefit bullets.
5. **You ship the last 10%.** The signature element + manual soul pass.
6. **Test on a non-techie.** "Esto se ve diferente y me gusta" = win.

---

## The 7-Phase Pipeline

### Phase 0 — Generate Design DNA  ⭐ NEW & MANDATORY
```bash
bash scripts/dna.sh <niche> [seed]
```
Save the output. The 8 slots are locked for the rest of the project.

### Phase 1 — Brief & Strategy
Fill [assets/brief-template.md](./assets/brief-template.md). Combine with the DNA from Phase 0 — they reinforce each other.

### Phase 1.5 — Patch Design Tokens (lock the AI's freedom) ⭐ NEW in v2.2
Open [assets/design-tokens.css](./assets/design-tokens.css) and replace the 4 marked palette colors and 2 fonts with the DNA values. Pick `--radius-default`, `--shadow-default`, `--ease-default`, `--noise-opacity` from the per-DNA table in [assets/design-tokens.md](./assets/design-tokens.md). Import this file FIRST in your global CSS. Then paste the "HARD CONSTRAINTS" block (in design-tokens.md) into every prompt to lock the AI to your tokens.

### Phase 2 — Visual Design
1. Open [references/design-systems.md](./references/design-systems.md) and read the section for your DNA system.
2. Open [references/niche-playbooks.md](./references/niche-playbooks.md) for niche must-haves and signature elements.
3. Apply the 4-color palette and type pair exactly as DNA specified (now via tokens from Phase 1.5).
4. Apply [references/texture-and-shadows.md](./references/texture-and-shadows.md): noise overlay (3-10% per DNA), layered shadows (NOT shadow-xl), per-niche material textures (paper/linen/blueprint/dotgrid/halftone/scanlines).
5. Use [assets/tailwind-humanized-config.md](./assets/tailwind-humanized-config.md) as a Tailwind starter (swap colors/fonts to DNA values).

### Phase 3 — Copy
Apply [references/copywriting-humanizer.md](./references/copywriting-humanizer.md) (12 universal rules, 2026 cliché detector, before/after library, 12 tone recipes mapped to DNA, rules per product type B2B/B2C/indie/creative, founder-anecdote framework, rhythm patterns). Tone = DNA's copy-tone slot.

### Phase 4 — Code Generation
Use [references/prompts-library.md](./references/prompts-library.md). Every prompt has a `{{DNA}}` placeholder — paste the Phase 0 output there. Bake [references/accessibility-humanized.md](./references/accessibility-humanized.md), [references/mobile-touch-feel.md](./references/mobile-touch-feel.md), [references/motion-physics.md](./references/motion-physics.md) and the design-tokens HARD CONSTRAINTS block into the prompt as constraints.

### Phase 5 — Manual Soul Pass (no AI, 30–60 min)
Follow the full ritual in [references/soul-pass-guide.md](./references/soul-pass-guide.md):
- Place the **signature element** from DNA (see per-signature placement guide).
- Apply at least **6 of 10 micro-imperfections** (rotation, off-grid nudge, inconsistent radii, variable line-height, asymmetric padding, hand-tweaked sizes, etc.).
- Add one real photo, one founder anecdote, one real number, one easter egg.
- Apply [references/motion-physics.md](./references/motion-physics.md) patterns: anticipatory hover, asymmetric easing per DNA, irregular stagger delays, magnetic CTA (max 1), spring physics for modals.
- Verify [accessibility-humanized.md](./references/accessibility-humanized.md): focus-visible as a designed feature, contrast, reduced-motion, keyboard nav, semantic HTML, creative dark mode (NOT pure black).
- Verify [mobile-touch-feel.md](./references/mobile-touch-feel.md): 44px targets, active states, safe-areas, scroll-snap, correct inputmode.

### Phase 6 — Anti-Vibe-Coded Audit
```bash
bash scripts/audit.sh <path>            # quick scan
bash scripts/audit.sh <path> --fix      # prioritized fixes
bash scripts/audit.sh <path> --report report.md   # MD report
bash scripts/audit.sh <path> --json     # CI-friendly
```
8 categories scored (Color · Layout · Typography · Iconography · Copy · Imperfection · Personality · A11y) totalling 110 pts. Verdict thresholds: ≥85% ship · ≥70% minor polish · ≥50% one more pass · <50% restart from Phase 0. Cross-check with [references/anti-ai-checklist.md](./references/anti-ai-checklist.md).

---

## Quick Procedures

### "Build a humanized [niche] site from scratch"
```
1. bash scripts/dna.sh <niche>
2. Fill assets/brief-template.md
3. Pick prompt from references/prompts-library.md → paste DNA into {{DNA}}
4. Generate 3 variants → pick the one that "vibes"
5. Phase 5 (soul pass) + Phase 6 (audit)
```

### "This UI feels AI-generated, fix it"
```
1. bash scripts/audit.sh <path>          → see smells
2. bash scripts/dna.sh <niche>           → get a fresh DNA to refactor toward
3. Apply system rules from references/design-systems.md
4. Rewrite copy via references/copywriting-humanizer.md
5. Re-audit
```

### "I don't know which niche"
```
bash scripts/dna.sh auto                 → DNA picks a random niche AND combo
```

### "I want full determinism (e.g. for a client who needs to re-generate)"
```
bash scripts/dna.sh fintech 12345        → same seed = same DNA, always
```

---

## Compatibility

| Tool                | How to use                                                                       |
|---------------------|----------------------------------------------------------------------------------|
| Claude Code         | Auto-loaded via `description`, or `/humanized-frontend`                          |
| Codex CLI           | Reference `SKILL.md` in `AGENTS.md` or pass as system prompt                     |
| Cursor              | Drop folder under `.cursor/rules/` or paste `SKILL.md` body in Project Rules     |
| VS Code Copilot     | Place under `.github/skills/` or `~/.agents/skills/`                             |
| v0.dev / Lovable / Bolt | Run `dna.sh` locally → paste DNA + a prompt from `prompts-library.md`        |
| Aider / Continue    | Add `SKILL.md` + DNA output to context                                           |

Dependencies: `bash` (3.2+, macOS default works) + `grep`. No Python, no npm.

---

## Files

- [SKILL.md](./SKILL.md) — this file
- [scripts/dna.sh](./scripts/dna.sh) — **Design DNA generator (start here)**
- [scripts/audit.sh](./scripts/audit.sh) — vibe-coded smell scanner
- [references/design-systems.md](./references/design-systems.md) — 25 design systems
- [references/niche-playbooks.md](./references/niche-playbooks.md) — 30+ niche conventions + signature elements
- [references/design-principles.md](./references/design-principles.md) — universal anti-AI principles
- [references/copywriting-humanizer.md](./references/copywriting-humanizer.md) — 12 rules, cliché detector, before/after, tone recipes, founder anecdote
- [references/motion-physics.md](./references/motion-physics.md) — Framer Motion + GSAP + CSS, 8 easings, anticipatory hover, magnetic CTA, irregular stagger, spring modals
- [references/texture-and-shadows.md](./references/texture-and-shadows.md) — grain/noise overlay, layered studio shadows, paper/linen/blueprint/halftone, glassmorphism done right
- [references/soul-pass-guide.md](./references/soul-pass-guide.md) — Phase 5 ritual: signature placement, 10 micro-imperfections, custom easings
- [references/accessibility-humanized.md](./references/accessibility-humanized.md) — creative focus-visible, real contrast, creative dark modes, reduced-motion, keyboard nav
- [references/mobile-touch-feel.md](./references/mobile-touch-feel.md) — 44px targets, active states, safe-areas, mobile typography, scroll-snap
- [references/anti-ai-checklist.md](./references/anti-ai-checklist.md) — pre-publish audit
- [references/prompts-library.md](./references/prompts-library.md) — DNA-aware prompts for Claude/Codex/Cursor/v0
- [assets/design-tokens.css](./assets/design-tokens.css) — ⭐ strict CSS-variable architecture (palette/type/spacing/radii/shadows/easings/durations)
- [assets/design-tokens.md](./assets/design-tokens.md) — token philosophy + per-DNA defaults + HARD CONSTRAINTS prompt block for AI
- [assets/brief-template.md](./assets/brief-template.md) — strategy brief
- [assets/tailwind-humanized-config.md](./assets/tailwind-humanized-config.md) — drop-in tokens

---

## Creed

> If two sites built with this skill look alike, the skill failed.
> If a non-techie can't tell your site was AI-built, the skill won.
