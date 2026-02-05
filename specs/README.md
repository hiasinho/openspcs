# OpenSpcs Specifications

Design documentation for OpenSpcs, a conversational specification creation tool that interviews users to build complete specifications before implementation begins.

## Specs

| Spec | Purpose |
|------|---------|
| [core](./core.md) | Foundation - what OpenSpcs does, interview style, spec qualities, output format |
| [loop-model](./loop-model.md) | Autonomous loop model - agent researches/drafts/self-evaluates, surfaces questions for knowledge gaps |
| [backpressure](./backpressure.md) | Quality gates - deterministic checks, LLM-as-judge, and human-only validation layers |
| [assumptions](./assumptions.md) | Scientific approach to assumptions - Test Cards, Learning Cards, D/F/V lenses |
| [learning-loop](./learning-loop.md) | Feedback cycle - build produces evidence, learnings flow back to spec updates |
| [observability](./observability.md) | Tracking layer and dashboard - 4 entities (Assumption, Experiment, Evidence, Learning), gating rules, metrics |
| [trust](./trust.md) | Autonomy gradient - how trust builds from high friction toward YOLO mode |
| [spec-lifecycle](./spec-lifecycle.md) | **Stub** - Spec states and transitions (draft → ready → planning → building → validating) |

## Status

All specs are currently **WIP** (work in progress).
