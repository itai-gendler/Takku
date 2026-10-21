---
kind: primary
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
- text: Read the Meeting note again for its Personal notes, Speaker names and Participants
  kind: product
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Personal notes
    - Speaker names
    - Participants
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
- text: Rename the Meeting note, still with its provisional name, after the title
  kind: product
  entities:
  - entity: meeting-note
    effect: changes
    facts:
    - Name
  contexts:
    mac:
      place: takku
- text: Write the Transcript in Meetings/Transcripts, named after the note
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
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Write the Summary and the Transcript link in the Managed section, and Takku's keys in the frontmatter
  kind: product
  entities:
  - entity: meeting-note
    effect: changes
    facts:
    - Managed section
    - Duration
    - Language
    - Template
    - Summary provider
    - Transcript link
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Summary ready, opening the note on a click
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
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.process
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.renameIfProvisional
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote.recordProcessing
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingTitle.swift#MeetingTitle
---

# Write the Summary and the Transcript

## Trigger

A stopped Meeting with a Summary Profile reaches its turn.

## Outcome

The note has the Summary at the top, the link to the Transcript and a short title; the Personal notes are untouched.

## Edge cases

- A note named after a calendar event, or renamed or moved by the User, keeps its name and no title is asked.
- If no title comes back, the note keeps its provisional name; it is not an error.
- Times the model cites for each point, and stars it copies, are removed from the Summary.
