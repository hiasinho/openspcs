# Agent Model

**Status**: Solid — two modes defined, one spec review agent, write boundary clear

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

### Spec Review Agent

One agent, one job: after a speccing session, read all specs and write review notes back into them.

Pattern: `agents/spec-review.sh` + `agents/prompts/spec-review.md` — shell script pipes a prompt to `claude -p`, agent reads all specs, writes a `## Review` section at the bottom of each spec.

The review captures what a holistic read reveals — issues within a spec, contradictions with other specs, gaps, staleness. Each spec gets its own review notes. The agent overwrites the Review section each run.

This is agent-to-agent context. The next interactive session reads the specs and the review is right there. No separate file to coordinate.

## Post-Session Flow

```
Interactive session (human + CC)
    ↓ session ends
Spec review agent (headless)
    ↓
## Review section in each spec
    ↓
Next interactive session (reads specs with review notes already there)
```

## Write Permissions

Specs are the product of a conversation between the human and Claude Code in interactive mode. The agent writes spec content as part of that collaboration — the human is present, steering, approving. That's not "an agent writing specs" — that's a conversation producing specs.

Headless agents never touch specs. They write tracking data only.

| Target | Who writes | Context |
|--------|-----------|---------|
| Spec content | Interactive Claude Code | Human present, collaborative — this is the conversation |
| Spec review notes (`## Review`) | Spec review agent (headless) | Post-session annotation, no human needed |

The boundary is content vs. annotation. Interactive sessions shape spec content. The review agent writes review notes — metadata about the spec, not the spec itself.

## Relationship to Ralph Phases

```
Phase 1: Define Requirements (this is where OpenSpcs lives)
├── Interactive: speccing sessions (human + CC)
├── Headless: spec review agent
└── Output: specs (with review notes)

Phase 2: Planning
├── Headless: implementation planning agent
└── Output: implementation plan

Phase 3: Building
├── Headless: building loop
└── Output: code + commits
```

All three phases use the same underlying mechanism — Claude Code, interactive or headless. The difference is what prompts they run and what artifacts they produce.

## Open Questions

- How does the spec review get triggered? Manually by the user, or automatically?
- Which model should the spec review agent use?

## Related

- [Core](./core.md) — What the interactive session produces
- [Spec Lifecycle](./spec-lifecycle.md) — Draft ⇄ ready, review agent's role in transitions
- [Loop Model](./loop-model.md) — Spec creation as conversation, learning as loop
- [Learning Loop](./learning-loop.md) — How evidence flows back from building
