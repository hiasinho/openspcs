# Spec Observability

**Status**: Solid — data model complete, gating rules defined

## Core Idea

This spec describes the **built system** — the application that manages specs and their learning process. During the design phase, we write markdown specs in this repo. The system we're building will store and manage all of this in a database.

Specs and tracking data are separate concerns:

- **Specs** are the document of truth for decisions. They state beliefs and capture what's been learned.
- **Tracking data** (assumptions, experiments, evidence, learnings) records whether those beliefs have been tested, what was found, and what insights emerged.

The agent maintains both. When a learning gets applied, the agent updates the spec to reflect the new understanding. The tracking data records why the change happened.

All metrics are calculated from tracking data, never manually updated.

## Data Model

Tracking data is stored in the system's database, separate from spec content. The specific database (Postgres, SQLite, etc.) is an implementation decision. The entities and relationships defined below are the schema.

**Why separate?** Assumption state (tested? validated? evidence?) is metadata *about* the spec, not part of the spec itself. When an assumption gets validated or refuted, that influences the spec — the agent updates the spec to reflect what was learned. The tracking layer captures the journey; the spec captures the destination.

**Contract between specs and tracking data:**
- Specs define assumptions as beliefs (what and why)
- Tracking entities reference specs by id
- State changes in the tracking layer trigger spec updates via learnings
- The agent is responsible for keeping both in sync
- Multiple agents can read and write tracking data concurrently — the database handles concurrency

### Entities

#### Assumption

A belief the spec depends on that needs validation.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| spec | string | Path to the spec this belongs to |
| statement | string | The belief ("users want to spec before building") |
| area | enum | Desirability / Feasibility / Viability |
| importance | int (1-10) | How load-bearing. 10 = everything breaks if false |
| status | enum | open → testing → validated / refuted |
| created_at | timestamp | When this assumption was identified |
| updated_at | timestamp | Last status change |

Status transitions: an assumption with no linked evidence is `open`. Once an experiment targets it, it moves to `testing`. Moving to `validated` or `refuted` is a judgment call — a human or agent reviews the evidence and decides. This is not automatic, because evidence can be mixed or ambiguous.

#### Experiment

An activity that produces evidence for one or more assumptions.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| assumptions | list[string] | Assumption ids this experiment targets |
| description | string | What we're doing |
| method | string | How — interview, web research, prototype measurement, etc. |
| conductor | enum | human / agent |
| status | enum | planned → running → complete |
| created_at | timestamp | When this experiment was created |
| updated_at | timestamp | Last status change |

One experiment can produce evidence for multiple assumptions. Methods are not a fixed taxonomy — they describe what was actually done.

#### Evidence

A data point collected by an experiment, linked to a specific assumption.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| experiment | string | Which experiment produced this |
| assumption | string | Which assumption this is evidence for |
| finding | string | What was found |
| direction | enum | supports / contradicts |
| strength | int (1-5) | 1 = weak (someone said so), 5 = strong (someone paid) |
| collected_by | enum | human / agent |
| collected_at | timestamp | When this was collected |

Evidence is the bridge between experiments and assumptions. One experiment targeting 3 assumptions might support one and contradict another — each evidence item carries its own direction and strength.

Both humans and agents can collect evidence. Either can do qualitative or quantitative work — a human might find market data, an agent might run a Google Trends search. The distinction is who did the collecting, not what kind of data it is.

#### Learning

An interpreted insight derived from evidence that changes how you think.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| statement | string | The insight ("LLMs are better at spotting what's wrong than spotting what's missing") |
| evidence | list[string] | Evidence ids that led to this insight |
| specs_affected | list[string] | Which specs this learning applies to |
| applied | bool | Whether the spec updates have been made |
| discovered_at | timestamp | When this learning emerged |

Evidence is raw data. Learning is the "so what" — the meaning that changes decisions. A learning can draw from multiple pieces of evidence and affect multiple specs. An unapplied learning (`applied: false`) is a pending spec update.

### Entity Relationships

```
Experiment  ──produces──▶  Evidence  ──supports/contradicts──▶  Assumption
                               │
                           informs
                               │
                               ▼
                           Learning  ──applied to──▶  Spec
```

## Gating Rules

Gating is a **soft gate**: the agent flags blind spots and waits for a human decision. The human can say "go anyway" or "let's design an experiment first." The agent never silently proceeds past a gate, and never hard-blocks without offering a path forward.

### During Speccing

When the agent would move a spec forward (e.g., mark as ready, hand off for planning), it checks for assumptions with **importance >= 5** and **no evidence**. If any exist, the agent flags them and asks how to proceed:

- Design an experiment to collect evidence
- Lower the importance (it's not as critical as we thought)
- Proceed anyway (accept the risk explicitly)

### During Implementation Planning

When the agent creates an implementation plan, it checks for high-importance unvalidated assumptions. Acceptable if an experiment is in place (status: `planned` or `running`). If importance >= 5 and there's no experiment at all, the agent flags it and waits — same options as above.

## Key Metrics

All metrics are derived from tracking data.

### Assumption Health

| Metric | How it's calculated |
|--------|---------------------|
| **Total assumptions** | Count of all assumption entities |
| **Checked %** | Of assumptions with importance >= 5, what % have at least one piece of evidence |
| **By area (D/F/V)** | Breakdown by Desirability / Feasibility / Viability |
| **Blind spots** | Assumptions with importance >= 5 and zero evidence |
| **Trend** | Computed from entity timestamps — e.g., "3 assumptions validated this week" based on `updated_at` changes. No periodic snapshots needed. |

### Experiment Status

- Active experiments (status: running)
- Completed experiments (status: complete, results pending review)
- Planned experiments (status: planned, not yet started)

### Learning Velocity

- Learnings captured (total count)
- Learnings applied vs. pending (applied: true vs. false)
- Learning rate (learnings per time period)

## Dashboard Concept

```
┌─────────────────────────────────────────────────────────────────┐
│  OpenSpcs: [project-name]                                       │
├─────────────────────────────────────────────────────────────────┤
│  Blind spots: 3                                                  │
├─────────────────────────────────────────────────────────────────┤
│  Assumptions                                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Total: 14    Checked: 9    Unchecked (important): 3      │  │
│  │                                                          │  │
│  │ By area:  Desirability ●●●○○   Feasibility ●●●●○        │  │
│  │           Viability ●●○○○                                │  │
│  │                                                          │  │
│  │ Trend: ↗ improving (3 checked this week)                 │  │
│  └──────────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│  Experiments: 2 running, 1 planned                              │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • "LLM can self-evaluate specs" → prototype running      │  │
│  │ • "Users want to spec first" → 2 interviews scheduled    │  │
│  │ • "Backpressure catches ambiguity" → planned             │  │
│  └──────────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│  Learnings: 2 pending                                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • LLMs better at wrongness than missingness → pending    │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Drill-Down Views

### Assumption Detail

```
┌─────────────────────────────────────────────────────────────────┐
│  Assumption: "LLM can reliably self-evaluate spec quality"      │
├─────────────────────────────────────────────────────────────────┤
│  Area: Feasibility                                              │
│  Importance: 8                                                  │
│  Status: Testing                                                │
│  Evidence: 3 items (2 support, 1 contradicts)                   │
├─────────────────────────────────────────────────────────────────┤
│  Experiment: prototype-backpressure-v1                          │
│  Method: Build prototype and measure accuracy vs. human eval    │
│  Conductor: Agent                                               │
│  Status: Running (started 2026-02-03)                           │
├─────────────────────────────────────────────────────────────────┤
│  Evidence                                                       │
│  • Ambiguity detection 90% accuracy (strength: 4, supports)     │
│  • Completeness checking 60% accuracy (strength: 4, contradicts)│
│  • False positives on early-stage specs (strength: 3, supports) │
├─────────────────────────────────────────────────────────────────┤
│  Learnings: pending                                             │
└─────────────────────────────────────────────────────────────────┘
```

### Experiment View

| Experiment | Assumptions | Conductor | Status | Evidence |
|------------|-------------|-----------|--------|----------|
| prototype-backpressure-v1 | LLM self-evaluation | Agent | Running | 3 items |
| user-interviews-round1 | Users want to spec first | Human | Planned | 0 items |
| ambiguity-linter-test | Backpressure catches ambiguity | Agent | Complete | 5 items |

### Learning Log

| Date | Learning | Evidence from | Applied to | Status |
|------|----------|---------------|------------|--------|
| 2026-02-05 | Loop model more important than perfect backpressure | Discussion | learning-loop.md | Applied |
| 2026-02-03 | LLMs better at spotting wrongness than missingness | prototype-backpressure-v1 | — | Pending |

## Connection to Other Concepts

| Concept | What becomes visible |
|---------|---------------------|
| **Assumption Validation** | Assumption count, status, area breakdown, blind spots |
| **Learning Loop** | Learnings captured, applied, velocity |
| **Spec Review** | Post-session review notes written into each spec |

## Open Questions

- What's the minimum viable dashboard vs. nice-to-have?

## Related

- [Assumptions](./assumptions.md) - Source of assumption data
- [Learning Loop](./learning-loop.md) - Source of learning data
- [Agent Model](./agent-model.md) - Spec review agent as post-session quality check

## Review

**Stale status line.** The status says "gating rules depend on spec-lifecycle (still a stub)" but spec-lifecycle is now Solid. The README also says "blocked on spec-lifecycle." Both should be updated.

**This spec describes a different thing than the others.** Every other spec describes a conversation-based workflow using Claude Code and markdown files. This spec describes a built application with a database, entities, dashboards, and drill-down views. The opening paragraph acknowledges this ("this spec describes the built system"), but the gap is significant. The data model (Assumption, Experiment, Evidence, Learning) is a fully relational schema — far more structured than anything else in the spec set. Worth being explicit about when this system gets built vs. what happens in the meantime with markdown-based tracking.

**Gating trigger gap with learning-loop.** Learning-loop's Spec Update Protocol step 4 references observability gating, but the gating rules here only define two triggers: draft → ready transitions and implementation planning. Learnings flowing back to specs during interactive sessions isn't covered. If gating should fire there too, it needs to be defined.

**Data model is solid.** The four entities (Assumption, Experiment, Evidence, Learning) and their relationships are well-defined. The separation of evidence from learning (raw data vs. interpreted insight) is a good design choice. The contract between specs and tracking data is clear.
