# Debrief

Generated: 2026-02-06

## What's Solid

**Core + Agent Model + Loop Model** — These three form a coherent backbone. Core defines what the tool does, agent-model defines *how* (interactive CC + headless debrief), loop-model frames speccing as conversation with learning as the bigger loop. They reference each other cleanly and don't contradict.

**Assumptions + Learning Loop** — The Strategyzer framework (Test Cards, Learning Cards, D/F/V, Importance x Evidence) is well-defined and the learning loop spec shows a clear cycle from spec through build back to spec. Decision authority is sensibly split (obvious things the agent handles, ambiguous things go to the human).

**Observability data model** — Four entities (Assumption, Experiment, Evidence, Learning), full schemas, clear relationships. The separation of spec content from tracking data is a good call — specs are the destination, tracking records the journey.

## Issues

1. **Backpressure is stale and disconnected.** It still describes a "spec loop" with autonomous iteration (draft → evaluate → refine → re-evaluate), but loop-model explicitly says speccing is a conversation, not a loop. Backpressure categories (deterministic, semi-deterministic, LLM-as-judge, human-only) are reasonable ideas, but the framing of *when and how they run* contradicts the current model. Who triggers these checks — the human during conversation ("any gaps?"), the debrief agent post-session, or some other mechanism? The spec doesn't say.

2. **Spec-lifecycle is a stub that blocks other specs.** Observability's gating rules say "when the agent would move a spec forward" — but forward through *what*? The lifecycle spec lists five states (draft → ready → planning → building → validating) but defines no transitions, no triggers, no ownership. Until this is fleshed out, gating rules are abstract. Backpressure's "quality gates that may block transitions" also hangs on this.

3. **Trust has no data model.** Every other "solid" spec has made its data shape concrete. Trust is still conceptual — levels, signals, what builds trust — but no fields, no storage, no measurement. Observability says "trust level displayed, sourced from trust system" but there's no trust system to source from. The trust spec's own open questions (persistence, per-project vs global, regression) are foundational, not edge cases.

4. **"Spec Backpressure" vs. observability gating — overlapping territory.** Observability defines gating rules (importance >= 5, no evidence → flag). Backpressure defines quality gates (structure, ambiguity, completeness, etc.). These are clearly related but neither spec acknowledges the overlap or explains how they compose. Are observability gates one *type* of backpressure? Does backpressure subsume observability gating? Unclear.

5. **Backpressure references a "spec loop" that doesn't exist.** Line: "For specs to run in a loop, they need equivalent backpressure mechanisms." But the loop-model spec explicitly retired this idea — speccing is a conversation, the loop is the bigger learning cycle. Backpressure needs to reframe around its actual trigger points (during conversation, post-session, pre-handoff).

6. **Learning loop's "Spec Update Protocol" overlaps with observability.** The learning-loop spec describes a 5-step protocol for flowing learnings back to specs (identify affected specs → capture learning → determine update type → apply backpressure → update readiness). Observability's Learning entity also tracks `applied: bool` and `specs_affected`. These describe the same process in different terms. Neither references the other's version.

7. **Open questions are accumulating without resolution.** Core has 4 open questions, agent-model has 2, learning-loop has 4, assumptions has 4, observability has 1, backpressure has 3, trust has 4, spec-lifecycle has 5. Some are genuinely open (form factor), but others are probably answerable now given how the specs have evolved (e.g., "Should assumption validation be integrated into spec drafting?" — the loop model implies yes).

## Next Session

1. **Rework backpressure.** It's the most stale spec and the most disconnected from current thinking. Reframe it: what checks exist, when do they fire (during conversation? post-session? pre-handoff?), and how do they relate to observability's gating. This also forces a decision on how backpressure and observability compose.

2. **Flesh out spec-lifecycle.** Observability and backpressure both depend on specs having defined states and transitions. Even a minimal version (draft/ready/building + who decides + can you go backward) would unblock those specs.

3. **Sweep open questions.** Many are now answerable. Closing the ones that have implicit answers in other specs would tighten everything up and reduce the feeling of accumulated debt.
