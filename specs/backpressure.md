# Spec Backpressure

**Status**: Draft — categories defined but stale, needs alignment with current agent model

## Core Idea

In Ralph's building loop, backpressure comes from tests, linters, type systems - automated checks that reject invalid work.

For specs to run in a loop, they need equivalent backpressure mechanisms. Code can be tested deterministically; specs are harder - but not impossible.

## Backpressure Categories

### Deterministic Checks (like linters/type systems)

| Check | What it catches |
|-------|-----------------|
| **Structure validation** | Missing required sections (acceptance criteria, scope, etc.) |
| **Ambiguity detection** | Vague words: "should", "might", "appropriate", "etc.", "as needed" |
| **Undefined terms** | Jargon or references without definition |
| **Scope test** | Can't describe in one sentence without "and" |
| **Dangling references** | Mentions other specs/concepts that don't exist |
| **Testability check** | No acceptance criteria = fails |

### Semi-Deterministic Checks (pattern-based)

| Check | What it catches |
|-------|-----------------|
| **Missing edge cases** | No error handling, no empty states, no boundaries mentioned |
| **Implicit assumptions** | Unstated dependencies or preconditions |
| **Spec-to-code drift** | Spec describes something already implemented differently |
| **Circular dependencies** | Specs that require each other |

### Non-Deterministic Checks (LLM-as-judge)

| Check | What it catches |
|-------|-----------------|
| **Clarity** | "Would another person/AI know exactly what to build?" |
| **Completeness** | "Are there obvious gaps a builder would hit?" |
| **Consistency** | "Do specs contradict each other?" |
| **Implementability** | "Is this actually buildable as described?" |

### Human-Only Checks (final gate)

| Check | What it catches |
|-------|-----------------|
| **Domain accuracy** | Is this factually correct about the domain? |
| **Priority alignment** | Is this what we actually want to build? |
| **Strategic fit** | Does this belong in the product? |

## Automation Potential

The first three categories can run **automatically** as part of a spec loop:
- Deterministic checks → always run, binary pass/fail
- Semi-deterministic → pattern matching, may have false positives
- LLM-as-judge → accepts non-determinism, converges through iteration

Only human checks require blocking the loop for input.

## Implementation Ideas

### Deterministic Checks

Could be implemented as:
- CLI tool that parses spec markdown
- Pre-commit hook
- Part of the spec agent's self-evaluation

### LLM-as-Judge

Similar to Ralph's non-deterministic backpressure enhancement:

```
Spec draft
    ↓
LLM evaluates against criteria
    ↓
Pass → continue
Fail → feedback provided → refine → re-evaluate
```

## Open Questions

- What's the right structure/template for specs to enable deterministic validation?
- How strict should ambiguity detection be? (Some flexibility needed for early-stage specs)
- Should backpressure be configurable based on spec maturity?

## Related

- [Loop Model](./loop-model.md) - How backpressure fits into the loop
- [Assumptions](./assumptions.md) - Testing assumptions is another form of backpressure
