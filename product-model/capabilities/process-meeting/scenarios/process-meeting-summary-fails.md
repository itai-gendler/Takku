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
- text: The Provider answers with an error, returns no text, or its reply is cut by the length limit
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku
- text: Write the Transcript, and ⚠️ Summary not generated with the reason and the Transcript link in the Managed section
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
- text: Mark the Meeting failed with the reason and notify Processing failed
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
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ChatClient.swift#ChatClient.complete
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote.recordProcessing
---

# Keep the Transcript when the Summary fails

## Trigger

The Summary Provider cannot write the Summary.

## Outcome

The Transcript is usable from the note, the Meeting is failed with Retry offered, and no other Provider is tried.

## Edge cases

- When the Provider refuses a request (error 400 or 422) from a Profile that sets Reasoning or Extra parameters, the reason also says what the Profile sets, never its name or the parameters.
- The Provider's message is cut at 300 characters.
