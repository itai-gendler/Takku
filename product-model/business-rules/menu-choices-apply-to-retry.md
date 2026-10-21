---
appliesTo:
- type: capability
  id: retry-meeting
- type: capability
  id: change-meeting-template
- type: capability
  id: change-summary-profile
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.retry
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Retry uses the Template and Summary Profile chosen in the menu at that moment

They replace the ones the Meeting had and become its own: to summarise again with another Template or Profile, the User chooses them in the menu, then Retry.
