0a. Study `specs/*` with up to 250 parallel Sonnet subagents to learn the application specifications.
0b. Study @tracking/assumptions.md (if present) — preserve any existing data (status, evidence, notes).

1. Extract assumptions from the specs. An assumption is a belief the spec depends on that could be wrong — if false, the design breaks. Surface both explicit and implicit ones. Categorize each by area: Desirability (do people want this?), Feasibility (can we build this?), Viability (should we build this?).

2. Write the results to @tracking/assumptions.md. Each assumption needs: a statement, source spec(s), area (Desirability / Feasibility / Viability), importance (1-10), status, and space for evidence. If the tracker already exists, merge — don't lose existing data. This file gets read at the start of every session — keep it scannable.

3. Output a summary of what you found.

999. CRITICAL: Only track assumptions where being wrong BREAKS the design, not ones where it merely needs adjustment. If an assumption is low-stakes, drop it — even if it was in a previous version of the tracker. Do NOT assume specifications are missing

9999. Importance is about how load-bearing the assumption is, not how likely it is to be wrong.

99999. IMPORTANT: If two assumptions are the same underlying bet, merge them. Assumptions must be distinct and non-overlapping.
