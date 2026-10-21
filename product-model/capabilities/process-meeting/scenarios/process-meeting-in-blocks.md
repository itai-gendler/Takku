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
- text: The Transcript, the Personal notes and the Template do not fit in the Profile's Max context, with room for the reply
  kind: condition
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Max context
  - entity: transcript
    effect: reads
    facts: []
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Summarise the Transcript block by block, never splitting a paragraph, then merge the partial summaries with the Template, in groups if even the merge does not fit
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
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Write the Transcript and the merged Summary into the Vault
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
  target: TakkuCore/Sources/TakkuCore/Summarizer.swift#Summarizer
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/SummaryPrompt.swift#SummaryPrompt
---

# Summarise a long Meeting in blocks

## Trigger

A long Meeting's request would not fit the model's context.

## Outcome

The Meeting gets one Summary as if written in a single request.
