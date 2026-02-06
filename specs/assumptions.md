# Assumption Validation

**Status**: Solid — framework defined (test cards, learning cards, D/F/V lenses)

## Core Idea

Specs contain assumptions - implicit beliefs about users, technology, business viability. Unvalidated assumptions are risks. Making assumptions explicit and testing them is a form of backpressure.

Scientific approach:
1. Surface assumption
2. Write hypothesis (make explicit)
3. Design experiment with metric and criteria
4. Gather evidence
5. Extract learnings
6. Make decision

## Strategyzer Framework

### Test Card (before experiment)

| Step | Prompt |
|------|--------|
| **Hypothesis** | We believe that... |
| **Test** | To verify that, we will... |
| **Metric** | And measure... |
| **Criteria** | We are right if... |

### Learning Card (after experiment)

| Step | Prompt |
|------|--------|
| **Hypothesis** | We believed that... |
| **Observation** | We observed... |
| **Learnings** | From that we learned that... |
| **Decisions** | Therefore, we will... |

## Three Lenses: Desirability, Feasibility, Viability

| Lens | Core question | Who/what tests it |
|------|---------------|-------------------|
| **Desirability** | Do people want this? | Users - interviews, observation, experiments |
| **Feasibility** | Can we build this? | Technical research, prototypes, AI agent |
| **Viability** | Should we build this? | Business analysis - margins, effort vs value |

## Prioritization Matrix

Two scales for prioritizing which assumptions to test:

1. **Importance**: How critical is this assumption for the feature/product to work?
2. **Evidence**: How much evidence do we have? How strong is it?

```
                    High Evidence
                         │
    "Safe to build"      │      "Validated"
    (but verify)         │      (green light)
                         │
   Low ──────────────────┼────────────────── High
   Importance            │               Importance
                         │
    "Deprioritize"       │      "Risky - de-risk first"
    (why bother?)        │      (labs, A/B, opt-in)
                         │
                    Low Evidence
```

## Decision Tree

| Position in matrix | Decision |
|--------------------|----------|
| High importance, low evidence | De-risk: labs feature, opt-in, A/B test, requires analytics |
| High importance, high evidence | Build with confidence |
| Low importance, low evidence | Deprioritize or cut |
| Low importance, high evidence | Build if cheap, skip if not |

## What AI Agents Can Test (Feasibility focus)

| Assumption type | Example | How agent tests it |
|-----------------|---------|-------------------|
| **Technical feasibility** | "The API supports batch requests" | Read API docs, try it |
| **Codebase patterns** | "We already have a utility for this" | Search the codebase |
| **Integration compatibility** | "This works with our auth system" | Analyze the code |
| **Performance** | "This will be fast enough" | Prototype + benchmark |
| **Documentation claims** | "The library handles edge case X" | Read docs, test it |
| **Existing behavior** | "The system currently does Y" | Verify by inspection |

## What Needs Human Testing

| Assumption type | Example | Why human needed |
|-----------------|---------|------------------|
| **User desire** | "Users want this feature" | Interviews, observation |
| **Market fit** | "People will pay for this" | Real-world validation |
| **Stakeholder approval** | "Legal will accept this approach" | Actually ask them |
| **UX intuition** | "Users will understand this flow" | Usability testing |

## Integration with Spec Loop

```
Spec draft
    ↓
Extract assumptions
    ↓
Categorize (D/F/V) and prioritize (importance × evidence)
    ↓
Agent runs testable experiments (feasibility)
    ↓
Learning Cards capture results
    ↓
Spec refined OR assumption flagged for human validation
    ↓
Loop until critical assumptions validated (or explicitly accepted as risks)
```

## What This Means for Specs

A spec could include:

1. **Assumptions** - explicit, categorized (D/F/V)
2. **Evidence level** - what do we know, how do we know it?
3. **Importance rating** - how critical to the feature/product?
4. **Test plan** - how to validate before/during/after building
5. **Release strategy** - full rollout vs labs vs A/B (derived from above)
6. **Instrumentation requirements** - analytics needed to learn post-launch

This turns specs from "build instructions" into "investment theses with validation plans."

## Related

- [Loop Model](./loop-model.md) - Assumption validation as part of the loop
- [Observability](./observability.md) - Gating rules for unvalidated assumptions

## Review

**Framework is solid.** Test Cards, Learning Cards, D/F/V lenses, and the prioritization matrix are clear and actionable. The "What AI Agents Can Test" vs. "What Needs Human Testing" tables are particularly useful — they directly inform the conversation flow.

**"Integration with Spec Loop" diagram implies an inner loop.** The diagram shows "Agent runs testable experiments → Learning Cards → Spec refined → Loop until critical assumptions validated." This reads as an automated iterative process within the speccing phase, but loop-model.md insists speccing is a conversation, not a loop. The agent doing feasibility research (searching codebase, reading docs) is clearly just conversation flow. But "loop until validated" suggests something more structured. Clarifying this would resolve a tension with loop-model.

**Overlap with observability on what a spec should contain.** The "What This Means for Specs" section lists six things a spec could include (assumptions, evidence level, importance rating, test plan, release strategy, instrumentation). Observability defines overlapping entity fields (Assumption with importance, status; Evidence with strength, direction). Neither spec clearly owns the "what goes in a spec file" question — assumptions.md describes it narratively, observability.md defines it as database entities. These should point at each other more explicitly.

**Open questions are partially answered.** "Should assumption validation be a separate phase or integrated into spec drafting?" — loop-model answers this (it's part of the conversation, not a phase). "How do we track assumptions across multiple specs?" — observability's data model handles this (Assumption entity has a `spec` field).
