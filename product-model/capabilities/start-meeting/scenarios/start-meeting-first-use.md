---
kind: alternate
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
- text: The transcription model in use is not on this Mac yet
  kind: condition
  entities:
  - entity: transcription-model
    effect: reads
    facts:
    - In use
  contexts:
    mac:
      place: takku::menu
- text: Download the model while the Meeting records, showing Downloading transcription model… N% in the menu
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Not downloaded
    to: Downloading
    facts:
    - Download progress
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Prepare the model for this Mac, showing Preparing transcription model, first time only, then nothing
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Downloading
    to: Downloaded
    facts:
    - Download progress
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.start
- kind: code
  role: implementation
  target: Takku/Transcription/TranscriptionModels.swift#TranscriptionModels.ensureDownloaded
---

# Download the model during the first Meeting

## Trigger

The User starts the first Meeting before the model was downloaded.

## Outcome

The Meeting records normally; the model is ready by the time Processing needs it, and the first Summary waits for it otherwise.
