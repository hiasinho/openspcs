# OpenSpcs

**Conversational specification creation through AI-guided interviews.**

## What

An agent that interviews you about your project, asking targeted questions to build complete specifications before any code is written.

This is **Phase Zero** — the conversation that happens before implementation. We focus only on spec creation, not the full Ralph workflow.

## Why

Good specs are **critical** for autonomous coding (Ralph Wiggum loop technique). 

Garbage in → Garbage out. Vague specs → coding agents go wild.

**The problem:** You start with an abstract idea. Gaps in thinking. Unclear requirements.

**The solution:** Conversation reveals these gaps. Iterative Q&A creates precise, detailed specifications. These specs become the foundation for implementation plans and autonomous code generation.

## How

1. Start with a vague idea or abstract concept
2. Agent interviews you, diving deeper into different aspects
3. Conversation reveals gaps, clarifies requirements
4. Agent generates structured specifications in `specs/`
5. Specs → Implementation plan → Ralph technique for autonomous coding

Specs are **living documents**. They evolve as implementation reveals new insights, outcomes differ from expectations, or scope changes.

See [PRINCIPLES.md](PRINCIPLES.md) for the guiding principles behind spec creation.

## Documentation

- [PRINCIPLES.md](PRINCIPLES.md) — Guiding principles for spec creation
- [PROCESS.md](PROCESS.md) — How to apply the Ralph process
- [PLAYBOOK.md](PLAYBOOK.md) — The Ralph technique from Geoffrey Huntley

## Wish List

*Aspirational features - not necessarily v1, but worth capturing:*

- **AI-driven collaboration:** Interactive discussions and interviews with AI to create specifications. The agent asks questions, dives deeper, and helps uncover gaps in thinking.
- **Collaborative commenting:** Ability to include others in the discussion who can review and comment on specifications.

## References

### Ralph Wiggum Technique (Autonomous Coding)
- [Ralph: Away From Keyboard Software Development](https://ghuntley.com/ralph/)
- [Loop: Continuous AI Development](https://ghuntley.com/loop/)
- [Pressure: Managing Autonomous Development](https://ghuntley.com/pressure/)
- [Ralph Playbook (GitHub)](https://github.com/ClaytonFarr/ralph-playbook)

## Status

🚧 Initial setup - no agent yet
