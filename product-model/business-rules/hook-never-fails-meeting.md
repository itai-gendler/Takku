---
appliesTo:
- type: capability
  id: run-hook
- type: entity
  id: hook
references:
- kind: adr
  role: intent
  target: docs/adr/0007-hook-after-processing.md
- kind: code
  role: implementation
  target: Takku/Processing/HookRunner.swift#HookRunner
---

# A failing Hook leaves the Meeting completed

A Hook that fails, times out after 5 minutes or cannot be run gives one notification and a log entry. There is no automatic retry; the User reruns it by hand with the command in the log, because a Retry would also regenerate the Summary.
