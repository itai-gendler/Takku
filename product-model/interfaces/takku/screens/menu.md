---
entities:
- entity: meeting
  shows:
  - Started
  - Template
  - Calendar event
  - Marks
  - Failure reason
  collects:
  - Template
  - Calendar event
- entity: meeting-note
  shows:
  - Name
- entity: recording
  shows:
  - Tracks
- entity: settings
  shows:
  - Summary Profile
  - Editor
  collects:
  - Summary Profile
- entity: template
  shows:
  - Name
- entity: summary-profile
  shows:
  - Name
- entity: transcription-model
  shows:
  - Download progress
references:
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#RecentMeetingsMenu
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#CalendarEventMenu
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MenuBarLabel
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Takku menu

The menu under Takku's menu bar icon, the place a Meeting is run from: start and stop, Marks, the Template, the Summary Profile, the calendar event, Recent meetings with Open note and Retry, and the model, Processing and error lines. The icon itself shows a red dot while recording, a star for a second after a Mark and an hourglass while Processing.
