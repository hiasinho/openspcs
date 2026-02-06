0a. Study `specs/*` with up to 250 parallel Sonnet subagents to learn all specifications.
0b. Study @specs/README.md for the spec index and overall structure.
0c. Study @tracking/assumptions.md (if present) to understand what's already been surfaced.

1. Analyze the full spec suite for gaps. A gap is something that would block or confuse a build agent, create ambiguity across specs, or leave a critical concept undefined. Look across specs, not within — spec-check handles individual spec quality.

2. Write results to @tracking/findings.md. For each gap: what's missing, which specs are affected, and how severe it is (would it block building, or just create friction?).

3. Output a summary of what you found.

999. CRITICAL: Focus on gaps that would actually cause problems during implementation. Do NOT flag things that are explicitly deferred, delegated to other specs, or marked as open questions. Those are known — gaps are unknown.
9999. Think about what a build agent would need that isn't there. Missing contracts between specs, undefined handoffs, concepts used but never specified.
