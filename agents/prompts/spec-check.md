# Spec Completeness Check

Evaluate a specification for completeness. Surface only issues that would cause an agent to hallucinate during implementation — gaps it would fill with invention, and unstated beliefs it would silently diverge on.

## Input

The spec file path will be provided as input. Read and evaluate that file.

## What NOT to Check

Specs define WHAT the system does — behavior, contracts, decisions. The agent figures out HOW to build it.

Do NOT flag:
- Missing implementation details the agent can derive from context (component code, function bodies, trait signatures inferrable from usage)
- Standard engineering decisions any competent agent would handle (URL encoding, error handling patterns, form layouts)
- Gaps the spec intentionally leaves open for the agent to resolve during implementation

## What to Check

### 1. Coherence
Trace through the spec's behavioral claims — what the system does, what contracts it honors, what decisions it makes.

Flag if:
- The spec promises behavior but never defines when or how it triggers (the agent would invent the trigger)
- The spec contradicts itself — the agent would silently pick one side
- An architectural or behavioral decision is left ambiguous — the agent would choose arbitrarily and the choice matters
- An external dependency is referenced without specifying its contract (the agent would guess the API)

### 2. Assumptions
Scan the entire spec for beliefs it depends on but doesn't state explicitly. These are where the agent's interpretation silently diverges from the author's intent.

**What makes an assumption critical:**
- If wrong, the solution doesn't work (not just suboptimal - broken)
- The solution's core value depends on it being true
- Other parts of the spec build on this assumption

Flag if:
- Critical assumption is implicit — the agent will make its own assumption instead
- Critical assumption lacks a way to validate it — no one will catch the divergence until it breaks

Only flag assumptions that would change how the agent builds. Skip assumptions that are obvious, low-risk, or wouldn't affect implementation.

## Output

If all checks pass:
```
[spec file path]: PASS
```

If issues found:
```
[spec file path]: FAIL

[E001] coherence: Gap between [section X] and [section Y] - [details]
[E002] coherence: Contradiction between [claim A] and [claim B] - [details]
[E003] coherence: "[concept]" referenced but never defined - [details]
[E004] assumption/critical: "[assumption text]" - implicit, agent will guess
[E005] assumption/critical: "[assumption text]" - no way to validate

X error(s)
```

Use error codes. Be specific. Each error should tell the author exactly what to fix so the agent doesn't have to guess.
