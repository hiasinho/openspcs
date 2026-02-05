# Prompt Pattern

Agent prompts follow a consistent structure with three zones. Claude weights statements at the end higher than at the beginning — the guardrail zone exploits this.

## Structure

### Orientation (0.)

What the agent should study before doing any work. Use sub-labels (0a, 0b, 0c) for multiple study targets. The word "study" is intentional — it means read and internalize, not skim.

```
0a. Study [primary input].
0b. Study [related context].
0c. For reference, [additional context].
```

### Instructions (1. 2. 3. ...)

The actual work, numbered sequentially. Each step is a distinct action. Keep the count low — if you need more than 4 or 5, the agent is doing too much in one prompt.

```
1. [Core task — what to do and how to evaluate].
2. [Next step].
3. [Output format].
```

### Guardrails (999. 9999. 99999. ...)

Signs for the agent — constraints, boundaries, and things to avoid. Placed at the end because Claude weights later statements higher. Each guardrail gets an escalating number (999, 9999, 99999, ...) to visually separate them from instructions and signal increasing weight.

```
999. Do NOT [common mistake].
9999. Do NOT [another boundary].
99999. [Most important constraint].
```

## Why This Works

- **Orientation first** grounds the agent in context before it acts
- **Numbered instructions** give clear sequence without ambiguity
- **Guardrails at the end** get the highest weight in the model's attention, preventing the most common failure modes
- **Escalating numbers** are a visual convention that signals "these are not steps — these are boundaries"
