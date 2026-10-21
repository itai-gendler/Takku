---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Stop meeting
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Stop both Tracks and close the Recording
  kind: product
  actor: user
  entities:
  - entity: recording
    effect: changes
    from: Capturing
    to: Kept
    facts:
    - Tracks
  contexts:
    mac:
      place: takku::menu
- text: Queue the Meeting for Processing
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Recording
    to: Queued
    facts:
    - Ended
  contexts:
    mac:
      place: takku::menu
- text: Show an hourglass in the menu bar and Processing… with how many more are queued
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Put the Template menu back on the Default Template
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Default Template
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.stop
---

# Stop and queue the Meeting

## Trigger

The User chooses *Stop meeting*, or presses ⌃⌥⌘R again.

## Outcome

The Meeting waits for Processing, and the menu is ready for the next Meeting with the Default Template.
