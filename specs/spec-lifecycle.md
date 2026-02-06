# Spec Lifecycle

**Status**: Draft — stub, needs states and transitions defined

## Why This Spec Exists

The observability spec defines gating rules: "when the agent would move a spec forward, it checks for blind spots." But "move a spec forward" implies specs have states and transitions. No spec defines what those states are or what triggers transitions between them.

Without this, a build agent implementing gating would invent its own lifecycle model.

Surfaced by: `spec-check observability.md → E001`

## Starting Point

Specs appear to move through at least these phases:

- **Draft** — being written, interview in progress, still shaping
- **Ready** — complete enough to plan from, gating rules pass
- **Planning** — an implementation plan is being created from this spec
- **Building** — implementation is underway
- **Validating** — built, collecting evidence against assumptions

## Open Questions

- What triggers the transition between states?
- Who decides a spec is "ready" — human, agent, or the gating system?
- Can specs move backward (e.g., building → draft if a critical assumption is refuted)?
- Is this lifecycle per-spec or per-topic within a spec?
- How does this relate to the loop model?

## Related

- [Observability](./observability.md) — gating rules depend on spec states
- [Loop Model](./loop-model.md) — describes the iterative flow that moves specs forward
- [Backpressure](./backpressure.md) — quality gates that may block transitions
