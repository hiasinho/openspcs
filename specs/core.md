# OpenSpcs Core Specification

**Status**: Solid — core decisions made, form factor and spec template still open

A conversational specification creation tool that interviews users to build complete specifications before implementation begins.

## What It Does

OpenSpcs covers the "specification phase" - transforming fuzzy ideas into structured specs that can feed into implementation planning (e.g., Ralph's planning mode).

## Entry Points

Users come to openspcs with varying levels of existing context:

- Rough idea for a new project
- Existing partially-built application
- Research project (not always an application)
- Legacy project to revive
- Running production app to continue developing

**Not blank slate ideation** - users have at least a rough idea of what they want to build.

## Spec Qualities

Specifications must be:

- **Complete** - covers all aspects of the topic, no major gaps
- **Clear** - unambiguous, another person or AI knows exactly what to build
- **Testable** - has success criteria, you can verify when it's done
- **Scoped** - right-sized, not too broad, not too narrow

**Dual audience**: Specs must be human-readable/editable AND machine-consumable for AI implementation planning.

## Interview Style

Adaptive based on the clarity spectrum:

```
High uncertainty ←――――――――――――――――――→ High clarity
     ↓                                      ↓
  Freeform                              Structured
  conversation                          tool/checklist
```

- **Early/uncertain**: Open questions, let the user talk, follow threads
- **Emerging clarity**: Start proposing structure, validate understanding
- **Nearing completion**: Checklist-style, fill gaps, confirm details

The tool senses where the user is on this spectrum and adapts. It doesn't force one mode.

Reference: Geoff's approach in videos is simple and open-ended: "This is what I want to build. Let's have a discussion, interview me."

## Topic Scoping

A **topic of concern** is a single, cohesive area that can be described in one sentence without "and." How you discover topics depends on your project.

### Decomposition Strategies

Topics can emerge from different lenses:

- **Needs-driven**: "What jobs do users need done?" (JTBD → topics)
- **Architecture-driven**: "What are the major systems?" (subsystems → topics)
- **Domain-driven**: "What are the core entities/resources?" (models → topics)
- **Flow-driven**: "What are the key user journeys?" (flows → topics)
- **Concept-driven**: "What are the distinct mechanisms?" (concepts → topics)

Most projects use a mix. A Rails app might use domain-driven for models, needs-driven for features, and architecture-driven for infrastructure. The interviewer figures out which lens fits during conversation — it doesn't need to be pre-decided.

### Scope Test

Use the "one sentence without 'and'" test:

- Can you describe the topic in one sentence without conjoining unrelated capabilities?
- If you need "and" to describe what it does, it's probably multiple topics

This test is universal regardless of which decomposition strategy produced the topic. The LLM applies this heuristic organically and decides when to split topics into separate specs.

## Completion

Specs are never truly "done" - they evolve with the software.

"Done" means **ready for the next phase**: enough clarity and coverage that implementation planning can begin meaningfully.

The tool helps gauge readiness: what's clear enough to build, and what gaps might cause problems during implementation.

## Session Scope

Flexible:

- Can focus on a single topic
- Can expand to discover related topics
- User and tool figure it out together

## Output

- `specs/*.md` - one file per topic of concern

## Context Handling

When users have existing context (code, docs, URLs):

- Analyze and understand what exists
- Gap analysis - compare against what a complete spec needs
- Extract implicit specs from existing artifacts
- Focus interview on gaps and unclear areas

Core principle from playbook: "Don't assume not implemented" - always analyze first.

---

## References

- [The Ralph Playbook](../the-ralph-playbook.md) - source material for workflow concepts
- Geoffrey Huntley's Ralph approach and videos
- Clayton Farr's enhancements documentation

## Review

**Form factor is answered elsewhere.** Agent-model.md has decided: it's Claude Code, interactive + headless. But core.md still lists form factor as an open question. The open questions section needs a pass — some are answered, some may no longer matter.

**"Readiness report" output is orphaned.** Core lists a "readiness report" as an output alongside `specs/*.md`, but no other spec defines this artifact. Spec-lifecycle has draft ⇄ ready states, and the spec review agent writes `## Review` sections — but neither produces a standalone readiness report. Either define what this is or drop it.

**Spec template question has a de facto answer.** The open question about "consistent template vs. content-driven format" — the existing specs already demonstrate the answer: content-driven, no rigid template. The playbook also says "no pre-specified template." This could be closed.

**Interview style is solid.** The clarity spectrum (freeform → structured) and adaptive approach are well-defined and consistent with the playbook and loop-model's description of in-session conversation flow.

**Topic scoping is solid.** Multiple decomposition strategies + the "one sentence without and" test are clear and practical. Consistent with the playbook's treatment of topics of concern.
