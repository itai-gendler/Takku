---
kind: edge
routes:
  mac: Mac
steps:
- text: A Track of the Meeting in progress has had no sound since the start, for 2 minutes
  kind: condition
  unattended: true
  entities:
  - entity: recording
    effect: reads
    facts:
    - Tracks
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Send one notification for that Track, pointing to the Microphone or the Screen & System Audio Recording page of System Settings
  kind: product
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
---

# Notify a Track silent since the start

## Trigger

A permission was revoked, a device delivers nothing, or the system audio capture is broken.

## Outcome

The User learns within 2 minutes that the Meeting would be lost; the notification comes once per Track per Meeting.
