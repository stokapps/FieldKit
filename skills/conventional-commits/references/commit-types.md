# Commit types

Pick the single type that best captures the *primary* intent of the change. If a commit
seems to need two types, that's usually a sign it should be two commits.

| Type       | Use it when the change…                                              | Version bump |
| :--------- | :------------------------------------------------------------------ | :----------- |
| `feat`     | adds a new user-facing capability                                   | minor        |
| `fix`      | fixes a bug in existing behavior                                    | patch        |
| `docs`     | touches documentation only                                          | none         |
| `style`    | is formatting/whitespace only, no logic change                     | none         |
| `refactor` | restructures code without changing behavior                        | none         |
| `perf`     | improves performance                                                | patch        |
| `test`     | adds or fixes tests only                                            | none         |
| `build`    | changes the build system or dependencies (npm, cargo, make…)       | none         |
| `ci`       | changes CI configuration or pipelines                              | none         |
| `chore`    | is maintenance that doesn't fit above (config, tooling, cleanup)   | none         |
| `revert`   | reverts a previous commit                                           | varies       |

## Scope

The optional scope names the area of the codebase affected — a package, module, or
subsystem: `feat(parser):`, `fix(auth):`, `docs(readme):`. Keep it short and consistent
with scopes already used in the project's history.

## Breaking changes

A breaking change can accompany **any** type. Signal it two ways at once:

1. Add `!` after the type/scope: `feat(api)!: drop support for v1 tokens`
2. Add a footer explaining the migration:

   ```
   BREAKING CHANGE: v1 auth tokens are no longer accepted. Reissue tokens
   through /auth/v2 before upgrading.
   ```

A breaking change forces a **major** version bump regardless of the type.
