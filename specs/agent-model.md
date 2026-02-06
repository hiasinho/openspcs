# Agent Model

**Status**: Solid — two modes defined, one debrief agent, write boundary clear

## Core Idea

The agent is Claude Code. Not a separate application, not a custom framework. Claude Code running in two modes with shell scripts as the glue.

Every other spec references "the agent" without defining it. This spec fills that gap.

## Two Modes

### Interactive Mode

A human opens Claude Code and has a conversation. This is the speccing session — studying context, being interviewed, making decisions, writing specs together.

- Human in the loop — that's the point
- Conversational, adaptive (see interview style in [core](./core.md))
- Human drives ("study this", "interview me", "update the spec", "any gaps?")
- Within a session, the agent may research, draft, or self-check without being asked — that's just part of the conversation flow, not a separate mode
- Domain knowledge flows in through dialogue
- Specs are the output

### Headless Mode

Claude Code invoked with `claude -p`. No human interaction. A script pipes a prompt, the agent does a specific job, returns results.

- No human present
- Single-purpose — one job per agent
- Invoked via shell scripts with prompt files
- Writes tracking data only, never specs

## Headless Agents

### Debrief Agent

One agent, one job: after a speccing session, read all specs and produce a debrief for the next session.

Pattern: `agents/debrief.sh` + `agents/prompts/debrief.md` — shell script pipes a prompt to `claude -p`, agent reads all specs, writes `tracking/debrief.md`.

The debrief covers:
- What's in good shape
- What's not — contradictions, gaps, issues, in one prioritized list
- Suggested focus for next session

That's it. No separate agents for assumptions, gaps, contradictions, consistency. One holistic read, one file.

## Post-Session Flow

```
Interactive session (human + CC)
    ↓ session ends
Debrief agent (headless)
    ↓
tracking/debrief.md
    ↓
Next interactive session (informed by debrief)
```

## Write Permissions

Specs are the product of a conversation between the human and Claude Code in interactive mode. The agent writes spec content as part of that collaboration — the human is present, steering, approving. That's not "an agent writing specs" — that's a conversation producing specs.

Headless agents never touch specs. They write tracking data only.

| Target | Who writes | Context |
|--------|-----------|---------|
| Specs | Interactive Claude Code | Human present, collaborative — this is the conversation |
| Tracking data (debrief, reports) | Headless agents | Post-session analysis, no human needed |

This is a clear boundary, not a trust gradient. Interactive sessions produce specs. Headless agents produce analysis.

## Relationship to Ralph Phases

```
Phase 1: Define Requirements (this is where OpenSpcs lives)
├── Interactive: speccing sessions (human + CC)
├── Headless: debrief agent
└── Output: specs + debrief

Phase 2: Planning
├── Headless: implementation planning agent
└── Output: implementation plan

Phase 3: Building
├── Headless: building loop
└── Output: code + commits
```

All three phases use the same underlying mechanism — Claude Code, interactive or headless. The difference is what prompts they run and what artifacts they produce.

## Open Questions

- How does the post-session debrief get triggered? Manually by the user, or automatically?
- Which model should the debrief agent use?

## Related

- [Core](./core.md) — What the interactive session produces
- [Loop Model](./loop-model.md) — Spec creation as conversation, learning as loop
- [Learning Loop](./learning-loop.md) — How evidence flows back from building
