# Spec Observability

**Status**: WIP - Making spec state visible through metrics and dashboards

## Core Idea

Spec state currently lives in static markdown files. To make informed decisions about trust, progress, and where to focus, humans need visibility into:

- How many assumptions are on the table
- How many have been validated vs. are still open
- What experiments are running
- What we've observed and learned
- The strength of evidence
- Trends over time

This is a **dashboard for spec health**.

## Key Metrics

### Learning Level

How much have we actually learned from building and testing?

- Learnings captured
- Learnings applied to spec updates
- Learning velocity (learnings per time period)

### Trust Level

How much autonomy has the agent earned?

- Current trust level (low → medium → high → YOLO)
- Trust trend (building or eroding)
- Recent trust signals (overrides, delegations)

### Assumption Health

| Metric | What it measures |
|--------|------------------|
| **Total assumptions** | Are we aware of our risks? |
| **Validated %** | How much is proven vs. hoped? |
| **By lens (D/F/V)** | Where are our biggest unknowns? |
| **By importance** | Are high-importance assumptions validated? |
| **Evidence strength** | Strong data or gut feeling? |
| **Trend** | Getting better or stagnating? |

### Experiment Status

- Active experiments (currently running)
- Completed experiments (results pending review)
- Experiments with observations (awaiting learning extraction)

## Dashboard Concept

```
┌─────────────────────────────────────────────────────────────────┐
│  OpenSpcs: [project-name]                                       │
├─────────────────────────────────────────────────────────────────┤
│  Trust Level: ████████░░ 78%      Learning Level: ██████░░░░ 62%│
├─────────────────────────────────────────────────────────────────┤
│  Assumptions                                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Total: 14    Validated: 6    Testing: 3    Open: 5       │  │
│  │                                                          │  │
│  │ By lens:  Desirability ●●●○○   Feasibility ●●●●○        │  │
│  │           Viability ●●○○○                                │  │
│  │                                                          │  │
│  │ Evidence trend: ↗ improving (3 validated this week)      │  │
│  └──────────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│  Active Experiments: 3                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • "LLM can self-evaluate specs" → prototype running      │  │
│  │ • "Users want to spec first" → 2 interviews scheduled    │  │
│  │ • "Backpressure catches ambiguity" → testing with linter │  │
│  └──────────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│  Recent Learnings                                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • Trust threshold varies by person → added personalization│  │
│  │ • Loop model works but needs trust gradient (2026-02-05) │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘

[View all assumptions] [View experiments] [View learnings]
```

## Drill-Down Views

### Assumption Detail

Click into any assumption to see:

```
┌─────────────────────────────────────────────────────────────────┐
│  Assumption: "LLM can reliably self-evaluate spec quality"      │
├─────────────────────────────────────────────────────────────────┤
│  Lens: Feasibility                                              │
│  Importance: High (core to loop model)                          │
│  Evidence: Low → Medium (improving)                             │
│  Status: Testing                                                │
├─────────────────────────────────────────────────────────────────┤
│  Test Card                                                      │
│  • Hypothesis: LLM can identify incomplete/ambiguous specs      │
│  • Test: Build prototype backpressure checker                   │
│  • Metric: Accuracy vs. human evaluation on 20 specs            │
│  • Criteria: >80% agreement with human judgment                 │
├─────────────────────────────────────────────────────────────────┤
│  Experiment: prototype-backpressure-v1                          │
│  Started: 2026-02-03                                            │
│  Status: Running                                                │
├─────────────────────────────────────────────────────────────────┤
│  Observations (so far)                                          │
│  • Ambiguity detection works well (90% accuracy)                │
│  • Completeness checking is harder (60% accuracy)               │
│  • False positives on early-stage specs                         │
├─────────────────────────────────────────────────────────────────┤
│  Learning Card: (pending - experiment not complete)             │
└─────────────────────────────────────────────────────────────────┘
```

### Experiment View

All experiments with status:

| Experiment | Assumption | Status | Started | Observations |
|------------|------------|--------|---------|--------------|
| prototype-backpressure-v1 | LLM self-evaluation | Running | 2026-02-03 | 3 |
| user-interviews-round1 | Users want to spec first | Scheduled | - | 0 |
| ambiguity-linter-test | Backpressure catches ambiguity | Complete | 2026-02-01 | 5 |

### Learning Log

Chronological list of learnings with links to source:

| Date | Learning | Source | Applied to |
|------|----------|--------|------------|
| 2026-02-05 | Trust threshold varies by person | Discussion | trust.md |
| 2026-02-05 | Learning loop more important than perfect backpressure | Discussion | learning-loop.md |
| 2026-02-03 | Ambiguity detection easier than completeness | Experiment | backpressure.md |

## Data Model

Where does this data live?

### Option A: Embedded in Specs

Assumptions, experiments, and learnings are embedded in spec markdown files with structured frontmatter or sections. Dashboard parses specs to generate view.

**Pros**: Single source of truth, human-readable
**Cons**: Harder to query, update friction

### Option B: Separate Tracking Files

Like Beads - structured data files (JSONL, YAML) that track assumptions, experiments, learnings separately. Specs reference them.

**Pros**: Easier to query, update, track changes
**Cons**: Data can drift from specs

### Option C: Hybrid

Core info in specs, but indexes/caches generated for dashboard. Learning Cards and Test Cards as structured data linked to specs.

**Pros**: Best of both, specs remain readable
**Cons**: More complexity

## Connection to Other Concepts

| Concept | What becomes visible |
|---------|---------------------|
| **Assumption Validation** | Assumption count, status, D/F/V breakdown |
| **Learning Loop** | Learnings captured, applied, velocity |
| **Trust Model** | Trust level, trend, signals |
| **Spec Backpressure** | Which quality gates are passing/failing |

## Open Questions

- What's the right data model (embedded vs. separate vs. hybrid)?
- How do we avoid observability overhead slowing down spec creation?
- Should metrics be calculated or manually updated?
- What's the minimum viable dashboard vs. nice-to-have?
- How does this integrate with Beads or other task trackers?

## Related

- [Assumptions](./assumptions.md) - Source of assumption data
- [Learning Loop](./learning-loop.md) - Source of learning data
- [Trust](./trust.md) - Trust level as a key metric
- [Backpressure](./backpressure.md) - Quality gates to display
