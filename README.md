# FieldKit

**A portable kit of [Agent Skills](https://agentskills.io) for Claude and other AI agents.**

Reusable skills that help delivery work move faster — drafting solution docs, shaping
presentations, running compliance checks, and anything else you do often enough to be worth
teaching an agent once. Each skill is a small folder of instructions that teaches an agent
to do one thing well: drop it into your tool of choice and the agent picks it up
automatically when it's relevant, or you invoke it by name. This repo is a place to collect,
version, and share those skills.

> New to skills? A **skill** is just a `SKILL.md` file (plus any optional supporting files)
> with a name and a description. The agent reads the description to decide when the skill
> applies, then loads the full instructions only when it needs them. They follow the open
> [Agent Skills standard](https://agentskills.io), so the same folder works across Claude
> Code, claude.ai, the Claude API, and other tools that support it.

---

## Skills in this kit

| Skill | What it does | Triggers when… |
| :---- | :----------- | :------------- |
| [`conventional-commits`](skills/conventional-commits) | Writes clear git commit messages that follow the Conventional Commits spec. | you're committing code, want a commit message, or mention changelogs / semver. |
| [`spec-driven-development`](skills/spec-driven-development) | Manages the spec → plan → implement → closeout lifecycle, including reconciling specs with what was actually built and archiving finished plans to `docs/implemented/`. | you mention specs, implementation plans, or design docs; a planned feature ships; or stale plans need auditing. |

> `conventional-commits` ships as a working example of the SKILL.md format — skills can
> automate almost any repeatable task, from documents and decks to reviews and checklists,
> not just code. Keep it, tweak it, or delete it, then add your own with the help of
> [`templates/SKILL.md`](templates/SKILL.md) and [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Install a skill

Pick your tool below. The two fastest paths first, then tool-specific detail.

### Grab the kit

Clone once, and every skill is a folder you can copy or symlink wherever your tool expects it:

```bash
git clone https://github.com/stokapps/FieldKit.git
```

Prefer a one-liner? The community [`skills` CLI](https://www.npmjs.com/package/skills)
installs a skill straight from this repo into most tools:

```bash
# Installs into the target you choose (claude-code, cursor, …)
npx skills add stokapps/FieldKit/skills/conventional-commits
```

> `npx skills` is a third-party convenience tool, not an Anthropic product. The manual
> steps below always work and are worth understanding once.

---

### Claude Code (terminal)

Claude Code loads skills from two filesystem locations — no upload, no restart:

| Scope | Path | Available in |
| :---- | :--- | :----------- |
| **Personal** | `~/.claude/skills/<skill-name>/SKILL.md` | all your projects |
| **Project** | `<repo>/.claude/skills/<skill-name>/SKILL.md` | that repo (commit it to share with your team) |

Copy a skill into one of them:

```bash
# Personal — available everywhere
cp -r FieldKit/skills/conventional-commits ~/.claude/skills/

# …or project-scoped, checked in for your team
mkdir -p .claude/skills
cp -r FieldKit/skills/conventional-commits .claude/skills/
```

Prefer to keep a single source of truth and pull updates with `git pull`? Symlink instead
of copying:

```bash
ln -s "$(pwd)/FieldKit/skills/conventional-commits" ~/.claude/skills/conventional-commits
```

Adding a skill under an existing `~/.claude/skills/` or `.claude/skills/` takes effect in
the current session. (Creating one of those top-level folders for the very first time needs
a Claude Code restart so it can start watching it.)

**Use it:** ask something that matches the description (_"write a commit message for my
staged changes"_) and Claude loads it automatically, or invoke it directly with
`/conventional-commits`. Confirm it's registered with _"What skills are available?"_.

---

### VS Code & JetBrains (Claude Code extension)

The Claude Code extension reads the **same** directories as the terminal, so installation is
identical:

- **Personal skills** → `~/.claude/skills/` (works in every workspace).
- **Project skills** → `.claude/skills/` inside the workspace folder. Commit it and everyone
  who opens the repo in the extension gets the skill.

```bash
# From your project root, inside VS Code's integrated terminal:
mkdir -p .claude/skills
cp -r /path/to/FieldKit/skills/conventional-commits .claude/skills/
```

Then invoke skills from the Claude panel exactly as in the terminal (`/conventional-commits`,
or let Claude trigger them). No extension-specific setup is required.

> There's also a community **"Agent Skills" marketplace extension** for VS Code
> ([`formulahendry.agent-skills`](https://marketplace.visualstudio.com/items?itemName=formulahendry.agent-skills))
> that lets you browse and install skills from a UI. It's third-party — the folder-copy
> above is the official path.

---

### claude.ai (web)

Custom skills are available on **Pro, Max, Team, and Enterprise** plans with
[file creation / code execution enabled](https://support.claude.com/en/articles/12111783-create-and-edit-files-with-claude).

1. **Zip the skill.** claude.ai wants an archive that contains the skill folder:

   ```bash
   scripts/package-skill.sh skills/conventional-commits
   # -> dist/conventional-commits.zip
   ```

2. In claude.ai, open **Settings → Capabilities → Skills** (labeled **Features** on some
   plans) and **upload the `.zip`**.
3. Start a chat and ask naturally — Claude uses the skill when your request matches its
   description.

Skills uploaded here are **per-user**: each teammate uploads their own, and they don't sync
to the API or to Claude Code. See the Help Center:
[Using Skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude).

---

### Claude Desktop app

The desktop app uses the skills enabled on your **claude.ai account**. Upload the skill on
claude.ai (steps above), then manage which skills are active from **Customize** in the
Desktop sidebar. Once enabled, Claude in the desktop app applies the skill automatically
when it's relevant.

---

### Claude API

Skills run inside the [code execution tool](https://platform.claude.com/docs/en/agents-and-tools/tool-use/code-execution-tool)'s
container. Upload a custom skill through the `/v1/skills` endpoints, then reference its
`skill_id` in the request `container`:

```bash
# 1. Upload (returns a skill_id). Requires the Skills beta header.
curl https://api.anthropic.com/v1/skills \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-beta: skills-2025-10-02" \
  -F "display_title=conventional-commits" \
  -F "file=@dist/conventional-commits.zip"
```

Then in the Messages request, enable the code execution tool, add the
`anthropic-beta: skills-2025-10-02` header, and pass the skill in the `container.skills`
list by `skill_id`. Uploaded skills are **workspace-wide** (all workspace members can use
them). Note the API sandbox has **no network access** and can't install packages at
runtime. Full walkthrough:
[Using Agent Skills with the API](https://platform.claude.com/docs/en/build-with-claude/skills-guide).

---

### Cursor, Codex & other agents

Agent Skills is an **open standard**, so any tool that supports it consumes the exact same
skill folder. Two ways in:

- **Drop it in the tool's skills directory.** Many agents follow the `.claude/skills/`
  convention; check your tool's docs for the path it watches, and copy the skill folder
  there.
- **Use the cross-tool installer:** `npx skills add stokapps/FieldKit/skills/<name> -a <tool>`
  (targets include `claude-code`, `cursor`, `codex`, and more).

See [agentskills.io](https://agentskills.io) for the spec and the current list of supported
tools.

---

## Anatomy of a skill

Everything an agent needs is in the folder. Only `SKILL.md` is required:

```
conventional-commits/
├── SKILL.md              # frontmatter (name + description) and the instructions
└── references/
    └── commit-types.md   # detail loaded only when the agent needs it
```

The magic is **progressive disclosure**: the agent always sees the short `description`,
loads the `SKILL.md` body when the skill triggers, and reads bundled files like
`references/commit-types.md` only when the task calls for them — so a skill can carry a lot
of reference material at almost no cost until it's used.

```yaml
---
name: conventional-commits
description: Write clear git commit messages… Use this whenever the user is committing code…
---

# instructions the agent follows once the skill loads
```

Want to build one? Start from [`templates/SKILL.md`](templates/SKILL.md) and follow
[CONTRIBUTING.md](CONTRIBUTING.md).

---

## Repo layout

```
FieldKit/
├── README.md                  # you are here
├── CONTRIBUTING.md            # how to add a new skill
├── LICENSE                   # MIT
├── templates/
│   └── SKILL.md              # annotated starter to copy
├── scripts/
│   └── package-skill.sh      # zip a skill for claude.ai / API upload
└── skills/
    └── conventional-commits/ # example skill
        ├── SKILL.md
        └── references/
            └── commit-types.md
```

---

## A note on trust

A skill can direct an agent to run code and use tools, so install skills only from sources
you trust, and skim a skill's files before you add it. Everything here is meant to be
readable in a couple of minutes — that's the point. If you fork or extend these, keep them
free of secrets and of anything that quietly reaches out to untrusted external sources.

---

## License

[MIT](LICENSE) © 2026 Chris Stoklosa. Use these skills freely, and adapt them to your own
workflow.
