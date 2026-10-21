---
appliesTo:
- type: capability
  id: change-meeting-languages
- type: entity
  id: settings
  facts:
  - Meeting languages
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingLanguages.swift#MeetingLanguages
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# At least one Meeting language stays ticked

Only the 25 languages both engines handle are offered. Italian and English are ticked until the User changes them.
