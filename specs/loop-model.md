# Spec Loop Model

**Status**: Solid — spec creation as conversation, learning loop around building

## Core Idea

Spec creation is a conversation, not a loop. A human and Claude Code sit down, discuss, and produce specs. The session ends, and you have specs.

Learning, on the other hand, IS a loop — but a much bigger one that wraps around building:

```
Spec (conversation) → Build → Learn → Spec (conversation)
```

This cycle takes days or weeks, not minutes. Each leg is a separate activity with its own dynamics.

## The Conversation

Within an interactive speccing session, the agent naturally moves between activities:

- **Researching** — exploring codebase, reading docs, analyzing existing code
- **Drafting** — writing and refining spec content
- **Interviewing** — asking questions to fill knowledge gaps
- **Checking** — noticing inconsistencies, gaps, vague language

These aren't separate "modes" the agent toggles between. They're what a good conversation looks like. The agent researches when it needs context, asks when it needs domain knowledge, drafts when it has enough to write, and checks its own work naturally.

The human steers: "study this", "interview me about X", "update the spec", "what's missing?"

## The Learning Loop

The bigger cycle happens across sessions and phases:

1. **Spec** — Conversation produces specs with assumptions
2. **Build** — Prototype, spike, or MVP tests those assumptions
3. **Learn** — Building produces evidence (see [learning-loop](./learning-loop.md))
4. **Spec again** — New conversation incorporates what was learned

This is where Ralph's "on the loop" principle actually applies: the human observes what the build phase revealed and decides what needs revisiting.

## Key Difference from Building

| Building | Speccing |
|----------|----------|
| Feedback is code/tests (on disk) | Feedback is human knowledge |
| Autonomous between iterations | Conversational — human is present |
| Clear atomic unit: one task, one commit | Atomic unit is one session |
| Context cleared each iteration | Context maintained within session |

## Related

- [Core](./core.md) — What the conversation produces
- [Learning Loop](./learning-loop.md) — How evidence flows back from building
- [Agent Model](./agent-model.md) — Interactive vs. headless modes

## Review

This spec is clean. The conversation-vs-loop distinction is one of the clearest ideas in the spec set and it holds up well. The table contrasting building vs. speccing is particularly useful.

**One minor tension with assumptions.md.** The assumptions spec's "Integration with Spec Loop" diagram shows a mini-loop within the spec phase where "Agent runs testable experiments (feasibility) → Learning Cards → Spec refined OR assumption flagged → Loop until critical assumptions validated." This reads like an automated loop inside the speccing conversation, which sits oddly against this spec's assertion that speccing is a conversation, not a loop. Worth clarifying: is agent-driven feasibility testing (e.g., searching codebase, testing an API) just part of the conversation flow, or is it a separate iterative process?
