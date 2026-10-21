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
- text: A Segment cannot be transcribed, for example the one open during a crash
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts:
    - Tracks
  contexts:
    mac:
      place: takku
- text: Transcribe the other Segments and leave a gap in the Transcript
  kind: product
  entities:
  - entity: recording
    effect: changes
    facts:
    - Segment results
    - Transcript copy
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Ask the Meeting's Summary Profile for the Summary, following the Meeting's Template, then for a title of at most 6 words
  kind: product
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Template
    - Summary Profile
  - entity: template
    effect: reads
    facts:
    - Instructions
    - Summary language
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
    - Model
    - Max context
    - Reasoning
    - Extra parameters
    - API key
  - entity: vocabulary
    effect: reads
    facts:
    - Entries
  contexts:
    mac:
      place: takku
- text: Write the Transcript and the Summary into the Vault
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
    - Name
    - Managed section
    - Duration
    - Language
    - Template
    - Summary provider
    - Transcript link
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Summary ready with Incomplete transcript
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
---

# Write the Summary despite a missing Segment

## Trigger

One Segment of the Recording is unreadable.

## Outcome

The Summary is written from what there is; the gap is a warning, not a failure.

## Edge cases

- If the Speakers cannot be told apart, the Transcript keeps *Others* and that is a warning too.
