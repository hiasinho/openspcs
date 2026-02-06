# Cross-Spec Gap Analysis

Last updated: 2026-02-06

## How to read this

Each finding is something a build agent would need that isn't specified anywhere. These are **not** open questions (those are known), and **not** things explicitly deferred. These are gaps between specs — missing contracts, undefined handoffs, concepts used but never pinned down.

**Severity**:
- **Blocking**: A build agent would have to invent something fundamental. High risk of building the wrong thing.
- **Friction**: A build agent could work around it, but would make arbitrary choices that may conflict with intent.

---

## G01 — No spec output format / template defined

| Field | Value |
|-------|-------|
| **What's missing** | The actual structure of a spec file. Core says specs must be "complete, clear, testable, scoped" and mentions `specs/*.md`, but no spec defines what sections a spec file contains, what's required vs. optional, or what format acceptance criteria take. |
| **Specs affected** | core.md, backpressure.md, loop-model.md, agent-model.md |
| **Severity** | Blocking |
| **Why it matters** | Backpressure defines "structure validation" and "missing required sections" as deterministic checks — but there's no definition of what those sections are. The spec-check agent needs to know what a valid spec looks like. LLM-as-judge needs to know what "complete" means structurally. Every agent that reads or writes specs needs this contract. Without it, each agent invents its own idea of what a spec should look like. |

---

## G02 — Trust data model and storage undefined

| Field | Value |
|-------|-------|
| **What's missing** | How trust level is represented, stored, and updated. Observability says "the dashboard reads trust data from the trust system" but trust.md defines trust conceptually (levels, signals, what builds trust) without specifying any data model, storage mechanism, or API. |
| **Specs affected** | trust.md, observability.md, loop-model.md, learning-loop.md, agent-model.md |
| **Severity** | Blocking |
| **Why it matters** | Trust level gates agent behavior in multiple specs: loop-model (when to ask vs. work autonomously), learning-loop (decision authority), agent-model (write permissions). The observability dashboard needs to read it. But there's no entity definition (unlike the 4 entities in observability.md), no status transitions, no persistence mechanism, and no algorithm for how signals translate to level changes. A build agent would have to invent the entire trust system from narrative descriptions. |

---

## G03 — Handoff contract between OpenSpcs and downstream consumer (Ralph planning) undefined

| Field | Value |
|-------|-------|
| **What's missing** | What OpenSpcs produces that Ralph's planning mode consumes. Core says specs "feed into implementation planning (e.g., Ralph's planning mode)" and agent-model shows Phase 1 → Phase 2, but the interface between them isn't specified. |
| **Specs affected** | core.md, agent-model.md, spec-lifecycle.md |
| **Severity** | Blocking |
| **Why it matters** | The "readiness report" mentioned in core.md is undefined. The lifecycle transition from "ready" to "planning" has no contract. A build agent implementing the planning phase wouldn't know what format to expect, what metadata accompanies the handoff, or what constitutes "ready enough." The dual-audience requirement (human + machine readable) has no concrete definition of what the machine side needs. |

---

## G04 — Spec identity and referencing scheme undefined

| Field | Value |
|-------|-------|
| **What's missing** | How specs are identified and referenced. Observability defines `Assumption.spec` as "path to the spec this belongs to" and `Learning.specs_affected` as "which specs this learning applies to." But there's no spec defining how specs get IDs, whether it's file path, slug, or something else. |
| **Specs affected** | observability.md, learning-loop.md, assumptions.md |
| **Severity** | Friction |
| **Why it matters** | The entire tracking data model references specs by ID. If assumptions, evidence, and learnings all point at specs, the referencing scheme needs to be stable. File paths change if specs get renamed or reorganized. A build agent implementing the database schema would need to decide: is the spec ID the filename? A slug? A UUID? This affects foreign keys across all 4 tracking entities. |

---

## G05 — Backpressure check results have no specified output format

| Field | Value |
|-------|-------|
| **What's missing** | What backpressure checks return. Backpressure defines categories (deterministic, semi-deterministic, LLM-as-judge, human-only) and lists specific checks, but doesn't specify the output format. Do they return pass/fail? A severity? A list of issues with locations? |
| **Specs affected** | backpressure.md, loop-model.md, agent-model.md, observability.md |
| **Severity** | Friction |
| **Why it matters** | The spec-check utility agent runs backpressure checks. The loop model uses results to decide "pass → continue, fail → refine." The observability dashboard shows "which quality gates are passing/failing." All three consumers need a contract for what a check result looks like. Without one, each consumer would interpret results differently. |

---

## G06 — No concurrency model for multi-spec sessions

| Field | Value |
|-------|-------|
| **What's missing** | What happens when an interactive session touches multiple specs simultaneously. Core says sessions can "expand to discover related topics." The loop model shows a flow for a single spec. But what happens when the user is discussing spec A and the agent discovers it impacts specs B and C? |
| **Specs affected** | core.md, loop-model.md, agent-model.md |
| **Severity** | Friction |
| **Why it matters** | The loop model shows a clean cycle for one spec at a time. The post-session flow in agent-model runs utility agents on "modified specs." But during an interactive session, cross-cutting concerns arise constantly. A build agent would need to decide: does the loop run per-spec in parallel? Serially? Is there a session-level loop that encompasses multiple spec-level loops? This affects how the agent manages context and state. |

---

## G07 — Assumption extraction: what's an assumption vs. a decision

| Field | Value |
|-------|-------|
| **What's missing** | Criteria for what qualifies as an "assumption" that should enter the tracking system. Assumptions.md says "implicit beliefs about users, technology, business viability" and observability.md defines the entity, but there's no boundary between an assumption (needs testing) and a decision (already made). |
| **Specs affected** | assumptions.md, observability.md, agent-model.md |
| **Severity** | Friction |
| **Why it matters** | The extract-assumptions agent needs to know what to extract. Every spec is full of statements. "Specs are markdown files" — is that an assumption or a decision? "The agent is Claude Code" — assumption or decision? Without criteria, the agent either over-extracts (everything is an assumption, tracker is noise) or under-extracts (real risks go untracked). The importance rating helps prioritize but doesn't help with the initial extraction boundary. |

---

## G08 — No error/recovery model for the autonomous loop

| Field | Value |
|-------|-------|
| **What's missing** | What happens when things go wrong in the spec loop. The loop model shows a happy path (research → draft → evaluate → gap → loop). But what if the agent produces a draft that fails backpressure repeatedly? What if research yields nothing? What if the agent can't determine if a gap is technical or knowledge? |
| **Specs affected** | loop-model.md, backpressure.md, agent-model.md |
| **Severity** | Friction |
| **Why it matters** | The agent-model's open question about "what happens when a utility agent fails" is one piece of this, but it's broader. The loop model has no maximum iteration count, no escalation path for stuck loops, and no degradation strategy. A build agent implementing the loop would need to decide: after how many failed backpressure cycles does it stop? When does it escalate to the human even for "technical" gaps? Without this, the loop could thrash indefinitely or silently give up. |

---

## G09 — Observability gating rules reference spec states that spec-lifecycle doesn't fully define

| Field | Value |
|-------|-------|
| **What's missing** | Spec-lifecycle is a stub. Observability's gating rules say "when the agent would move a spec forward" and reference transitions like "mark as ready, hand off for planning." The stub lists 5 states but defines no transitions, no triggers, and no who-decides. |
| **Specs affected** | observability.md, spec-lifecycle.md, backpressure.md |
| **Severity** | Blocking |
| **Why it matters** | Gating rules are the safety mechanism — they prevent building on blind spots. But gating rules fire on state transitions, and state transitions aren't defined. A build agent can't implement "check for blind spots before marking ready" without knowing what event triggers that check, what "ready" requires beyond gating, and whether the human or agent initiates the transition. This is correctly identified as a stub, but the dependency is load-bearing enough that building anything around gating would require inventing the lifecycle. |

---

## G10 — Context continuity between sessions undefined

| Field | Value |
|-------|-------|
| **What's missing** | How context transfers between interactive sessions. Agent-model shows "next interactive session informed by findings" but doesn't specify how. Claude Code has no persistent memory across sessions — the loop-model notes this as an open question ("should context be cleared or maintained?") but it's more than a loop question. |
| **Specs affected** | agent-model.md, loop-model.md, core.md |
| **Severity** | Friction |
| **Why it matters** | The post-session flow produces findings. The next session needs those findings. But how? Does the human paste them? Does a CLAUDE.md file get auto-updated? Is there a "session start" prompt that loads findings? The agent-model's shell-script orchestration implies file-based context, but the interactive session needs to know where to look. Without this, the multi-session workflow has a broken link between "findings produced" and "findings consumed." |

---

## G11 — Learning-loop decision authority criteria don't connect to trust levels

| Field | Value |
|-------|-------|
| **What's missing** | Learning-loop defines when the agent can decide autonomously vs. when it must escalate. Trust defines trust levels that adjust authority. But the two specs don't connect — learning-loop's criteria (unambiguous evidence, within original intent, no strategic judgment, no scope change) don't reference trust level at all. |
| **Specs affected** | learning-loop.md, trust.md |
| **Severity** | Friction |
| **Why it matters** | At low trust, should the agent be autonomous even when evidence is unambiguous? At high trust, should ambiguous evidence still require escalation? The learning-loop criteria read as fixed rules, but trust.md says authority should be a gradient. A build agent would have to decide whether decision authority is trust-dependent or trust-independent, and the specs give contradictory signals. |

---

## G12 — Tracking data initialization: how do assumptions get into the system?

| Field | Value |
|-------|-------|
| **What's missing** | The flow from "spec text mentions a belief" to "assumption entity exists in the tracking database." The extract-assumptions agent is listed in agent-model, and observability defines the Assumption entity, but the transformation isn't specified. Does the agent create assumption entities with auto-generated IDs? Does it set initial importance? Does the human review extracted assumptions before they enter the tracker? |
| **Specs affected** | agent-model.md, observability.md, assumptions.md |
| **Severity** | Friction |
| **Why it matters** | The extract-assumptions agent is the entry point for the entire tracking system. Every downstream flow (experiments, evidence, learnings, gating) depends on assumptions existing in the tracker. But the agent's output format, the review process, and the creation protocol are unspecified. If assumptions auto-enter with agent-assigned importance, the tracker could fill with noise. If they require human review, there's a bottleneck that isn't modeled. |

---

## Summary

| # | Gap (short) | Severity | Primary specs |
|---|-------------|----------|---------------|
| G01 | No spec output format/template | Blocking | core, backpressure |
| G02 | Trust data model undefined | Blocking | trust, observability |
| G03 | Handoff contract to downstream (Ralph) | Blocking | core, agent-model, spec-lifecycle |
| G04 | Spec identity/referencing scheme | Friction | observability, learning-loop |
| G05 | Backpressure output format | Friction | backpressure, loop-model, agent-model |
| G06 | Multi-spec session concurrency | Friction | core, loop-model |
| G07 | Assumption vs. decision boundary | Friction | assumptions, observability, agent-model |
| G08 | Error/recovery model for loop | Friction | loop-model, backpressure |
| G09 | Spec-lifecycle stub blocks gating | Blocking | observability, spec-lifecycle |
| G10 | Context continuity between sessions | Friction | agent-model, loop-model |
| G11 | Decision authority × trust level disconnect | Friction | learning-loop, trust |
| G12 | Assumption entity creation flow | Friction | agent-model, observability |

**Blocking: 4** | **Friction: 8**
