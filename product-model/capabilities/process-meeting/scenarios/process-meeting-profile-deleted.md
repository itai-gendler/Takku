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
- text: The Meeting's Summary Profile was deleted after the Meeting started
  kind: condition
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Summary Profile
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Write the Transcript, and in the Managed section that the Profile was deleted and another must be chosen before Retry
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
    - Transcript link
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

# Stop at a deleted Summary Profile

## Trigger

The User deleted the Profile, and its key with it, before the Summary was written.

## Outcome

The note says the Profile "<name>" was deleted; choosing another Profile in the menu and Retry writes the Summary.
