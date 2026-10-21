---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Start meeting on the "Looks like a call" notification
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: No Meeting is recording
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Start recording a new Meeting and open its note
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: creates
    to: Recording
    facts:
    - Takku ID
    - Started
    - Template
    - Summary Profile
    - Transcription model
    - Meeting languages
  - entity: recording
    effect: creates
    to: Capturing
    facts:
    - Tracks
    with: meeting
  - entity: meeting-note
    effect: creates
    facts:
    - Name
    - Date
    - Tags
    - Managed section
    with: meeting
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.init
- kind: code
  role: implementation
  target: Takku/Processing/Notifications.swift#Notifications.userNotificationCenter
---

# Start from a call suggestion

## Trigger

The User clicks the call suggestion or its *Start meeting* button.

## Outcome

The Meeting is recording as if started from the menu.

## Edge cases

- A button on an old suggestion does nothing while a Meeting is already recording.
