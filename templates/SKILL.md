---
# Copy this folder to skills/<your-skill-name>/ and edit the fields below.
# `name` and `description` are the only fields the open standard requires.

# name: lowercase-with-hyphens, ≤ 64 chars. Cannot contain "claude" or "anthropic".
# If omitted, tools fall back to the directory name.
name: your-skill-name

# description: the single most important field — it's how Claude decides when to use
# the skill. Say BOTH what the skill does AND when to use it, and lean slightly
# "pushy" on the triggers, because skills are more often under-triggered than over-.
# ≤ 1024 chars.
description: What this skill does, in one sentence. Use this whenever the user <describes the situations, phrases, and file types that should trigger it, even when they don't name the skill explicitly>.
---

# Your Skill Name

One or two sentences on what this skill is for and the outcome it produces.

## Instructions

Give Claude clear, step-by-step guidance. Prefer the imperative ("Read the file", "Run
the script") and explain *why* a step matters when the reason isn't obvious — a model that
understands the intent handles edge cases far better than one following rote rules.

1. First step.
2. Second step.
3. …

## Examples

Concrete examples are one of the highest-leverage things you can add.

**Input:** <a realistic request>

**Output:** <what a good result looks like>

## Supporting files (optional)

Keep this SKILL.md focused (aim for under ~500 lines). Move long reference material,
large examples, or API docs into sibling files and point to them here, so they only load
into context when they're actually needed:

- For detailed rules, see [references/details.md](references/details.md)
- Bundle runnable helpers under `scripts/` and tell Claude when to run them.

Delete any section you don't need — a short, sharp skill beats a long, vague one.
