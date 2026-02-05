# Spec Principles

- **One topic, one file** — Each distinct concern gets its own spec. Easier to load, update, and reason about in isolation.

- **Testable outcomes** — Push toward "how will we know this works?" If an outcome can't be verified, it's too vague to implement.

- **Intent over implementation** — Capture why something matters and what it should do. Leave how to implementation. Intent enables better judgment when details aren't specified.

- **Concrete over abstract** — Examples disambiguate faster than prose. "ISO 8601, e.g., 2024-01-15T14:30:00Z" beats "standard date format."

- **Explicit uncertainty** — "We don't know yet" is valid. Mark open questions rather than forcing premature decisions. Revisit when ready.

- **Minimal but sufficient** — Enough detail to be unambiguous. No more. Verbose specs waste context and obscure what matters.
