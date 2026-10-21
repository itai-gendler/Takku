---
appliesTo:
- type: capability
  id: suggest-recording
- type: capability
  id: start-meeting
- type: capability
  id: stop-meeting
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/CallWatch.swift#CallWatch
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.init
---

# Call suggestions never start or stop a Meeting by themselves

Only the User's click does; a suggestion whose action no longer makes sense does nothing.
