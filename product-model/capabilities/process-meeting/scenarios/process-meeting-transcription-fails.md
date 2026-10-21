---
kind: edge
routes:
  mac: Mac
steps:
- text: A stopped Meeting reaches the front of the Processing queue
  kind: condition
  unattended: true
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting as processing
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Queued
    to: Processing
    facts: []
  contexts:
    mac:
      place: takku
- text: The Transcript cannot be written
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts:
    - Tracks
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: 'Write ⚠️ Transcription failed: the Recording is saved, you can retry, in the Managed section'
  kind: product
  entities:
  - entity: meeting-note
    effect: changes
    facts:
    - Managed section
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting failed and notify Processing failed
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Processing
    to: Failed
    facts:
    - Failure reason
  contexts:
    mac:
      place: takku
---

# Keep the Recording when transcription fails

## Trigger

Transcription fails as a whole.

## Outcome

The audio stays for a Retry; the note says what happened.
