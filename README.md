# OpenSpcs

A conversational specification tool. An agent interviews you about your project and creates complete specs before any code is written.

## Key Concepts

- **Spec Loop Model** - Spec creation is a conversation, not a loop. A human and Claude Code sit down, discuss, and produce specs. Learning is the bigger loop — it wraps around building (spec → build → learn → spec).

- **Assumption Validation** - Surface assumptions explicitly, categorize by area (Desirability/Feasibility/Viability), rate importance 1-10, and test what can be tested. High-importance assumptions with no evidence are blind spots that gate progress.

- **Learning Loop** - Specs aren't static. Build → observe → learn → update specs. The cycle closes when evidence flows back into spec updates.

- **Trust Model** - Trust starts low and builds through good outcomes. Agent earns autonomy over time, from "approve everything" to "YOLO mode." Personalized to individual preferences.

- **Spec Observability** - Tracking layer (database-backed) maintains assumptions, experiments, evidence, and learnings as structured entities separate from specs. Soft gating: agent flags high-importance unchecked assumptions and waits for human decision.

- **Spec Lifecycle** - Two states: draft ⇄ ready. Human decides transitions. The spec review agent annotates.

## Continue a Spec Session

Start Claude Code and run the spec agent:

```
/agents/spec.sh
```

Or paste a prompt manually — study the specs, then interview.

## Files

- [specs/](./specs/README.md) - Design documentation
- [agents/](./agents/README.md) - Agent scripts and prompts
- [the-ralph-playbook.md](./the-ralph-playbook.md) - Source material, the workflow this is based on
