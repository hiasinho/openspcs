# Spec Lifecycle

**Status**: Solid — two states, human decides transitions, review agent annotates

## Core Idea

Specs have two states: **draft** and **ready**. That's it.

- **Draft** — still being shaped in conversation between the human and the interactive agent
- **Ready** — complete enough for the planning agent to consume

This isn't a pipeline. Specs move back and forth as the project evolves.

```
Draft ⇄ Ready
```

## Transitions

### Draft → Ready

The human decides. The agent may suggest readiness ("I think this covers everything") but never unilaterally promotes a spec. Before the transition, observability gating fires — high-importance assumptions with no evidence get flagged. The human can proceed anyway (accept the risk) or address the gaps first.

### Ready → Draft

Happens when:
- The learning loop brings back evidence that refutes a core assumption
- The human decides to rework something
- The spec review flags something that needs conversation

A spec being "ready" is not permanent. It's ready *given what we know now*.

## Who Decides

The human. Always. The agent surfaces signals — the spec review annotates issues, observability flags blind spots — but the human makes the call.

## Spec Review

After each speccing session, the spec review agent reads all specs and writes a `## Review` section at the bottom of each spec. This section is owned by the review agent — it overwrites it each run. The interactive agent reads it but doesn't edit it.

The review captures what a holistic read reveals: issues within the spec, contradictions with other specs, gaps, staleness. It's agent-to-agent context — the next interactive session starts already informed.

See [agent-model](./agent-model.md) for how the review agent works.

## Related

- [Observability](./observability.md) — gating rules that fire at draft → ready
- [Agent Model](./agent-model.md) — spec review agent, interactive vs. headless modes
- [Loop Model](./loop-model.md) — the bigger cycle that moves specs back to draft
