---
appliesTo:
- type: capability
  id: quit-takku
- type: capability
  id: stop-meeting
references:
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
---

# Takku is quit only while no Meeting is recording

*Quit Takku* leaves the menu while recording; the Meeting has to be stopped first.
