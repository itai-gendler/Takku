---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Retry on a failed Meeting in Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Failure reason
  contexts:
    mac:
      place: takku::menu
- text: The Meeting's audio is still kept
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Give the Meeting the Template and Summary Profile chosen in the menu now and queue it
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Failed
    to: Queued
    facts:
    - Template
    - Summary Profile
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
  - entity: summary-profile
    effect: reads
    facts: []
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Process it again, taking the Segments already transcribed from the Recording
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Queued
    to: Processing
    facts: []
  - entity: recording
    effect: changes
    facts:
    - Speaker turns
    - Transcript copy
  - entity: meeting-note
    effect: reads
    facts:
    - Personal notes
    - Speaker names
    - Participants
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
    - Model
    - Max context
    - Reasoning
    - Extra parameters
    - API key
  - entity: template
    effect: reads
    facts:
    - Instructions
    - Summary language
  contexts:
    mac:
      place: takku
- text: Overwrite the Meeting's Transcript and rewrite the note's Managed section and Takku's keys
  kind: product
  actor: user
  entities:
  - entity: transcript
    effect: changes
    facts:
    - Paragraphs
    - Stars
    - Language
  - entity: meeting-note
    effect: changes
    facts:
    - Managed section
    - Duration
    - Language
    - Template
    - Summary provider
    - Transcript link
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Summary ready
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Processing
    to: Completed
    facts: []
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.retry
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProcessingRecord.swift#ProcessingRecord.queueForRetry
---

# Retry a failed Meeting with another Profile

## Trigger

A Meeting failed, for example because the Provider was offline or its Profile was deleted, and the User chose another Profile in the menu.

## Outcome

The Meeting has its Summary; a Transcript already in the Vault is overwritten, never duplicated.

## Edge cases

- Vocabulary changes and Speaker names written in the note since apply, because the Transcript is built again.
- A Segment transcribed with another model, or in another language than the one now forced, is transcribed again.
