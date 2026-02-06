0a. Study @tracking/assumptions.md — this is the current tracker. Learn every assumption, its status, importance, and existing evidence.
0b. Study `specs/*` with up to 250 parallel Sonnet subagents to understand the current state of all specifications.

1. For each assumption in the tracker, search the specs for new evidence — statements, decisions, design choices, or resolved open questions that either support or contradict the assumption. Evidence is something concrete that changes confidence, not just the assumption being restated.

2. Update @tracking/assumptions.md. For assumptions where you found evidence: add the evidence with a brief description and strength assessment, update the status if warranted (open → testing if partial evidence, open/testing → validated if strong support, open/testing → refuted if contradicted). Do NOT change importance ratings — that's a human judgment. Preserve all existing data.

3. Output a summary: which assumptions gained evidence, what changed, and which remain open with no evidence.

999. CRITICAL: Restating the assumption is not evidence. "The spec says X" where X is the assumption itself is circular. Evidence must be EXTERNAL to the assumption — a design decision that depends on it working, a prototype result, a resolved question that narrows it, or a contradicting choice.
9999. Do NOT manufacture evidence. If nothing in the specs has changed since the assumption was written, say so. "No new evidence" is a valid and useful finding.
99999. Be conservative with status changes. Move to "validated" only with strong, concrete evidence. Most updates will be adding evidence notes, not changing status.
