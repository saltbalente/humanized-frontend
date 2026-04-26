# humanized-frontend

Anti-vibe-coded design skill for AI coding agents. Build websites that feel hand-made, opinionated and alive — not AI-generated.

> By Edwar Bechara · MIT · v1.0.0

## What it does

Forces Claude Code, Codex, Cursor, v0 (and any agentic IDE) to stop producing the same purple-gradient-glassy-Heroicon-shadcn landing page. It bundles:

- A 6-phase pipeline (brief → visual → copy → code → soul pass → audit)
- Design principles for **soft brutalism + warm SaaS + controlled chaos**
- A copywriting humanizer (kill em dashes, kill motivational filler)
- A pre-tested prompt library for Claude Code, Codex, Cursor, v0
- Drop-in humanized Tailwind/shadcn tokens
- A bash audit script that scores your project on AI-look smells (0–100)

## Install

### Claude Code / Claude Desktop
```bash
cp -r humanized-frontend ~/.claude/skills/
```

### VS Code Copilot / generic agents
```bash
cp -r humanized-frontend ~/.agents/skills/
# or per project:
cp -r humanized-frontend .github/skills/
```

### Codex CLI
Add to your `AGENTS.md`:
```md
When working on frontend, load humanized-frontend/SKILL.md as system context.
```

### Cursor
Drop the folder under `.cursor/rules/` or paste `SKILL.md` body into Project Rules.

### v0.dev / Lovable / Bolt
Copy any prompt from `references/prompts-library.md` directly into the chat.

## Usage

```bash
# Audit any project for vibe-coded smells
bash humanized-frontend/scripts/audit.sh ./my-app

# Or just ask your agent
"use the humanized-frontend skill to refactor this hero"
"audit this landing with humanized-frontend"
"give me a humanized-frontend brief for a SaaS landing"
```

## Files

```
humanized-frontend/
├── SKILL.md                                  # entry point, loaded by agents
├── references/
│   ├── design-principles.md                  # soft brutalism, color, type, layout
│   ├── copywriting-humanizer.md              # voice & copy rules
│   ├── anti-ai-checklist.md                  # pre-publish audit
│   └── prompts-library.md                    # Claude/Codex/Cursor/v0 prompts
├── assets/
│   ├── brief-template.md                     # strategy brief
│   └── tailwind-humanized-config.md          # drop-in design tokens
└── scripts/
    └── audit.sh                              # vibe-coded smell scanner
```

## Creed

> "AI gives you speed. You give it soul."

If a non-technical friend can't tell your site was built with AI, the skill worked.
