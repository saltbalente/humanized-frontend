---
name: humanized-frontend
description: "Anti-vibe-coded frontend design system. Use when building, designing, reviewing, refactoring or auditing websites, landing pages, SaaS UIs, portfolios or any frontend (HTML/CSS, React, Next.js, Vue, Svelte, Tailwind, shadcn/ui) that should NOT look AI-generated. Triggers: humanize UI, anti-AI design, brutalism suave, soft brutalism, hand-made web, remove AI look, vibe-coded, controlled chaos, asymmetry, intentional imperfection, organic design, warm SaaS, premium landing 2026, replace heroicons, kill purple gradient, humanize copy, em dash removal, real testimonials. Provides: design principles, anti-AI checklist, prompt library for Claude Code / Codex / Cursor / v0, copywriting humanizer rules, Tailwind tokens, audit script. Covers wireframe → visual → copy → code → QA pipeline."
argument-hint: "[audit|brief|prompt|review|build] <target file or description>"
license: MIT
author: Edwar Bechara
version: 1.0.0
---

# Humanized Frontend — Anti-Vibe-Coded Design Skill

> "AI gives you speed. You give it soul." — Edwar Bechara

This skill turns generic AI-generated interfaces into websites that feel **hand-made, opinionated and alive**. It is portable across Claude Code, Codex, Cursor, v0, VS Code Copilot and any agentic IDE.

## When to Use

Load this skill **before** any of the following tasks:

- Designing or building a landing page, SaaS UI, portfolio, blog, dashboard or marketing site.
- Reviewing/refactoring an existing UI that "looks AI-generated" (purple gradients, glossy cards, Heroicons everywhere, em dashes, perfect symmetry).
- Writing or editing copy that sounds robotic, motivational or corporate-generic.
- Generating prompts for v0, Claude Design, Cursor, Codex or Midjourney where the goal is a **human** result.
- Running a pre-publish audit ("vibe-coded check").

## When NOT to Use

- Internal admin tools where neutral/corporate look is intentional.
- Strict brand systems (Material, Apple HIG, IBM Carbon) — follow those instead.
- Backend-only or CLI work.

---

## Core Philosophy (memorize)

1. **Imperfection = authenticity.** A 4–8px off-grid element, a hand-drawn arrow, a real photo of the founder beats any "perfect" AI layout.
2. **Story > features.** People connect with anecdotes, opinions and friction — not benefit bullets.
3. **References > vague prompts.** Never say "make it pretty". Always anchor to a real human-made site or screenshot.
4. **You ship the last 10%.** AI does 90%; the soul lives in what you add by hand.
5. **Test on a non-techie.** If your mom or a friend says "this feels different and I like it", you won.

---

## The 6-Phase Pipeline

Run phases in order. Skipping = vibe-coded result.

### Phase 1 — Brief & Strategy
Use [assets/brief-template.md](./assets/brief-template.md). Force the user (or yourself) to fill **brand-as-person**, 3 loved refs, 3 hated refs, and a personal story. Ask follow-up questions until each field has texture.

### Phase 2 — Visual Design (humanize the look)
Read [references/design-principles.md](./references/design-principles.md) for the full anti-AI design system (soft brutalism, controlled chaos, texture, asymmetry, type with character).

Apply the `Humanized Tailwind tokens` in [assets/tailwind-humanized-config.md](./assets/tailwind-humanized-config.md) instead of default shadcn/ui values.

### Phase 3 — Copy (humanize the voice)
Apply the rules in [references/copywriting-humanizer.md](./references/copywriting-humanizer.md): kill em dashes, kill motivational filler, add contractions, anecdotes, opinions, friction.

### Phase 4 — Code Generation
Use the prompt library in [references/prompts-library.md](./references/prompts-library.md). Each prompt is pre-tested for Claude Code, Codex, Cursor and v0. Always pass: target stack + reference screenshot + explicit "avoid list".

### Phase 5 — Manual Soul Pass (no AI for 30–60 min)
- Nudge 2–3 elements off-grid by 4–8px.
- Replace at least one icon with a hand-drawn SVG or emoji-as-glyph.
- Insert one real photo (founder, workspace, sketch).
- Add one easter egg or inside joke for the target audience.
- Re-write the hero headline in your own voice, out loud.

### Phase 6 — Anti-Vibe-Coded Audit
Run the audit checklist in [references/anti-ai-checklist.md](./references/anti-ai-checklist.md), or execute the automated scanner:

```bash
bash ./scripts/audit.sh <path-to-project-or-file>
```

It greps for the most common AI-look smells (purple→pink gradients, `from-purple-500`, `backdrop-blur`, `shadow-xl rounded-2xl` combos, em dashes, Heroicons imports, "Unleash / Empower / Seamless" copy, etc.) and prints a score.

---

## Quick Procedures

### "Make this UI feel human" (refactor flow)
1. Run `bash ./scripts/audit.sh <file>` → get smell list.
2. Open [references/anti-ai-checklist.md](./references/anti-ai-checklist.md) and fix every ❌.
3. Apply tokens from [assets/tailwind-humanized-config.md](./assets/tailwind-humanized-config.md).
4. Rewrite copy with [references/copywriting-humanizer.md](./references/copywriting-humanizer.md).
5. Manual soul pass (Phase 5).

### "Generate a humanized landing from scratch"
1. Fill [assets/brief-template.md](./assets/brief-template.md).
2. Pick the matching prompt in [references/prompts-library.md](./references/prompts-library.md) (`landing`, `saas-hero`, `portfolio`, `blog`).
3. Generate 3 variants. Pick the one that "vibes", not the most polished.
4. Phase 5 + Phase 6.

### "Humanize this copy block"
1. Paste copy.
2. Apply the 8 rules in [references/copywriting-humanizer.md](./references/copywriting-humanizer.md) section "Transform table".
3. Read it out loud. If you wouldn't say it to a friend at a bar, rewrite.

---

## Compatibility

| Tool          | How to invoke                                                          |
|---------------|------------------------------------------------------------------------|
| Claude Code   | Auto-loaded via `description`, or `/humanized-frontend`                |
| Codex CLI     | Reference `SKILL.md` in your AGENTS.md or pass as system prompt        |
| Cursor        | Add folder to `.cursor/rules` or paste `SKILL.md` body in Project Rules|
| VS Code Copilot | Place under `.github/skills/humanized-frontend/` or `~/.agents/skills/`|
| v0.dev        | Copy a prompt from [references/prompts-library.md](./references/prompts-library.md) into the chat |
| Aider / Continue | Add SKILL.md path to context                                        |

The skill is dependency-free except `bash` + `grep` for the audit script.

---

## Files in this skill

- [SKILL.md](./SKILL.md) — this file
- [references/design-principles.md](./references/design-principles.md) — full anti-AI design system
- [references/copywriting-humanizer.md](./references/copywriting-humanizer.md) — voice & copy rules
- [references/anti-ai-checklist.md](./references/anti-ai-checklist.md) — pre-publish audit
- [references/prompts-library.md](./references/prompts-library.md) — tested prompts for Claude/Codex/Cursor/v0
- [assets/brief-template.md](./assets/brief-template.md) — strategy brief
- [assets/tailwind-humanized-config.md](./assets/tailwind-humanized-config.md) — drop-in design tokens
- [scripts/audit.sh](./scripts/audit.sh) — vibe-coded smell detector

---

## One-line creed

> If a non-technical friend can't tell your site was built with AI, the skill worked.
