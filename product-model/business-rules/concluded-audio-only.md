---
appliesTo:
- type: capability
  id: delete-expired-audio
- type: capability
  id: delete-audio
- type: entity
  id: recording
  effect: changes
  to: Audio deleted
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Retention.swift#Retention
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Only a concluded Meeting loses its audio

The audio of a Meeting recording, queued, processing or regenerating is never deleted, by the daily cleanup or by *Delete audio*. Once deleted, the Meeting and its state stay, and Retry regenerates its Summary from the Vault.
