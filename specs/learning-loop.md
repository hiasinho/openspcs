# Learning Loop

**Status**: Solid — cycle defined, decision authority clarified

## Core Idea

Specs are never truly done. Building produces evidence that validates or refutes assumptions, which feeds back into specs. This isn't a linear flow (spec → build → done) but a cycle (spec → build → learn → spec).

Real-world teams build prototypes, spikes, and MVPs specifically to test assumptions. The artifacts and observations from building become evidence that informs spec updates.

## The Full Cycle

```
SPEC PHASE                                 BUILD PHASE

┌──────────────────┐                      ┌──────────────────┐
│                  │                      │                  │
│  Specs with      │───── decide to ─────→│  Prototype /     │
│  assumptions     │      build anyway    │  Spike / MVP     │
│                  │                      │                  │
└────────┬─────────┘                      └────────┬─────────┘
         ↑                                         │
         │                                         ↓
         │                                ┌──────────────────┐
         │                                │                  │
         │                                │  Artifacts       │
         │                                │  (evidence)      │
         │                                │                  │
         │                                └────────┬─────────┘
         │                                         │
┌────────┴─────────┐                              │
│                  │                              │
│  Decisions &     │←───── learnings ─────────────┤
│  Spec Updates    │                              │
│                  │                              ↓
└──────────────────┘                      ┌──────────────────┐
         ↑                                │                  │
         │                                │  Observations    │
    agent or human                        │  & Insights      │
    decides                               │                  │
                                          └──────────────────┘
```

## Building as Experiment

When entering build phase with unvalidated assumptions, the build itself is an experiment:

| Build type | Purpose | What it tests |
|------------|---------|---------------|
| **Prototype** | Explore feasibility | "Can we build this?" |
| **Spike** | Reduce technical uncertainty | "How does X work?" |
| **MVP** | Test desirability/viability | "Do people want/pay for this?" |
| **A/B test** | Compare approaches | "Which option performs better?" |
| **Labs/opt-in feature** | Test with limited blast radius | "Does this work for real users?" |

Before building, be explicit:

> "This prototype tests assumption X. We'll measure Y. We're right if Z."

This is the Test Card from assumption validation, applied to the build phase.

## Artifacts as Evidence

Building produces artifacts that become evidence:

| Artifact | Evidence type | Example |
|----------|---------------|---------|
| **Working code** | Feasibility confirmed | "We can integrate with their API" |
| **Benchmark results** | Performance validated | "P95 latency is 80ms" |
| **Error logs** | Edge cases discovered | "Fails when input > 10MB" |
| **User behavior data** | Desirability signal | "30% clicked, 5% completed" |
| **Support tickets** | Usability issues | "Users confused by X" |
| **Revenue/conversion** | Viability signal | "2% conversion at $Y price" |

## From Observation to Learning

After building, capture learnings using the Learning Card:

| Step | Prompt |
|------|--------|
| **Hypothesis** | We believed that... |
| **Observation** | We observed... |
| **Learnings** | From that we learned that... |
| **Decisions** | Therefore, we will... |

The "Decisions" step is where the loop closes - learnings become spec updates.

## Decision Authority

When learnings flow back from building, the human and agent discuss them in an interactive session. The agent may propose spec updates directly — the human is present and can steer or override.

Some updates are straightforward enough that the agent can just make them during the conversation:

| Situation | Example |
|-----------|---------|
| Feasibility confirmed | "API supports batch requests" → update spec to use batch |
| Feasibility refuted | "Library doesn't handle edge case" → update spec with workaround |
| Performance validated | "Benchmark shows <100ms" → mark assumption validated |
| Clear pass/fail | "Tests pass" → note the evidence |

Others need the human to decide:

| Situation | Example |
|-----------|---------|
| Ambiguous evidence | "Some users liked it, some didn't" |
| Scope change | "This is bigger than expected" |
| Pivot or persist | "Metrics are mediocre" |
| User/market insight | "Users want different thing" |
| Business model impact | "Margins worse than expected" |

This isn't about agent autonomy vs. human control — it all happens in conversation. The distinction is just: does the agent need to ask, or can it go ahead because the answer is obvious?

## Spec Update Protocol

When learnings flow back to specs:

1. **Identify affected specs** - Which specs contain the assumption that was tested?
2. **Capture the learning** - Learning Card documents what was learned
3. **Determine update type**:
   - Assumption validated → mark as validated, note evidence
   - Assumption refuted → update spec to reflect reality
   - New assumption discovered → add to spec with low evidence
   - Scope change → flag for human decision
4. **Check for blind spots** - Any high-importance assumptions without evidence? (see [observability](./observability.md) gating)
5. **Update readiness** - Re-evaluate what's ready for next phase

## Integration with Other Specs

| Spec | How it connects |
|------|-----------------|
| **Assumption Validation** | Provides the framework for what to test and how to prioritize |
| **Observability** | Gating rules that flag blind spots before handoff |
| **Spec Loop Model** | How spec updates happen (in conversation) |
| **OpenSpcs Core** | The overall tool that orchestrates this |

## Example Flow

1. **Spec created** with assumption: "Users will understand the color picker interface"
   - Importance: High (core interaction)
   - Evidence: Low (no user testing yet)
   - Decision: Build MVP, test with users (high importance + low evidence = de-risk)

2. **Build phase**: MVP built with color picker, deployed to beta users

3. **Artifacts**: Analytics data, support tickets, user session recordings

4. **Observations**: "40% of users abandoned at color picker step. Session recordings show confusion about slider vs. input field."

5. **Learning Card**:
   - We believed users would understand the color picker interface
   - We observed 40% abandonment, confusion between slider and input
   - We learned the dual-input pattern is confusing
   - Therefore, we will simplify to slider-only with manual hex input as advanced option

6. **Decision authority**: This is a UX/scope decision → human confirms

7. **Spec update**: Color picker spec updated with new approach, assumption now has evidence

8. **Next cycle**: Build updated version, test again

## Related

- [Assumptions](./assumptions.md) - What to test and how to prioritize
- [Observability](./observability.md) - Gating rules for blind spots
- [Loop Model](./loop-model.md) - How updates happen in the spec phase

## Review

**Strong spec.** The full cycle diagram, building-as-experiment table, and decision authority breakdown are all clear and well-connected to other specs.

**Spec Update Protocol step 4 references gating that doesn't trigger here.** Step 4 says "Check for blind spots — Any high-importance assumptions without evidence? (see observability gating)." But observability's gating rules fire at two specific moments: draft → ready transitions and implementation planning. The learning-loop's spec update protocol happens during interactive sessions when learnings flow back — that's neither transition. The gating reference implies it should fire here too, but observability doesn't define that trigger.

**"Integration with Other Specs" table references a spec that doesn't exist.** The table lists "Assumption Validation" as a separate spec, but the actual spec is called `assumptions.md` (titled "Assumption Validation"). Minor naming inconsistency — the link in "Related" correctly points to `./assumptions.md`.

**Open questions overlap with observability.** "How do we track which assumptions have been tested across cycles?" — observability's data model answers this (Assumption entity with status field). "How do we prevent learning debt?" — observability's Learning entity with `applied: bool` tracks this. These open questions may already be answered.
