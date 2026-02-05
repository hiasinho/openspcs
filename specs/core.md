# OpenSpcs Core Specification

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

Use the "one sentence without 'and'" test from the Ralph Playbook:

- Can you describe the topic in one sentence without conjoining unrelated capabilities?
- If you need "and" to describe what it does, it's probably multiple topics

The LLM applies this heuristic organically and decides when to split topics into separate specs.

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
- **Readiness report** - summary of what's ready and what needs more work

## Context Handling

When users have existing context (code, docs, URLs):

- Analyze and understand what exists
- Gap analysis - compare against what a complete spec needs
- Extract implicit specs from existing artifacts
- Focus interview on gaps and unclear areas

Core principle from playbook: "Don't assume not implemented" - always analyze first.

---

## Open Questions

To be decided in future sessions:

- **Form factor**: CLI tool, web interface, Claude Code skill, or combination
- **Spec file structure**: Consistent template vs. content-driven format
- **Command naming**: /spec, /define, /interview, or other
- **Specific frameworks**: How much to adopt JTBD, story maps, SLC concepts from playbook enhancements

---

## References

- [The Ralph Playbook](../the-ralph-playbook.md) - source material for workflow concepts
- Geoffrey Huntley's Ralph approach and videos
- Clayton Farr's enhancements documentation
