---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.start
- kind: code
  role: implementation
  target: Takku/Capture/MeetingRecorder.swift#MeetingRecorder.start
- kind: code
  role: implementation
  target: Takku/Vault/Vault.swift#Vault.createMeetingNote
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Start meeting

Start recording a Meeting from the menu, with ⌃⌥⌘R from any app, or from a call suggestion: both Tracks start first, then the Meeting note is created and opened in the Editor.
