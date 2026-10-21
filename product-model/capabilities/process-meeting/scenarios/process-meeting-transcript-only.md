---
kind: alternate
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
- text: The Meeting's Summary Profile is Transcript
  kind: condition
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Summary Profile
  - entity: summary-profile
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Write the Transcript, then only the Transcript link in the Managed section, removing any Template and provider keys
  kind: product
  entities:
  - entity: transcript
    effect: creates
    facts:
    - Name
    - Paragraphs
    - Stars
    - Language
    - Meeting link
  - entity: meeting-note
    effect: changes
    facts:
    - Managed section
    - Duration
    - Language
    - Template
    - Summary provider
    - Transcript link
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Transcript ready
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Processing
    to: Completed
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote.recordProcessing
---

# Write only the Transcript

## Trigger

A Meeting recorded with Transcript as Summary Profile reaches its turn.

## Outcome

The note links the Transcript, with no Summary, no warning and its provisional name.
