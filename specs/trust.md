# Trust Model

**Status**: Draft — concept defined, no data model or implementation path

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

- [Loop Model](./loop-model.md) - When agent asks vs. works autonomously
- [Learning Loop](./learning-loop.md) - How good outcomes build trust
- [Observability](./observability.md) - Trust level as a visible metric

## Review

**YOLO mode contradicts the rest of the spec set.** Trust level "YOLO" says the agent "ships specs, human reviews async (or not at all)." But spec-lifecycle says "The human decides. Always." and agent-model says specs are the product of human-agent conversation with the human present. These are fundamentally incompatible. Either YOLO mode doesn't apply to spec writing (only to implementation), or the other specs need to accommodate it. This is the biggest cross-spec contradiction in the set.

**The concept is sound but feels disconnected.** Trust as a concept makes sense — it maps well to Claude Code's own permission model. But four other specs reference trust without trust having a data model or mechanism. Observability's dashboard displays trust level, but trust.md has no way to calculate it. The open questions (persistence, per-project vs. global, regression) are all implementation questions that can't be answered without knowing the form this takes.

**Scope question: is this about the speccing tool or the built product?** The trust gradient described here (approve everything → YOLO) reads like it applies to the full Ralph workflow — planning and building too. But OpenSpcs only covers the spec phase. If trust is OpenSpcs-scoped, it's really just about how much the interviewer agent asks vs. assumes. If it's broader, it belongs in the playbook, not in an OpenSpcs spec.

**Still Draft status — that's accurate.** This is the least developed spec and the status reflects it honestly.
