# OpenSpcs

A conversational specification tool. An agent interviews you about your project and creates complete specs before any code is written.

## Key Concepts

What differentiates OpenSpcs from simple "interview and write" approaches:

- **Spec Loop Model** - Apply "on the loop, not in the loop" to spec creation. Agent works autonomously (research, draft, evaluate) and switches to interview mode when it needs human input.

- **Spec Backpressure** - Automated quality gates for specs: deterministic checks (structure, ambiguity), LLM-as-judge (clarity, completeness), and human-only gates (domain accuracy, strategic fit).

- **Assumption Validation** - Surface assumptions explicitly, categorize by Desirability/Feasibility/Viability, prioritize by Importance × Evidence, and test what can be tested.

- **Learning Loop** - Specs aren't static. Build → observe → learn → update specs. The cycle closes when evidence flows back into spec updates.

- **Trust Model** - Trust starts low and builds through good outcomes. Agent earns autonomy over time, from "approve everything" to "YOLO mode." Personalized to individual preferences.

- **Spec Observability** - Dashboard for spec health: assumption counts, evidence strength, experiments running, learnings captured. Make the invisible visible.

## Continue a Spec Session

Start Claude Code and paste:

```
Study @the-ralph-playbook.md and @specs/ and @READINESS.md. Then let's continue the specification session for openspcs. Interview me on the open questions.
```

## Files

- [specs/](./specs/README.md) - Design documentation
- [READINESS.md](./READINESS.md) - What's ready, what needs work
- [the-ralph-playbook.md](./the-ralph-playbook.md) - Source material, the workflow this is based on
