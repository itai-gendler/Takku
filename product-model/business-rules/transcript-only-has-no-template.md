---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: change-meeting-template
- type: capability
  id: change-summary-profile
references:
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.summarize
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# With Transcript as Summary Profile, a Meeting gets no Summary, Template or title

The Template menu is hidden, the note keeps its provisional name and its Managed section holds only the Transcript link, with no warning. Only the Vocabulary's variants apply.
