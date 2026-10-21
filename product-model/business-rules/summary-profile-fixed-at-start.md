---
appliesTo:
- type: capability
  id: start-meeting
- type: capability
  id: change-summary-profile
- type: capability
  id: process-meeting
references:
- kind: adr
  role: intent
  target: docs/adr/0001-eu-by-preference.md
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProcessingRecord.swift#ProcessingRecord
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
---

# A Meeting's Summary Profile is the one in use when it starts

The Summary Profile menu is not offered while recording, and changing the Profile in use afterwards does not move a Meeting already started: it keeps that Profile, with the address, model and parameters it had then, until a Retry gives it the one chosen at that moment.

## Rationale

A Meeting must never go to a Provider chosen for another one.
