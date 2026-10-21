---
kind: edge
routes:
  mac: Mac
steps:
- text: Choose Start meeting
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Start recording a new Meeting
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: creates
    to: Recording
    facts:
    - Takku ID
    - Started
    - Template
    - Summary Profile
    - Transcription model
    - Meeting languages
  - entity: recording
    effect: creates
    to: Capturing
    facts:
    - Tracks
    with: meeting
  contexts:
    mac:
      place: takku::menu
- text: The Vault folder does not exist, for example on a volume that is not mounted
  kind: condition
  entities:
  - entity: settings
    effect: reads
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku::menu
- text: Keep recording and say in the menu that the note will be created at the end of Processing
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/Vault/Vault.swift#Vault.createMeetingNote
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Record when the Vault cannot be reached

## Trigger

The User starts a Meeting while the Vault folder is missing.

## Outcome

The Meeting records with no note yet; Processing creates the Meeting note when it ends.
