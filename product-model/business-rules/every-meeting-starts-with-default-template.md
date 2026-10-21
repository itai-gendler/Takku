---
appliesTo:
- type: capability
  id: start-meeting
- type: capability
  id: stop-meeting
- type: capability
  id: change-meeting-template
- type: capability
  id: change-default-template
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.stop
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.templateName
---

# Every Meeting starts with the Default Template

The menu's *Template* goes back to the Default Template at every stop. A Template chosen during a Meeting is that Meeting's only: a Retry right after uses the Default Template unless another is chosen again in the menu.
