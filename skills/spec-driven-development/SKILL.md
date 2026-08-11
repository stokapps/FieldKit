---
name: spec-driven-development
description: Manages the full lifecycle of spec-driven development — writing specs, deriving implementation plans, and critically, closing the loop after implementation by reconciling the spec with what was actually built and archiving the finished plan to docs/implemented/. Use this skill whenever the user mentions specs, specifications, implementation plans, design docs, or a docs/specs or docs/plans folder. Use it especially when implementation of a planned feature finishes, when the user says something is "done", "shipped", "implemented", or "all tasks complete", when a PR for planned work is about to merge, when the user starts a new plan while older plans are still sitting unarchived, or when they ask to audit, clean up, or reconcile stale plans and drifting specs. Do not wait to be asked to close out a plan — completed implementation is itself the trigger.
---

# Spec-Driven Development

Specs and plans decay for a predictable reason: writing them is front-loaded and closing them out is back-loaded. By the time the code works, the motivation to update documentation is gone, so plans pile up in `docs/plans/` and specs quietly drift from reality until nobody trusts them.

This skill treats **closeout as part of implementation, not as follow-up work**. A feature is not done when the code passes tests. It is done when the spec describes the system as it now exists and the plan has been archived.

## The two document types

These have genuinely different jobs, and most spec rot comes from blurring them.

| | **Spec** (`docs/specs/`) | **Plan** (`docs/plans/`) |
|---|---|---|
| Answers | *What does this do and why?* | *What work gets us there?* |
| Tense | Present — describes the system as it is | Imperative/future — describes work to do |
| Lifespan | Permanent, continuously updated | Ephemeral, archived on completion |
| Contains | Behaviour, contracts, data shapes, constraints, decisions | Tasks, sequencing, files to touch, risks |
| Test | Would a new engineer understand the feature from this alone? | Could someone execute this without guessing? |

A spec should never contain a task list. A plan should never be the only place a design decision is recorded — if it matters after the work ships, it belongs in the spec.

## Layout

```
docs/
├── specs/                    # living documents, one per feature/capability
│   └── auth-sessions.md
├── plans/                    # active work only
│   └── 2026-07-20-auth-session-refresh.md
└── implemented/              # archived plans, immutable after archival
    └── 2026-07-20-auth-session-refresh.md
```

Adapt to whatever the repo already uses rather than imposing this — if plans live in `.claude/plans/` or `design/`, keep them there and just add the `implemented/` sibling. Check for an existing convention before creating folders.

## Workflow

### 1. Writing a spec

Use `assets/spec-template.md`. Write it in present tense from the start, as though the feature already exists — this is what makes it survivable later, because closeout becomes editing rather than rewriting.

Keep the spec free of implementation sequencing. "The session token refreshes 60 seconds before expiry" belongs in the spec; "add refresh logic to `useSession` in week 2" does not.

### 2. Deriving a plan

Use `assets/plan-template.md`. Every plan carries frontmatter pointing at the spec it implements:

```yaml
---
spec: docs/specs/auth-sessions.md
status: in-progress
created: 2026-07-20
---
```

That link is what makes closeout mechanical instead of archaeological. Never create a plan without it. If a plan has no spec, either write the spec first or the work is small enough that it does not need a plan.

### 3. Implementing

Keep task checkboxes current as work proceeds. When implementation deviates from the plan — and it usually does — note it in the plan's **Deviations** section *as it happens*, with one line of reasoning. Reconstructing "why did we do it this way" from a diff three weeks later is the expensive failure mode this prevents.

### 4. Closeout — the part that actually matters

Trigger closeout when any of these happen, without being asked:

- All tasks in a plan are checked off
- The user says the feature is done, shipped, merged, or working
- A PR implementing a planned feature is ready to merge
- The user asks to start a *new* plan while an unarchived completed plan exists
- The user explicitly asks to reconcile, audit, or clean up docs

Then follow `references/closeout.md`, which walks through verification, spec reconciliation, and archival in order. Read it at this point rather than working from memory — the reconciliation step in particular has a specific method for catching drift that is easy to shortcut into something useless.

The short version:

1. **Verify** the work is genuinely complete — read the code, don't trust the checkboxes
2. **Reconcile** the spec against what was actually built, section by section
3. **Record** deviations in the plan and mark it `implemented`
4. **Archive** with `git mv` so history follows the file
5. **Report** what changed in the spec, so the user can sanity-check the reconciliation

### 5. Auditing accumulated plans

When asked to clean up, or when `docs/plans/` clearly holds finished work, run the audit in `references/audit.md`. It classifies each stale plan as implemented / partially implemented / abandoned / superseded, because these need different handling — and a partially implemented plan silently archived is worse than one left lying around.

## Principles worth holding onto

**The spec is the source of truth; the code is the evidence.** When they disagree during reconciliation, the code wins on *what is true* — but flag it, because sometimes the drift is a bug rather than a decision. "The spec says tokens refresh at 60s, the code refreshes at 30s" is a question for the user, not something to silently overwrite.

**Reconciliation means editing, not appending.** Adding "Update: we changed X" to the bottom of a spec is how specs become unreadable. Edit the affected sections so the document reads as a coherent present-tense description, then note the change in a single changelog line at the bottom.

**Deviations are the most valuable thing in an archived plan.** The tasks are worthless after the fact — the record of *where reality diverged from intent and why* is what people come back for.

**Never delete a plan.** Archive it. The plan plus its deviations is the closest thing to a decision log most repos have.

## Bundled files

- `assets/spec-template.md` — spec skeleton with frontmatter
- `assets/plan-template.md` — plan skeleton with spec link, tasks, deviations
- `references/closeout.md` — the closeout procedure, step by step
- `references/audit.md` — triaging plans that have already piled up
