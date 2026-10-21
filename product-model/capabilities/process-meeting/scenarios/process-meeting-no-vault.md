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
- text: No Vault is chosen in Settings
  kind: condition
  entities:
  - entity: settings
    effect: reads
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku
- text: Keep the Transcript only next to the audio, with no Summary
  kind: product
  entities:
  - entity: recording
    effect: reads
    facts:
    - Transcript copy
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Mark the Meeting completed and notify Transcript ready · Set up the Vault to get the Summary
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
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.process
- kind: code
  role: implementation
  target: Takku/Processing/Notifications.swift#Notifications.processingFinished
---

# Stop at the Transcript without a Vault

## Trigger

A Meeting recorded before a Vault was chosen reaches its turn.

## Outcome

The Transcript exists only in the Recording folder, until the audio is deleted.

## Edge cases

- The Hook does not run without a Vault.
