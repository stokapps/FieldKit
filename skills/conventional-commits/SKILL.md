---
name: conventional-commits
description: Write clear, well-structured git commit messages that follow the Conventional Commits specification. Use this whenever the user is committing code, asks for a commit message, wants to summarize staged changes, or mentions commits, changelogs, or semantic versioning.
---

# Conventional Commits

Generate commit messages that follow the [Conventional Commits](https://www.conventionalcommits.org)
specification, so history stays readable and changelogs and semantic-version bumps can be
automated from the log.

## Workflow

1. Look at what is actually staged before writing anything.
   - `git diff --cached` — the staged changes you are describing
   - `git status --short` — a quick overview of staged vs. unstaged
   - If nothing is staged, describe the unstaged changes instead and say so, so the user
     isn't surprised by an empty commit.
2. Group changes by intent. One logical change is one commit. If the diff mixes unrelated
   work (a refactor plus a feature, say), point that out and suggest splitting it.
3. Choose a **type** and an optional **scope**. See [references/commit-types.md](references/commit-types.md)
   for the full list and when to use each.
4. Write the message in this exact structure:

   ```
   <type>(<optional scope>): <short summary, imperative mood>

   <optional body: explain what changed and why, wrapped at ~72 chars>

   <optional footer: BREAKING CHANGE: ..., Refs: #123>
   ```

## Rules that keep messages clean

- **Summary line**: imperative mood ("add", not "added" or "adds"), no trailing period,
  and ≤ 50 characters when you can manage it.
- **Body explains _why_**, not _how_ — the diff already shows how. Skip the body for
  trivial changes.
- **Breaking changes** get a `!` after the type or scope (`feat!:` / `feat(api)!:`) **and**
  a `BREAKING CHANGE:` footer describing the migration.
- **One concern per commit.** Don't bundle a refactor with a feature.

## Examples

**Input:** Added JWT validation to the login endpoint plus a test for the expired-token case.

**Output:**
```
feat(auth): validate JWT on login

Reject expired or malformed tokens before hitting the user store.
Adds a regression test for the expired-token path.
```

**Input:** Fixed a typo in the README install section.

**Output:**
```
docs: fix typo in install instructions
```

For the complete list of types and guidance on picking the right one, read
[references/commit-types.md](references/commit-types.md).
