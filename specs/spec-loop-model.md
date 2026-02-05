# Spec Loop Model

**Status**: WIP - Exploring whether spec creation should follow an autonomous loop model

## Core Idea

Apply Ralph's "on the loop, not in the loop" principle to spec creation itself.

In Ralph's building phase:
- **In the loop** = doing the work yourself
- **On the loop** = observing, tuning, steering while Ralph does the work

Applied to specs:
- **In the specs** = driving every question/answer in the interview
- **On the specs** = agent loops autonomously while human observes and provides input when needed

## Hybrid Model

Spec creation has two modes that the agent toggles between:

### Autonomous Mode

Agent loops on:
- **Research** - Explore codebase, read docs, analyze existing code for implicit specs
- **Drafting** - Write/refine spec files based on gathered info
- **Self-evaluation** - Check against spec qualities (complete, clear, testable, scoped)
- **Gap identification** - Surface what's missing or unclear

### Interview Mode

Agent surfaces questions, human provides input:
- Domain knowledge that doesn't exist anywhere else
- Preferences and decisions
- Validation: "Is this what you meant?"
- Priority and scope choices

## Flow

```
Agent researches autonomously
    ↓
Agent drafts/refines specs
    ↓
Agent self-evaluates (backpressure)
    ↓
Gaps identified?
    ├── Technical gaps → back to research (autonomous)
    └── Knowledge gaps → surface questions (interview mode)
            ↓
        Human provides input
            ↓
        Back to autonomous mode
    ↓
Spec meets quality criteria → done (for now)
```

## Key Difference from Building Loop

| Building Loop | Spec Loop |
|---------------|-----------|
| Feedback is code/tests (on disk) | Feedback requires human knowledge |
| Fully autonomous between iterations | Blocks on human input for knowledge gaps |
| Clear atomic unit: one task, one commit | Atomic unit less clear |
| Context cleared each iteration | May need context continuity for coherent dialogue |

## Open Questions

- What's the atomic unit of work in a spec loop iteration?
- Should context be cleared between iterations, or maintained for conversation coherence?
- How does the agent decide when to switch modes?
- What triggers "done" - all backpressure passes + no knowledge gaps?

## Related

- [Spec Backpressure](./spec-backpressure.md) - Quality gates for autonomous evaluation
- [Assumption Validation](./assumption-validation.md) - Testing assumptions as part of the loop
