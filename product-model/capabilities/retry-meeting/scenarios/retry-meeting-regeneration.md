---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Retry on a completed Meeting in Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: The Meeting's audio has been deleted
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
- text: Give the Meeting the Template and Summary Profile chosen in the menu now and start a Regeneration
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Completed
    to: Regenerating
    facts:
    - Template
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
- text: Read the Transcript back from the Vault, and the note's Personal notes, Speaker names and Participants
  kind: product
  actor: user
  entities:
  - entity: transcript
    effect: reads
    facts:
    - Paragraphs
    - Language
  - entity: meeting-note
    effect: reads
    facts:
    - Personal notes
    - Speaker names
    - Participants
  contexts:
    mac:
      place: takku
- text: Change only the Speaker labels in the Transcript to the names the note gives now, leaving its text as it is
  kind: product
  actor: user
  entities:
  - entity: transcript
    effect: changes
    facts:
    - Paragraphs
  contexts:
    mac:
      place: takku
- text: Ask the Summary Profile for a new Summary and, while the note has its provisional name, a title
  kind: product
  actor: user
  entities:
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
- text: Rename a note still provisional after the title, then rewrite only the Managed section and the Template and provider keys; duration, language and Transcript stay those of the first Processing
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: changes
    facts:
    - Name
    - Managed section
    - Template
    - Summary provider
  - entity: transcript
    effect: reads
    facts: []
  - entity: template
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
    from: Regenerating
    to: Completed
    facts: []
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.runRegeneration
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Transcript.swift#Transcript.relabeling
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote.recordRegeneration
---

# Regenerate the Summary after the audio is deleted

## Trigger

The User named Speakers in the note, or wants the Summary with another Template, after the audio was deleted.

## Outcome

The note has a new Summary built from the Transcript in the Vault, with the Speakers' names; the Transcript's text is unchanged.
