---
title: <Feature name>
status: draft | active | deprecated
owner: <name>
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
---

# <Feature name>

## Purpose

What this feature does and why it exists. Two or three sentences. Written for someone who has never seen the codebase.

## Behaviour

The system as it works today, in present tense. The bulk of the spec lives here.

Break into subsections as the feature warrants — user-facing flows, background processing, failure handling. Describe observable behaviour rather than code structure; the code is the code's own documentation.

## Contracts

APIs, function signatures, event payloads, data shapes. Anything another part of the system (or another team) depends on.

## Data

Schema, models, migrations, retention. Omit the section if the feature is stateless.

## Configuration

Environment variables, feature flags, tunable constants and their defaults.

## Constraints and decisions

Performance budgets, security requirements, compliance obligations. Also the notable "we chose X over Y because Z" decisions — this is where they live permanently, not in a plan that gets archived.

## Non-goals

What this deliberately does not do. Prevents the same rejected ideas being re-proposed every quarter.

## Open questions

Unresolved items. Empty is a good sign.

## Changelog

| Date | Change | Plan |
|---|---|---|
| YYYY-MM-DD | Initial spec | — |
