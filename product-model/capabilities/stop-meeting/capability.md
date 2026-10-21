---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.stop
- kind: code
  role: implementation
  target: Takku/Capture/MeetingRecorder.swift#MeetingRecorder.stop
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.meetingStopped
---

# Stop meeting

Stop the Meeting in progress from the menu, with ⌃⌥⌘R, or from the call-over suggestion. The Meeting joins the Processing queue and another one can start right away.
