---
kind: edge
routes:
  mac: Mac
steps:
- text: Takku launches with a Meeting still recording, so it crashed
  kind: condition
  unattended: true
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Rebuild the Recording from each Track's Segment list, ending at the last audio write
  kind: product
  entities:
  - entity: recording
    effect: changes
    from: Capturing
    to: Kept
    facts:
    - Tracks
  contexts:
    mac:
      place: takku
- text: Queue the Meeting for Processing
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Recording
    to: Queued
    facts:
    - Ended
  contexts:
    mac:
      place: takku
---

# Recover a Meeting interrupted while recording

## Trigger

Takku crashed, or the Mac shut down, during a Meeting.

## Outcome

Only the Segment open at the crash is lost; the rest of the Meeting is processed.
