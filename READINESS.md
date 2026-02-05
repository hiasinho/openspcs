# Readiness Report

Last updated: 2026-02-05

## Ready for Next Phase

The following aspects have enough clarity to proceed:

- **Core purpose**: Conversational spec creation tool, clear positioning
- **Entry points**: Well-defined spectrum from rough idea to existing codebase
- **Spec qualities**: Aligned with playbook (complete, clear, testable, scoped)
- **Interview style**: Adaptive approach based on clarity spectrum
- **Topic scoping**: "One sentence without 'and'" heuristic, LLM-driven
- **Completion model**: "Ready for next phase" rather than absolute done
- **Output format**: Specs + readiness report

## Active Exploration (WIP)

New topics being explored in current session:

- **Spec Loop Model** (`specs/spec-loop-model.md`)
  - Applying "on the loop, not in the loop" to spec creation
  - Hybrid model: autonomous mode (research, draft, evaluate) + interview mode (human input)
  - Agent toggles between modes based on whether it can make progress alone
  - Partially addresses "detailed interview flow" question (see Open Questions)

- **Spec Backpressure** (`specs/spec-backpressure.md`)
  - Quality gates for automated spec validation
  - Deterministic checks (structure, ambiguity, scope test)
  - Semi-deterministic (missing edge cases, implicit assumptions)
  - LLM-as-judge (clarity, completeness, consistency)
  - Human-only (domain accuracy, strategic fit)

- **Assumption Validation** (`specs/assumption-validation.md`)
  - Surfacing assumptions explicitly in specs
  - Strategyzer Test Card / Learning Card framework
  - Three lenses: Desirability, Feasibility, Viability
  - Prioritization: Importance × Evidence matrix
  - AI agents can test feasibility assumptions autonomously
  - Decision implications: deprioritize, labs, A/B, full rollout

- **Learning Loop** (`specs/learning-loop.md`)
  - Cyclical flow: spec → build → observe → learn → decide → update spec
  - Building as experiment (prototypes, spikes, MVPs test assumptions)
  - Artifacts as evidence (code, benchmarks, analytics, user behavior)
  - Decision authority: when agent decides vs. escalates to human
  - Spec update protocol: how learnings flow back into specs

- **Framework Adoption** (progress made)
  - Adopted: Strategyzer Test/Learning Cards, D/F/V lenses, Importance×Evidence matrix
  - Open: Degree of JTBD, story maps, SLC integration still unclear

## Needs More Work

The following remain open and need future sessions:

- **Form factor**: No decision yet on CLI vs. web vs. Claude Code skill
- **Spec file structure**: Template vs. flexible format not decided
- **Command/invocation naming**: /spec, /define, etc. - not chosen
- **Detailed interview flow**: Specific questions, phases, transitions not fully mapped (loop model provides high-level structure, but specific interview patterns need work)

## Potential Integration Points

- **Beads** (steveyegge/beads): Git-backed task tracker for AI agents. Could be downstream of OpenSpcs - specs become trackable tasks for implementation.

## Recommendation

The core concept is solid. New exploration around loop model, backpressure, and assumption validation could significantly differentiate OpenSpcs from simple "interview and write" approaches.

Next steps could include:
1. Deciding form factor (which constrains many other decisions)
2. Mapping out the interview flow in more detail
3. Prototyping backpressure checks to see what's practical
4. Defining how assumption validation integrates with spec structure

---

## Session History

| Date | Topics Explored |
|------|-----------------|
| 2026-01-31 | Initial spec session: core purpose, entry points, spec qualities, interview style, topic scoping, completion model, output format |
| 2026-02-05 | Loop model, backpressure, assumption validation (Strategyzer, D/F/V, Importance×Evidence), learning loop, decision authority |
