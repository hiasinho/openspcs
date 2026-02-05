# Assumption Validation

**Status**: WIP - Framework for surfacing, testing, and deciding on assumptions in specs

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

## Open Questions

- How lightweight can this be for small features vs. how rigorous for big bets?
- Should assumption validation be a separate phase or integrated into spec drafting?
- What's the threshold for "enough evidence" to proceed?
- How do we track assumptions across multiple specs?

## Related

- [Spec Loop Model](./spec-loop-model.md) - Assumption validation as part of the loop
- [Spec Backpressure](./spec-backpressure.md) - Validated assumptions as a quality gate
