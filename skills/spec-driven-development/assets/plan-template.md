---
spec: docs/specs/<feature>.md
status: proposed | in-progress | implemented | abandoned | superseded
created: YYYY-MM-DD
completed:
commits: []
---

# Implementation plan: <Feature name>

Filename convention: `YYYY-MM-DD-<short-slug>.md`

## Scope

What this plan delivers against the spec. If it implements only part of the spec, say which part — partial plans are fine, silent partial plans are not.

## Approach

The shape of the solution in a paragraph or two. Enough that a reviewer can disagree with the direction before any code is written.

## Tasks

- [ ] Task, specific enough to be unambiguous
- [ ] Include the files or modules involved where known
- [ ] Include tests as explicit tasks, not as an assumed afterthought

## Risks

What could go wrong, and what the fallback is. Unknowns that might force a change of approach.

## Verification

How completion gets confirmed — tests to pass, manual checks, metrics to watch after deploy.

---

## Deviations from plan

*Fill in during implementation, not after. Reconstructing reasoning from a diff weeks later loses the part that mattered.*

| Planned | Actual | Why |
|---|---|---|
| | | |

## Closeout

- [ ] Implementation verified against the repo
- [ ] Spec reconciled with what was actually built
- [ ] Deviations recorded above
- [ ] Frontmatter updated: status, completed date, commits
- [ ] Moved to `docs/implemented/` with `git mv`
