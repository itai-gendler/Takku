---
kind: edge
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
- text: A Track stopped writing audio before the stop
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts:
    - Tracks
  contexts:
    mac:
      place: takku::menu
- text: Close the Recording with what both Tracks hold
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
- text: Queue the Meeting and show Incomplete recording with the Track's error in the menu
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Recording
    to: Queued
    facts:
    - Ended
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/Capture/MeetingRecorder.swift#MeetingRecorder.stop
---

# Queue a Meeting whose Track was interrupted

## Trigger

The User stops a Meeting after one Track failed during it.

## Outcome

The Meeting is processed with the audio that was saved, and the menu tells which Track was interrupted.
