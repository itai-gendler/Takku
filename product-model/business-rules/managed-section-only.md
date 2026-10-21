---
appliesTo:
- type: entity
  id: meeting-note
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
- type: capability
  id: change-calendar-event
references:
- kind: spec
  role: intent
  target: docs/SPEC.md
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote
- kind: code
  role: implementation
  target: Takku/Vault/Vault.swift#Vault.update
---

# Takku rewrites only the Managed section and its own keys of a Meeting note

Personal notes and keys the User adds are never touched. `date`, `tags` and `participants` are written when the note is created and belong to the User afterwards, except that picking another calendar event while recording replaces `participants`. `takku_id` is restored if the User deleted it, and missing markers are recreated at the top of the body. The note is updated in place, and read again if the Editor saved it in the meantime.

## Rationale

Everything outside the Managed section is the User's; the Personal notes are their input to the Summary.
