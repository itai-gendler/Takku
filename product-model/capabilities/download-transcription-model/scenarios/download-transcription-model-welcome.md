---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Download and prepare in the welcome window
  kind: actor
  actor: user
  entities:
  - entity: transcription-model
    effect: reads
    facts:
    - Name
    - Download size
  contexts:
    mac:
      place: takku::welcome
- text: Download the model in use and prepare it for this Mac, showing the progress
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Not downloaded
    to: Downloading
    facts:
    - Download progress
  contexts:
    mac:
      place: takku::welcome
- text: Load it, ready for the first Meeting, and tick the step
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Downloading
    to: Downloaded
    facts:
    - Download progress
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
---

# Download and prepare the model before the first Meeting

## Trigger

The User sets Takku up before the first call.

## Outcome

The first Meeting does not wait for a download.
