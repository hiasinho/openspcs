# Trust Model

**Status**: WIP - How trust builds between human and agent during spec creation

## Core Idea

Decision authority isn't static. Trust starts low and builds through demonstrated competence. Like Claude Code's permission model: start with high friction, earn autonomy through good outcomes.

The goal: eventually reach "YOLO mode" where the agent works with minimal oversight.

## The Trust Gradient

```
High friction              →              YOLO mode
(approve everything)                      (full autonomy)
        │                                      │
        └────────── trust builds ──────────────┘
                         │
               through good outcomes
               + ability to influence
```

## Trust Levels

| Level | Agent Behavior | Human Involvement |
|-------|----------------|-------------------|
| **Low** (starting) | Surfaces every assumption, asks before drafting, confirms frequently | Approves most decisions |
| **Medium** | Drafts autonomously, asks on ambiguity or scope changes, summarizes decisions | Reviews summaries, decides on escalations |
| **High** | Works autonomously, only escalates pivots or blockers | Occasional check-ins |
| **YOLO** | Ships specs, human reviews async (or not at all) | Minimal, trust-based |

## What Builds Trust

Two factors:

### 1. Good Outcomes

- Specs lead to successful builds
- Learning loop closes (feedback → learning → better specs)
- Agent catches things the human missed
- Fewer "you should have asked me" moments over time

### 2. Ability to Influence

- When human gives feedback, agent incorporates it well
- Human feels in control when they choose to intervene
- Agent explains its reasoning when asked
- Corrections stick (same mistake doesn't repeat)

Trust isn't just "you didn't screw up" - it's "when I gave you feedback, you responded well."

## Personalization

Decision authority is personal. The threshold for "I need to be involved" varies:

| Person Type | Preference |
|-------------|------------|
| High control | "Tell me about everything, I'll decide" |
| Balanced | "Bring me in for pivots, handle the rest" |
| High delegation | "Just show me the outcome, surprise me less" |

### How to Handle

1. **Simple starting point** - Default to lower trust, higher friction
2. **Explicit configuration** - Let user set preferences ("I want to approve scope changes > X")
3. **Learned over time** - Agent notices when human overrides or says "you should have asked me"
4. **Err toward asking** - When uncertain, ask. Let human say "you don't need to ask about this"

### Fine-tuning

Trust isn't binary. Users should be able to adjust the dial:
- More autonomy for certain types of decisions
- Less autonomy for others
- Different trust levels for different projects or contexts

## Trust Signals

How does the agent know trust level is increasing?

| Signal | Indicates |
|--------|-----------|
| Human stops correcting certain decisions | Trust in that area |
| Human delegates larger scope | Overall trust increasing |
| Human says "just handle it" | High trust signal |
| Human overrides or expresses frustration | Trust decreasing |
| Human asks for more detail/explanation | Trust uncertain, needs validation |

## Connection to Other Concepts

| Concept | Relationship |
|---------|--------------|
| **Spec Loop Model** | Trust level determines when agent asks vs. works autonomously |
| **Learning Loop** | Good learning outcomes build trust |
| **Spec Observability** | Trust level is a visible metric |
| **Decision Authority** | Trust level adjusts the authority thresholds |

## Open Questions

- How do we persist trust level across sessions?
- Should trust be per-project or global?
- How do we handle trust regression (after a bad outcome)?
- What's the minimum bar to reach YOLO mode?

## Related

- [Spec Loop Model](./spec-loop-model.md) - When agent asks vs. works autonomously
- [Learning Loop](./learning-loop.md) - How good outcomes build trust
- [Spec Observability](./spec-observability.md) - Trust level as a visible metric
