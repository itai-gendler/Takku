---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
references:
- kind: adr
  role: intent
  target: docs/adr/0001-eu-by-preference.md
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# A failed Summary is never sent to another Provider

When the Summary Profile fails, Processing stops there and the User decides whether to Retry, and with which Profile. Takku ships no default Provider either: the User picks one, or Transcript.

## Rationale

A fallback could send a Meeting to a Provider not chosen for it.
