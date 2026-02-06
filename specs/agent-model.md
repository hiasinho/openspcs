# Agent Model

**Status**: WIP - Defining what "the agent" means across all OpenSpcs specs

## Core Idea

The agent is Claude Code. Not a separate application, not a custom framework. Claude Code running in two modes with shell scripts as the glue.

Every other spec references "the agent" without defining it. This spec fills that gap.

## Two Modes

### Interactive Mode

A human opens Claude Code and has a conversation. This is the speccing session — studying context, being interviewed, making decisions, writing specs together.

- Human in the loop — that's the point
- Conversational, adaptive (see interview style in [core](./core.md))
- Human drives mode switches ("study this", "interview me", "update the spec", "any gaps?")
- Domain knowledge flows in through dialogue
- Decisions happen here

This is the **interview mode** from the [loop model](./loop-model.md).

### Headless Mode

Claude Code invoked with `claude -p`. No human interaction. A script pipes a prompt, the agent does a specific job, returns results.

- No human needed
- Single-purpose — one job per agent
- Invoked via shell scripts with prompt files
- Composable and orchestratable

This is the **autonomous mode** from the [loop model](./loop-model.md).

## Headless Agents

### Utility Agents

Each utility agent does one well-defined job:

| Agent | Job |
|-------|-----|
| **spec-check** | Quality gate — structure, ambiguity, dangling references, gaps |
| **extract-assumptions** | Surface assumptions from spec content into the tracker |
| **check-assumptions** | Check if existing assumptions have gained new evidence |
| **gap-analysis** | Find missing coverage across specs |
| **consistency-check** | Detect cross-spec contradictions |

Each follows the same pattern: shell script validates inputs, pipes a prompt file to `claude -p`, agent reads relevant files, does its job, writes output.

This list isn't fixed. New utility agents get added as needs emerge.

### Supervisor Agent

Orchestrates utility agents after an interactive speccing session:

1. Determines which utility agents to run
2. Runs them (possibly in parallel)
3. Collects results
4. Synthesizes findings into a post-session report

The supervisor is itself a headless Claude Code invocation that calls other headless invocations.

## Post-Session Flow

The key workflow this model enables: after each interactive speccing session, automated processing runs to surface what the next session should address.

```
Interactive session (human + CC)
    ↓ session ends
Supervisor agent (headless)
    ├── spec-check (per modified spec)
    ├── extract-assumptions
    ├── check-assumptions
    ├── gap-analysis
    └── consistency-check
    ↓
Findings + tracking updates
    ↓
Next interactive session (informed by findings)
```

This is the **spec-phase equivalent of the building loop's backpressure**. The building loop has tests, lints, and type checks that reject bad work. The spec phase gets a post-session agent that surfaces what needs attention.

## Write Permissions

What agents can and cannot modify directly:

| Target | Agents write directly? | Rationale |
|--------|------------------------|-----------|
| Tracking data (assumptions, evidence, status) | Yes | Metadata about specs, not decisions |
| Findings / reports | Yes | Observations and suggestions, not changes |
| Specs | No — goes through human | Specs represent decisions; human reviews and applies |

This aligns with the [trust model](./trust.md): start with a clear boundary where agents don't touch specs, potentially relax as trust builds.

## Relationship to Ralph Phases

```
Phase 1: Define Requirements (this is where OpenSpcs lives)
├── Interactive: speccing sessions (human + CC)
├── Headless: post-session agents (supervisor + utilities)
└── Output: specs + tracking data

Phase 2: Planning
├── Headless: implementation planning agent
└── Output: implementation plan

Phase 3: Building
├── Headless: building loop
└── Output: code + commits
```

All three phases use the same underlying mechanism — Claude Code, interactive or headless. The difference is what prompts they run and what artifacts they produce.

## Open Questions

- How does the supervisor decide which utility agents to run? Always all of them, or based on what changed in the session?
- Can utility agents invoke other agents, or does only the supervisor compose?
- What happens when a utility agent fails? Does the supervisor continue with the rest?
- Which model should headless agents use? (Fast model for simple checks, stronger model for judgment calls?)
- Should the supervisor be able to flag something so urgent it triggers an immediate interactive follow-up?
- How does the post-session flow get triggered? Manually by the user, or automatically (e.g., git hook on spec changes)?

## Related

- [Core](./core.md) — What the interactive session produces
- [Loop Model](./loop-model.md) — Interactive = interview mode, headless = autonomous mode
- [Backpressure](./backpressure.md) — Utility agents are the backpressure mechanism for specs
- [Trust](./trust.md) — Write permissions follow the trust gradient
- [Observability](./observability.md) — Tracking data that agents maintain
- [Assumptions](./assumptions.md) — Extract and check agents handle assumption lifecycle
