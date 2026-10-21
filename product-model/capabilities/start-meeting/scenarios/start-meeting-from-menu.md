---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Start meeting
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: macOS allows Takku to use the microphone
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::menu
- text: Start recording the system audio and the microphone into a new Meeting with the Template chosen in the menu and the Summary Profile, transcription model and Meeting languages in use
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
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
    - Meeting languages
  - entity: template
    effect: reads
    facts:
    - Name
  - entity: transcription-model
    effect: reads
    facts: []
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Create the Meeting note with the provisional name in the Vault's Meetings folder and open it in the Editor
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: creates
    facts:
    - Name
    - Date
    - Tags
    - Managed section
  - entity: settings
    effect: reads
    facts:
    - Vault folder
    - Editor
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Show a red dot in the menu bar and the elapsed time in the menu
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Started
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.start
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.createMeetingNote
---

# Start a Meeting from the menu

## Trigger

The User chooses *Start meeting* in the menu, or presses ⌃⌥⌘R in any app.

## Outcome

The Meeting is recording and its note, named `<date> <time> - Meeting`, is open in the Editor with "⏺ Recording in progress" in its Managed section, ready for Personal notes.

## Edge cases

- If another app already uses ⌃⌥⌘R, the menu says so and *Start meeting* still works.
- Without a Vault the Meeting is recorded and no Meeting note is created.
- Starting the recording itself can fail: the menu shows the error and nothing is recorded.
