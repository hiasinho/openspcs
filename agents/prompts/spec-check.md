0a. Study the spec file provided as input. Read it fully.
0b. Study any specs it references (listed in Related or Connection sections) to understand cross-spec boundaries.
0c. Study `specs/` to know which specs exist. A spec exists if there's a file for it, even if it's a stub.

1. Evaluate the spec for completeness. Surface only issues that would cause a build agent to hallucinate during implementation — gaps it would fill with invention, and unstated beliefs it would silently diverge on. Check for coherence: trace through the spec's behavioral claims — what the system does, what contracts it honors, what decisions it makes. Flag if the spec promises behavior but never defines when or how it triggers, contradicts itself, leaves an architectural decision ambiguous where the choice matters, or references an external dependency without specifying its contract.

2. Check for critical assumptions: scan the entire spec for beliefs it depends on but doesn't state explicitly. Only flag assumptions that would change how the agent builds — if wrong the solution is broken (not just suboptimal), the core value depends on it, or other parts of the spec build on it. Flag if a critical assumption is implicit or lacks a way to validate it.

3. Check for spec needs: if the spec depends on a concept that has no spec at all — no file in `specs/` — create a stub spec for it. The stub should include: a title, status line noting it's a stub and which spec surfaced the need, a section explaining why this spec exists, a starting point with what it would need to define, open questions, and related spec references. After creating the stub, report it as a spec need in the output. If the concept already has a spec but it's a stub, report it as info, not an error.

4. Output results. Structure:
   - **Errors** (`[E001]`): issues within this spec where a build agent would have to invent something load-bearing — the choice matters and the wrong guess breaks things. Reserve errors for true hallucination risks. Format: `[E001] coherence: ...` or `[E001] assumption/critical: ...`
   - **Warnings** (`[W001]`): issues where a build agent would have to make a choice, but a competent agent would likely make a reasonable one. The spec could be clearer, but it's not a hallucination risk. Format: `[W001] coherence: ...`
   - **Info** (`[I001]`): dependencies on stub specs, or concepts delegated to other specs. Not issues — just visibility into cross-spec state. Format: `[I001] dependency: "concept" depends on [spec] which is a stub`
   - **Spec needs** (`[N001]`): concepts this spec depends on that have no spec at all. Format: `[N001] spec-needed: "[spec name]" — [what it would define]. Reason: [which error surfaced this]`
   - End with counts: `X error(s), Y warning(s), Z info(s), N spec need(s)`
   - If no errors, no warnings, no infos, and no spec needs: `[spec file path]: PASS`

999. Do NOT flag concepts that are explicitly delegated to another spec with a reference (e.g., "see trust.md"). A spec that says "this is defined elsewhere" and points to where is drawing a boundary, not leaving a gap.
9999. Do NOT flag standard engineering concerns a competent build agent would handle — database concurrency, crash recovery, error handling patterns, failure modes. Specs define WHAT the system does. The agent figures out HOW.
99999. Do NOT flag missing implementation details the agent can derive from context, or gaps the spec intentionally leaves open for the agent to resolve during implementation.
999999. Evaluate the spec on its own terms. A spec is not incomplete because it doesn't define things that belong to other specs. Judge boundaries, not gaps across boundaries.
