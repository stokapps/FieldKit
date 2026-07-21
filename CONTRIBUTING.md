# Adding a skill to FieldKit

Every skill in this kit lives in its own folder under [`skills/`](skills/) and follows the
open [Agent Skills](https://agentskills.io) standard, so it works across Claude Code,
claude.ai, the Claude API, and any other tool that speaks the standard.

## 1. Create the folder

Copy the starter template and rename it:

```bash
cp -r templates skills/my-new-skill
mv skills/my-new-skill/SKILL.md skills/my-new-skill/SKILL.md   # already there
```

A skill is a directory with a `SKILL.md` at its root. Anything else is optional:

```
skills/my-new-skill/
├── SKILL.md            # required — frontmatter + instructions
├── references/         # optional — docs loaded only when needed
│   └── details.md
├── scripts/            # optional — runnable helpers Claude executes
│   └── helper.py
└── assets/             # optional — templates, images, fonts used in output
```

## 2. Write `SKILL.md`

The YAML frontmatter needs two fields:

```yaml
---
name: my-new-skill
description: What it does, and when Claude should use it.
---
```

- **`name`** — lowercase letters, numbers, and hyphens; ≤ 64 characters; cannot contain
  the words `claude` or `anthropic`. Match it to the folder name.
- **`description`** — the field that decides whether the skill triggers. Say **what** it
  does **and when** to use it, and be a little generous with the triggers: skills tend to
  fire too rarely rather than too often. ≤ 1024 characters.

Keep the body focused (aim for under ~500 lines). Push long reference material into
`references/` files and link to them, so they only cost context when they're actually
read. See [`skills/conventional-commits/`](skills/conventional-commits) for a worked
example, and [`templates/SKILL.md`](templates/SKILL.md) for an annotated starting point.

## 3. List it in the README

Add a row to the **Skills in this kit** table in [`README.md`](README.md) so people can
find it.

## 4. Sanity-check it

- **In Claude Code**, point a session at this repo and ask _"What skills are available?"_,
  or invoke it directly with `/my-new-skill`.
- **Portability**: if you use Claude Code–only features (like `` !`shell command` ``
  dynamic context injection or `context: fork`), note it in the skill, since those won't
  run on claude.ai or the API.
- **Package it** for a quick upload test:
  `scripts/package-skill.sh skills/my-new-skill`.

## A note on trust

Skills can direct an agent to run code and use tools. Only include skills here that you'd
be comfortable other people running, and keep them free of secrets, tokens, and anything
that reaches out to untrusted external sources without saying so.
