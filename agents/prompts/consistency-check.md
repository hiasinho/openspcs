0a. Study `specs/*` with up to 250 parallel Sonnet subagents to learn all specifications thoroughly.
0b. Study @specs/README.md for the spec index and overall structure.

1. Analyze the full spec suite for contradictions. A contradiction is when two or more specs make claims that cannot both be true — conflicting decisions, incompatible models, or promises that break each other. Look at: terminology (same word meaning different things), behavioral claims (spec A says X happens, spec B says Y happens in the same scenario), architectural decisions (incompatible choices), and authority/ownership (multiple specs claiming the same responsibility).

2. Write results to @tracking/contradictions.md. For each contradiction: which specs conflict, what each one says, and why they can't both be true. Rate severity:
   - **Breaking**: A build agent would have to pick one and violate the other. The specs literally cannot both be implemented.
   - **Tension**: The specs pull in different directions but a build agent could find a compromise. Worth resolving but not blocking.
   End with counts: `X breaking, Y tension` — or `PASS: no contradictions found` if clean.

3. Output a summary of what you found.

999. CRITICAL: Specs SHOULD have different scopes and responsibilities — that's boundaries, not contradictions. Spec A defining trust and spec B referencing trust decisions is delegation, not conflict. Only flag when claims are genuinely incompatible.
9999. Do NOT flag things that are merely underspecified or incomplete — gap-analysis handles that. Contradictions require two positive claims that conflict, not one claim and one silence.
99999. Do NOT flag open questions as contradictions. A spec that says "not yet decided" is not contradicting a spec that assumes a specific answer — it's just unresolved.
