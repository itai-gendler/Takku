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
- text: Transcribe the Segments not done yet on this Mac, tell the Speakers of the Others Track apart and replace the Vocabulary's variants
  kind: product
  entities:
  - entity: recording
    effect: changes
    facts:
    - Segment results
    - Speaker turns
    - Transcript copy
  - entity: vocabulary
    effect: reads
    facts:
    - Entries
  - entity: meeting
    effect: reads
    facts:
    - Transcription model
    - Meeting languages
    - Marks
  contexts:
    mac:
      place: takku
- text: Nothing was said in the Recording
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts:
    - Segment results
  contexts:
    mac:
      place: takku
- text: 'Write the empty Transcript, and ⚠️ Summary not generated: there is no speech in the Recording'
  kind: product
  entities:
  - entity: transcript
    effect: creates
    facts:
    - Name
    - Paragraphs
    - Meeting link
  - entity: meeting-note
    effect: changes
    facts:
    - Managed section
    - Duration
    - Transcript link
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

# Stop at a Meeting without speech

## Trigger

A Meeting with no speech in it reaches its turn.

## Outcome

No request is sent to the Provider and the Meeting is failed with that reason.
