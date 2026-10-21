---
appliesTo:
- type: capability
  id: edit-summary-profile
- type: capability
  id: test-connection
- type: capability
  id: process-meeting
references:
- kind: adr
  role: intent
  target: docs/adr/0009-reasoning-in-two-dialects-and-extra-parameters.md
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ExtraParameters.swift#ExtraParameters
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ChatClient.swift#ChatClient
---

# Extra parameters are a JSON object that never sets model or messages

They are added to the body of every request of the Profile: Summary, blocks and merge, title and *Test connection*. Each top-level key replaces what Takku would send for it, Reasoning included, with no deep merge; HTTP headers are not covered. Reasoning itself goes as `reasoning.effort` to OpenRouter and as `reasoning_effort` to every other Provider.
