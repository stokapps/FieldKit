# Closeout Procedure

Run this when a plan's implementation is complete. It takes a few minutes and it is the entire reason this skill exists — skipping to step 4 produces an archived plan and a lying spec, which is worse than doing nothing.

## Step 1 — Verify completion

Do not trust checkboxes. Confirm against the repo:

- Read the files the plan said it would touch. Do the described changes exist?
- Are there unchecked tasks? If so, ask whether they were dropped deliberately or forgotten. A dropped task is a deviation; a forgotten task means closeout is premature.
- Do tests exist and pass for the new behaviour?
- Is the work merged, or on a branch? Branch work can be closed out, but say so in the report.

If the work is partially complete, stop and use the partial-implementation path in `audit.md` instead.

## Step 2 — Reconcile the spec

This is the step that gets shortcut. The method matters.

**Read the actual implementation first, then the spec — in that order.** Reading the spec first primes you to confirm it. Reading the code first means you notice what the spec fails to mention.

Walk the spec section by section and classify each:

| Finding | Action |
|---|---|
| Still accurate | Leave it alone |
| Describes intent that changed during implementation | Rewrite to describe what exists |
| Describes something that was never built | Remove it, or move it to a "Not implemented" / "Future" section with a note |
| Behaviour exists in code but is absent from the spec | Add it — this is the most common gap |
| Code contradicts the spec and it looks unintentional | **Do not silently rewrite.** Flag it to the user as a possible bug |

Then check for what the spec structurally lacks. Implementation almost always surfaces things the original spec had no section for:

- New or changed API contracts, function signatures, event shapes
- Data model / schema changes, migrations
- Configuration, environment variables, feature flags
- Error and edge-case behaviour discovered during implementation
- Dependencies added
- Performance or security constraints that emerged
- Explicit non-goals that got settled during the work

Write everything in present tense describing the current system. The spec should read as if it were written fresh today by someone looking at the working code.

Finally, add one line to the spec's changelog table — date, what changed, link to the archived plan. One line, not a narrative.

## Step 3 — Finalise the plan

Update the plan's frontmatter:

```yaml
status: implemented
completed: 2026-07-25
commits: [abc1234, def5678]     # or PR link
```

Fill in the **Deviations from plan** section properly. For each divergence: what the plan said, what was actually done, why. If deviations were logged during implementation, tidy them; if not, reconstruct them now from the diff — this is the part future readers will actually want.

If nothing deviated, write "None" explicitly. An empty section reads like an oversight.

## Step 4 — Archive

```bash
git mv docs/plans/2026-07-20-auth-session-refresh.md docs/implemented/
```

Use `git mv` rather than a plain move so history follows the file. Create `docs/implemented/` if it does not exist. Keep the filename unchanged — the date prefix is what makes the archive browsable.

Archived plans are immutable. If the feature changes later, that is a new plan against the updated spec, not an edit to a closed one.

## Step 5 — Report

Tell the user, concisely:

- Which spec was updated and **which sections changed** — they need to be able to spot a bad reconciliation
- Any contradictions flagged for their judgement (step 2) — call these out clearly, they are the ones that need a decision
- Which plan was archived and where it went
- Anything left open — unchecked tasks, follow-up work, spec sections marked as future

Then offer to commit the doc changes alongside the implementation if the work isn't already committed. Keeping the doc update in the same commit or PR as the code is what stops the next round of drift.
