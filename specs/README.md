# OpenSpcs Specifications

Design documentation for OpenSpcs, a conversational specification creation tool that interviews users to build complete specifications before implementation begins.

## Specs

| Spec | Status | Purpose |
|------|--------|---------|
| [core](./core.md) | Solid | Foundation — what OpenSpcs does, interview style, spec qualities, output format |
| [agent-model](./agent-model.md) | Solid | What "the agent" is — interactive + headless modes, one spec review agent |
| [loop-model](./loop-model.md) | Solid | Spec creation as conversation, learning as a bigger loop around building |
| [learning-loop](./learning-loop.md) | Solid | Feedback cycle — build produces evidence, learnings flow back to specs |
| [assumptions](./assumptions.md) | Solid | Framework for assumptions — Test Cards, Learning Cards, D/F/V lenses |
| [observability](./observability.md) | Solid | Tracking layer — 4 entities, gating rules, metrics |
| [spec-lifecycle](./spec-lifecycle.md) | Solid | Two states (draft ⇄ ready), human decides, review agent annotates |

Statuses: **Draft** (still finding the shape) → **Solid** (core decisions made) → **Ready** (good enough to build from)
