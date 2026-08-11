# Auditing Accumulated Plans

Use this when `docs/plans/` has collected finished or half-finished work, or when the user asks to clean up docs. The goal is triage — different states need genuinely different handling, and blanket-archiving everything is how a partially implemented plan disappears without anyone noticing the missing half.

## Step 1 — Inventory

List every file in the plans directory. For each, gather:

- The spec it links to (frontmatter `spec:` field)
- Its declared status
- Task completion count (e.g. 7/9 checked)
- Last git commit date on the file — a plan untouched for months usually means work that finished or died

Do not read every plan in full yet. Frontmatter, task list, and git dates are enough to classify.

## Step 2 — Classify against the code

For each plan, check the repo for the changes it describes. Classify:

**Implemented** — the described work exists in the codebase.
→ Run the full closeout procedure (`closeout.md`) for each. Reconcile the spec, then archive.

**Partially implemented** — some tasks landed, some did not.
→ This is the case that needs care. Reconcile the spec to describe *only what actually exists*. Then either: split the remaining work into a fresh plan and archive the original, or leave the plan active with a note explaining what remains. Ask the user which — it depends on whether the remainder is still wanted.

**Abandoned** — the work was never done and is no longer wanted.
→ Do not touch the spec. Set `status: abandoned` with a one-line reason, and archive. Preserving the reasoning is worth more than the disk space.

**Superseded** — a later plan replaced this one.
→ Set `status: superseded`, link to the plan that replaced it, archive. Reconcile the spec from the successor plan, not this one.

**Orphaned** — no spec link, or the spec no longer exists.
→ Ask the user. Often the plan itself is the only surviving documentation of a feature, in which case the right move is to *create* a spec from the plan plus the current code, then archive the plan.

## Step 3 — Work through them, one at a time

Do the classification pass across everything first, present it as a table, and let the user confirm before making changes. Reconciling a dozen specs unprompted is a large uninvited diff.

Once confirmed, handle plans one at a time rather than batching — spec reconciliation needs the code read carefully for each, and batching invites shallow updates that defeat the point.

## Step 4 — Report

Summarise: how many plans archived, which specs were updated, which cases needed a judgement call, and anything still open. Flag any spec that drifted badly — repeated large drift on one spec usually means it is scoped too broadly and would be better split.
