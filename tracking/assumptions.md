# Assumption Tracker

Last updated: 2026-02-06

## How to read this

Each assumption is a belief the design depends on. If false, the design breaks — not adjusts, breaks.

- **Importance**: How load-bearing (1-10). 10 = everything collapses if wrong.
- **Status**: `open` (no evidence), `testing` (experiment underway), `validated`, `refuted`
- **Area**: Desirability (D), Feasibility (F), Viability (V)

---

## A01 — LLMs can judge spec quality well enough to drive an autonomous loop

| Field | Value |
|-------|-------|
| **Statement** | An LLM can evaluate specs against quality criteria (complete, clear, testable, scoped) with enough accuracy to provide meaningful backpressure — catching real problems without thrashing or false convergence. |
| **Area** | Feasibility |
| **Importance** | 10 |
| **Status** | open |
| **Sources** | backpressure.md, loop-model.md, agent-model.md, core.md |
| **Evidence** | — |
| **Notes** | This is the #1 bet. The autonomous loop, backpressure system, and headless utility agents all depend on LLM quality judgment. If evaluation doesn't converge, the loop thrashes. If it's too lenient, bad specs ship. If it's too strict, nothing ever passes. The observability spec's prototype shows early signals (ambiguity detection ~90%, completeness ~60%). |

---

## A02 — The agent can reliably distinguish "I can figure this out" from "I need to ask the human"

| Field | Value |
|-------|-------|
| **Statement** | The agent can accurately classify gaps as technical (resolvable through research) vs. knowledge (requires human input) and switch between autonomous and interview mode at the right moments. |
| **Area** | Feasibility |
| **Importance** | 10 |
| **Sources** | loop-model.md, learning-loop.md, agent-model.md, assumptions.md |
| **Evidence** | — |
| **Notes** | If the agent asks too much, it creates friction and erodes trust. If it asks too little, it produces wrong specs silently. The loop model, learning loop decision authority, and supervisor agent all depend on correct mode switching. This also covers the agent knowing when it has decision authority vs. when to escalate. |

---

## A03 — Users want spec-first workflow with conversational interviewing

| Field | Value |
|-------|-------|
| **Statement** | Users prefer being interviewed to create complete specifications before implementation over (a) writing specs themselves, (b) skipping specs entirely and iterating on code, or (c) using templates/forms. |
| **Area** | Desirability |
| **Importance** | 10 |
| **Sources** | core.md, loop-model.md |
| **Evidence** | — |
| **Notes** | The entire product exists for this. If users don't want conversational spec creation, the tool has no market. This is the foundational desirability bet. It also assumes users have at least a rough idea (not blank-slate ideation) — if they need brainstorming/generative tools, the interview model doesn't serve them. |

---

## A04 — LLMs can sense clarity level and adapt interview style dynamically

| Field | Value |
|-------|-------|
| **Statement** | An LLM can detect where users are on the uncertainty-to-clarity spectrum and automatically adjust conversation style — open-ended when exploring, structured when filling gaps. |
| **Area** | Feasibility |
| **Importance** | 9 |
| **Sources** | core.md |
| **Evidence** | — |
| **Notes** | The adaptive interview is core UX. If the LLM can't sense clarity, the system either forces one mode (rigid) or switches randomly (chaotic). This also covers the LLM's ability to choose decomposition strategies (needs-driven, architecture-driven, etc.) organically during conversation. |

---

## A05 — Claude Code's headless mode (`claude -p`) can support the utility agent architecture

| Field | Value |
|-------|-------|
| **Statement** | Claude Code running headless can: (a) load all necessary context from files without persistent memory, (b) produce reliable single-purpose outputs, (c) be orchestrated by shell scripts, and (d) be composed — including a supervisor agent invoking other headless agents. |
| **Area** | Feasibility |
| **Importance** | 9 |
| **Sources** | agent-model.md |
| **Evidence** | — |
| **Notes** | The entire post-session automation flow depends on this. If headless agents can't reconstruct context from files, or if shell orchestration is too brittle, or if meta-orchestration (supervisor calling utility agents) doesn't work, the whole autonomous half of the system fails. Each headless invocation must be stateless yet effective. |

---

## A06 — Specs and tracking data can be maintained as separate concerns without losing coherence

| Field | Value |
|-------|-------|
| **Statement** | The system can maintain specs (markdown files representing decisions) and tracking data (assumptions, experiments, evidence, learnings in a database) as separate concerns, with the agent keeping them in sync. |
| **Area** | Feasibility |
| **Importance** | 9 |
| **Sources** | observability.md, agent-model.md, learning-loop.md |
| **Evidence** | — |
| **Notes** | The observability data model, agent write permissions, and learning loop all depend on this separation. The contract requires the agent to keep both in sync — if bidirectional sync fails, data diverges (tracking says "validated" but spec doesn't reflect it). Also covers the clean boundary between metadata (agent-writable) and decisions (human-writable). |

---

## A07 — The learning loop can close: build evidence traces back to assumptions and updates specs

| Field | Value |
|-------|-------|
| **Statement** | Building produces artifacts that can be interpreted as evidence about specific assumptions, that evidence can be classified (supports/contradicts with meaningful strength), learnings can be extracted, and those learnings can flow back to update specs without starting from scratch. |
| **Area** | Feasibility |
| **Importance** | 9 |
| **Sources** | learning-loop.md, observability.md, assumptions.md |
| **Evidence** | — |
| **Notes** | If build artifacts don't yield traceable evidence, the cycle is broken at "spec → build → ??? → spec". If evidence is always ambiguous, the system can't move assumptions from "testing" to "validated/refuted". If spec updates from learnings require full re-specification, the loop is too expensive. This is the engine of the whole system. |

---

## A08 — Trust can be built incrementally and users want progressive autonomy

| Field | Value |
|-------|-------|
| **Statement** | Trust between human and agent builds through demonstrated competence + ability to influence, users want this progression toward more autonomy (not fixed control), and the agent can meaningfully adapt its behavior based on trust level. |
| **Area** | Desirability |
| **Importance** | 8 |
| **Sources** | trust.md, loop-model.md, agent-model.md, learning-loop.md |
| **Evidence** | — |
| **Notes** | The entire trust gradient (high friction → YOLO) depends on this. If users prefer consistent control levels, or if agent behavior can't meaningfully change with trust, or if trust signals (corrections, delegation, frustration) are undetectable, the graduated system is unnecessary. Write permissions, decision authority, and loop autonomy all key off trust level. |

---

## A09 — Soft gates prevent teams from building on unvalidated high-importance assumptions

| Field | Value |
|-------|-------|
| **Statement** | When the agent flags blind spots (importance >= 5, no evidence), teams will actually pause and address them rather than always choosing "proceed anyway." |
| **Area** | Desirability |
| **Importance** | 8 |
| **Sources** | observability.md, assumptions.md, learning-loop.md |
| **Evidence** | — |
| **Notes** | The gating mechanism is a soft gate by design (agent flags, human decides). If teams consistently override, the validation system provides no risk mitigation. This also depends on the system being able to extract and rate importance of assumptions accurately — if blind spots can't be detected, there's no safety net. |

---

## A10 — LLMs can extract implicit specs from existing artifacts

| Field | Value |
|-------|-------|
| **Statement** | LLMs can analyze existing code, documentation, and other artifacts to infer what specifications they imply, enabling gap analysis for projects that aren't greenfield. |
| **Area** | Feasibility |
| **Importance** | 8 |
| **Sources** | core.md, loop-model.md |
| **Evidence** | — |
| **Notes** | Multiple entry points involve existing projects (legacy revival, running production app, partially-built app). If LLMs can't reverse-engineer specs from implementation, the tool only works for greenfield, cutting out major use cases. The autonomous research loop also depends on this for the "explore codebase, read docs" step. |

---

## A11 — Teams will adopt experiment-minded building (build to learn, not just to ship)

| Field | Value |
|-------|-------|
| **Statement** | Teams will treat building as experimentation — explicitly stating what assumptions a prototype/spike/MVP tests, measuring outcomes against criteria, and feeding learnings back to specs. |
| **Area** | Desirability |
| **Importance** | 8 |
| **Sources** | learning-loop.md, assumptions.md |
| **Evidence** | — |
| **Notes** | The learning loop requires teams to enter the build phase with intent to learn, not just ship. If they skip "this prototype tests assumption X, we'll measure Y, we're right if Z" and just build-to-ship, they won't capture structured learnings, and the loop produces no feedback. This is a mindset shift — adoption is the real risk. |

---

## A12 — Dual-audience specs (human-readable AND machine-consumable) are achievable

| Field | Value |
|-------|-------|
| **Statement** | A single spec format (markdown) can be both clear and editable for humans and structured enough for AI implementation planning tools and automated backpressure checks to parse. |
| **Area** | Feasibility |
| **Importance** | 8 |
| **Sources** | core.md, backpressure.md, agent-model.md |
| **Evidence** | — |
| **Notes** | If optimizing for human readability makes specs unparseable, automated backpressure fails. If optimizing for machine consumption makes specs hard for humans to edit, adoption fails. Deterministic backpressure checks require parseable structure. The downstream consumer (Ralph planning mode) must be able to meaningfully consume what OpenSpcs produces. |

---

## A13 — A dedicated spec tool provides enough ROI to justify adoption

| Field | Value |
|-------|-------|
| **Statement** | The specification phase is valuable enough that users will adopt a separate tool for it, rather than skipping specs, using general-purpose tools, or doing it informally. |
| **Area** | Viability |
| **Importance** | 8 |
| **Sources** | core.md (implicit) |
| **Evidence** | — |
| **Notes** | This is a single-purpose tool for one workflow phase. The overhead of learning/using it must be exceeded by the value it provides. If users can get 80% of the benefit from a simple conversation with Claude without specialized tooling, the tool layer adds cost without proportional value. Also depends on a downstream consumer (Ralph's planning mode) existing to create the value chain. |

---

## A14 — LLMs can assess spec readiness ("done enough to build from")

| Field | Value |
|-------|-------|
| **Statement** | An LLM can reliably determine when a spec has enough clarity and coverage for implementation planning to begin meaningfully. |
| **Area** | Feasibility |
| **Importance** | 8 |
| **Sources** | core.md, loop-model.md, spec-lifecycle.md |
| **Evidence** | — |
| **Notes** | Completion detection is critical for workflow handoff. If the LLM can't assess readiness, users either get incomplete specs sent to implementation (causing failure) or stay stuck in specification forever. This is the termination condition for the spec loop and the trigger for lifecycle state transitions (draft → ready). |

---

## Summary

| # | Assumption (short) | Area | Imp | Status |
|---|-------------------|------|-----|--------|
| A01 | LLM can judge spec quality for autonomous loop | F | 10 | open |
| A02 | Agent distinguishes "figure out" from "ask human" | F | 10 | open |
| A03 | Users want spec-first conversational workflow | D | 10 | open |
| A04 | LLM adapts interview style to clarity level | F | 9 | open |
| A05 | Claude Code headless supports agent architecture | F | 9 | open |
| A06 | Specs and tracking data work as separate concerns | F | 9 | open |
| A07 | Learning loop closes: evidence → assumptions → specs | F | 9 | open |
| A08 | Trust builds incrementally, users want progressive autonomy | D | 8 | open |
| A09 | Soft gates actually prevent building on blind spots | D | 8 | open |
| A10 | LLMs extract implicit specs from existing artifacts | F | 8 | open |
| A11 | Teams adopt experiment-minded building | D | 8 | open |
| A12 | Dual-audience specs (human + machine) achievable | F | 8 | open |
| A13 | Dedicated spec tool provides enough ROI | V | 8 | open |
| A14 | LLM assesses spec readiness for handoff | F | 8 | open |

**By area**: Feasibility: 9 | Desirability: 4 | Viability: 1
**All status**: open (no evidence collected yet)
