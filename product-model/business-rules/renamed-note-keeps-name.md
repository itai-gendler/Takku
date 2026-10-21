---
appliesTo:
- type: entity
  id: meeting-note
  facts:
  - Name
- type: capability
  id: process-meeting
- type: capability
  id: change-calendar-event
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/VaultNaming.swift#VaultNaming.renamedNoteName
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# A Meeting note the User renamed or moved keeps its name

Takku renames a note only while it still has the name Takku gave it, the provisional one or the calendar event's, possibly with a ` (2)`, and only in the Meetings folder. Otherwise no title is asked and the note is found by its `takku_id`.
