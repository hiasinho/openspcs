# The Ralph Process

How to apply the Ralph Wiggum Loop to your projects.

---

## Glossary

| Term | Meaning |
|------|---------|
| **Ralph** | The autonomous agent running in the loop. Named after Ralph Wiggum — he means well, needs guardrails, and learns through signs. |
| **The Loop** | The bash `while` loop that repeatedly feeds PROMPT.md to Claude. Fresh context each iteration. |
| **Back Pressure** | Mechanisms that reject invalid code generation: type checkers, tests, linters, pre-commit hooks. The resistance that keeps Ralph honest. |
| **Signs** | Guardrails added to prompts when Ralph fails a specific way. "SLIDE DOWN, DON'T JUMP." |
| **Specs** | Requirement specifications in `specs/`. One file per topic. Created through conversation, not upfront. |
| **fix_plan.md** | The prioritized task list. Ralph's TODO. Generated in planning mode, updated during building, thrown out when stale. |
| **AGENTS.md** | Industry standard for agent instructions ([agents.md](https://agents.md/)). Build commands, test commands, conventions. Auto-discovered by supporting tools. Ralph self-updates this as he learns. |
| **Planning Mode** | Loop mode where Ralph studies code + specs and generates/updates fix_plan.md. No implementation. |
| **Building Mode** | Loop mode where Ralph implements from the plan. One item at a time. |
| **Subagents** | Spawned processes for expensive work (file search, writing). Keeps primary context clean. |
| **Context Window** | The ~170k token limit. Burn it fresh each loop. Deterministically allocate specs + plan first. |
| **Eventual Consistency** | Faith that Ralph will converge on correct code through iteration. Problems are solved by different prompts. |
| **One Thing Per Loop** | Ralph picks one item from fix_plan.md per iteration. Resist the urge to batch. |
| **The Interview** | Phase Zero technique: Claude interviews you using AskUserQuestion to define requirements before writing specs. |
| **Topics of Concern** | Distinct aspects or components of the job you're building. Each becomes a spec file in `specs/`. |
| **Acceptance Criteria** | Observable outcomes that define "done" for a topic. Becomes tests later. |

---

## Philosophy

Before the how, the why.

### Monolithic, not multi-agent

Ralph is a single process, single repository, single task per loop. No orchestration of multiple agents. Multi-agent systems with non-deterministic agents are "a red hot mess."

### One thing per loop

Trust Ralph to pick the most important item from fix_plan.md. One thing. If it goes off the rails, narrow it back down. You can relax this as the project matures.

### Eventual consistency

Ralph will do stupid things. Don't blame the tools—tune them. Any problem created by AI can be resolved through a different series of prompts. Have faith that Ralph converges through iteration.

### Signs for Ralph

Ralph comes home bruised because he fell off the slide. So you add a sign: "SLIDE DOWN, DON'T JUMP." Next time, Ralph sees the sign. Eventually Ralph thinks about signs more than slides—that's when you get a new Ralph that doesn't feel defective at all.

Tune it like a guitar. Observe failures, add signs, repeat.

### But maintainability?

> When I hear that argument, I question "by whom"? By humans? Why are humans the frame for maintainability? Aren't we in the post-AI phase where you can just run loops to resolve/adapt when needed?
> — Geoffrey Huntley

---

## 1. Phase Zero: Specs Through Conversation

> "There is no such thing as a perfect prompt. Specs are formed through conversation."

### The Interview

Don't start with code. Start by having Claude interview you about what you're building.

Three approaches, from loose to structured:

---

**Option A: Unstructured**

Let Claude figure out what to ask.

```
Interview me using AskUserQuestion to define the requirements for [project/feature].
When we're done, write specs to specs/*.md.
```

Use when: You're exploring, don't know what you need yet, want to see where the conversation goes.

---

**Option B: JTBD-focused** *(from Clayton Farr's approach)*

Focus on the job and its components.

```
Interview me using AskUserQuestion to define requirements for [project/feature].
Cover: job to be done, topics of concern, acceptance criteria.
When we're done, write specs to specs/*.md with acceptance criteria included.
```

Use when: You have a clear job in mind, want to break it into topics with testable criteria.

---

**Option C: Full structured**

Walk through a complete framework.

```
Interview me using AskUserQuestion to define requirements for [project/feature].
Ask about these topics in order:
1. Audience - who is this for?
2. Job to Be Done - what are they trying to accomplish?
3. Topics of Concern - what are the distinct aspects/components?
4. Pains - what's frustrating about how they do it now?
5. Gains - what would make it better?
6. Acceptance Criteria - how will we know each part works?
7. Edge Cases - what could go wrong?
When we're done, write specs to specs/*.md with acceptance criteria included.
```

Use when: Starting a new project, want thorough requirements, have time to think it through.

---

Answer each question, or say "skip" / "I don't know yet" to move on.

---

### New vs Existing Projects

**New project:**
- Interview covers the whole project scope
- Define all topics of concern from scratch

**Existing project:**
- You don't need to document what already exists — the code is the source of truth
- Ralph searches the codebase to understand what's there
- Only write specs for what you want to **add or change**
- Interview focuses on the new feature or change, not the whole system

### Output

When the interview is complete, Claude writes:
- `specs/` folder with one file per Topic of Concern
- Each spec includes acceptance criteria (becomes tests later)

### Spec quality matters

- Ambiguous or contradictory specs = Ralph builds the wrong thing
- If Ralph keeps doing stupid shit, check your specs first
- You can always re-interview to clarify and update specs

---

## 2. Project Setup

### Tools

Ralph can be done with any tool that does not cap tool calls and usage.

### Repository structure
```
project-root/
├── PROMPT.md              # Active prompt (swap between plan/build)
├── AGENTS.md               # How to build/run the project
├── fix_plan.md            # Prioritized task list
├── specs/                 # Requirement specs
│   └── [topic].md
└── src/                   # Your source code
```

Copy starter files from `templates/` into your project root.

### AGENTS.md
- How to build the project
- How to run tests
- Any project-specific commands
- Ralph updates this as he learns

### fix_plan.md
- Prioritized bullet list of what needs doing
- Generated by Ralph in planning mode
- Updated continuously during building
- Throw it out and regenerate when it goes stale

### Sandbox

Good practice to run Ralph in a sandbox. Ralph runs with `--dangerously-skip-permissions` and can modify files, run arbitrary commands, and make mistakes.

The exact setup depends on your environment. Good choices:
- **Docker / Podman** — containerized isolation
- **VMs** — full isolation, heavyweight
- **Cloud dev environments** — Codespaces, Gitpod (disposable by design)

`git reset --hard` reverts uncommitted changes — it's your escape hatch, not your sandbox.

Use appropriate isolation for your risk tolerance.

---

## 3. Back Pressure

> "If you aren't capturing your back pressure then you are failing as a software engineer."

### What you need (find tools in your stack)

| Criterion | Purpose |
|-----------|---------|
| Static type checking | Catch errors at compile time |
| Tests (unit, integration) | Verify behavior |
| Linting / static analysis | Code quality, catch bugs |
| Pre-commit hooks | Reject bad code before commit |
| Build verification | Ensure it compiles/runs |

### The balance
- Too little back pressure → invalid code gets through
- Too much back pressure → wheel spins too slow
- Find "just enough" to reject bad generations

### Pre-commit hooks

Under normal circumstances pre-commit hooks are annoying because they slow down humans but now that humans aren't the ones doing the software development it really doesn't matter anymore.

### Dynamic languages
Wire in type checkers. Without them: "a bonfire of outcomes."

---

## 4. The Loop

### The basic loop
```bash
while :; do cat PROMPT.md | claude-code ; done
```

Or with CLI flags:
```bash
while :; do
  cat PROMPT.md | claude -p \
    --dangerously-skip-permissions \
    --model opus \
    --verbose
done
```

### Two modes

**Planning mode:** Generate/regenerate `fix_plan.md`
- Study specs and existing code
- Compare against specifications
- Create prioritized task list
- Do NOT implement anything

**Building mode:** Implement from the plan
- Pick the most important item
- Implement fully (no placeholders)
- Run tests
- Update fix_plan.md
- Commit and push

### Prompt structure

Prompts follow a pattern (see full templates in `templates/`):

```
0a. study specs/*
0b. source code location
0c. study fix_plan.md

1-4. Main instructions (task, validation, commit)

999.    Guardrails (higher number = more critical)
9999.   ...
99999.  ...
```

**Key guardrails to include:**
- Search before assuming not implemented
- No placeholders — full implementations only
- Run tests after changes
- Fix unrelated test failures
- Capture the why in documentation
- Keep fix_plan.md and AGENTS.md updated

### Fill in ULTIMATE GOAL

The planning prompt has a placeholder `[your project goal here]` that you must fill in. This tells Ralph what he's working toward.

**New project:**
```
ULTIMATE GOAL: Build a CLI tool for managing personal finances with import/export and reporting.
```
The full project scope. What is this thing?

**New feature on existing project:**
```
ULTIMATE GOAL: Add user authentication with email/password and OAuth support.
```
The feature you're adding. The existing codebase is already there — Ralph will search it.

**Adjustments / continued work:**
```
ULTIMATE GOAL: Complete the authentication feature per specs. Focus on OAuth integration.
```
What remains to be done. You can narrow the focus if Ralph was going off track.

The goal anchors Ralph's planning. Without it, he doesn't know what "done" looks like.

### Switching modes
1. Copy `templates/PROMPT.plan.md` or `templates/PROMPT.build.md` to `PROMPT.md`
2. Restart the loop

Or use the helper script:
```bash
./loop.sh plan    # Planning mode
./loop.sh build   # Building mode (default)
```

### Context window discipline
- Fresh context every loop (that's the point)
- Deterministic stack: always load specs + plan first
- Expensive work → spawn subagents
- Primary context = scheduler, not worker

### Subagent limits
- Up to 500 parallel subagents for search and file writing
- Only 1 subagent for build/tests (avoid bad backpressure)

If you fan out hundreds of subagents all running builds, you get chaos. Search in parallel, validate serially.

---

## 5. Operating

### Watch and tune
- Sit and observe, especially early on
- When Ralph fails a specific way, add a sign
- Prompts evolve through observed failure

**Example: Ralph doesn't stop after a commit**

*Observed:* Ralph commits successfully but then immediately starts the next task instead of letting the loop restart with fresh context.

*Sign added:* "After the commit, stop. Do not start the next task. Let the loop restart."

*Outcome:* Ralph now exits after committing, fresh context on next iteration.

**Example: Ralph makes sweeping changes**

*Observed:* Ralph "improves" code unrelated to the current task — refactoring, adding comments, reorganizing files.

*Sign added:* "Only change code directly related to the current task. Do not refactor, improve, or reorganize unrelated code."

*Outcome:* Ralph stays focused, changes are minimal and reviewable.

### The fix_plan.md lifecycle
- Ralph will run out of items or go off track
- Delete it and regenerate (planning mode)
- Watch it like a hawk

### Recovery
- `Ctrl+C` stops the loop
- `git reset --hard` reverts uncommitted changes
- Regenerate plan if trajectory goes wrong
- Judgment call: reset vs. rescue with new prompts

### Self-improvement
- Ralph updates AGENTS.md with learnings
- Ralph logs bugs to fix_plan.md even if unrelated
- Loop back: add logging, check intermediate output

---

## 6. Signs Reference

Common failure patterns and their guardrails.

| Failure Pattern | Sign to Add |
|-----------------|-------------|
| Assumes code doesn't exist (false negative from ripgrep) | "Before making changes search codebase (don't assume not implemented) using subagents. Think hard." |
| Placeholder/stub implementations | "DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS." |
| Doesn't run tests after changes | "After implementing functionality, run the tests for that unit of code." |
| Ignores unrelated test failures | "If tests unrelated to your work fail, resolve them as part of the increment." |
| Doesn't capture learnings | "Keep fix_plan.md current with learnings. Update AGENTS.md when you learn something new." |
| Doesn't document the why | "When authoring documentation, capture the why—tests and implementation importance." |

*Add your own signs as patterns emerge.*

---

## Quick Reference

### New project
1. Have the conversation → write specs
2. Set up structure: AGENTS.md, specs/, PROMPT.md
3. Set up back pressure for your stack
4. Fill in ULTIMATE GOAL in planning prompt (full project scope)
5. Run planning mode → generate fix_plan.md
6. Switch to building mode
7. Watch, tune, regenerate plan as needed

### Existing project
1. Write specs only for what you want to add or change
2. Add AGENTS.md with build/test instructions
3. Ensure back pressure is in place
4. Fill in ULTIMATE GOAL in planning prompt (the feature/change)
5. Run planning mode to generate fix_plan.md
6. Proceed as normal

---

*"Trust eventual consistency."*
