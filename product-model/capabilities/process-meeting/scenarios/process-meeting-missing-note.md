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
- text: 'The Meeting note is not in the Vault: it could not be created at the start, or the User deleted it'
  kind: condition
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: user
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Create the Meeting note with the provisional name
  kind: product
  entities:
  - entity: meeting-note
    effect: creates
    facts:
    - Name
    - Date
    - Tags
    - Managed section
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
- text: Rename the note after the title and write the Transcript, the Summary and Takku's keys
  kind: product
  entities:
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
  - entity: transcript
    effect: creates
    facts:
    - Name
    - Paragraphs
    - Stars
    - Language
    - Meeting link
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Summary ready
  kind: product
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
  target: Takku/Vault/Vault.swift#Vault.findMeetingNote
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.writeToVault
---

# Create the note at the end

## Trigger

The Vault was not reachable at the start, or the note was deleted during the Meeting.

## Outcome

The Meeting still ends with its note in the Vault.

## Edge cases

- A note renamed or moved by the User is found by its `takku_id` anywhere in the Meetings folder, Transcripts excluded.
