---
kind: edge
routes:
  mac: Mac
steps:
- text: Choose Download on a model
  kind: actor
  actor: user
  entities:
  - entity: transcription-model
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::transcription
- text: Start downloading the model
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
      place: takku::transcription
- text: The download fails, for example without a network
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::transcription
- text: Say Download of <model> failed with the reason, and offer Download again
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Downloading
    to: Not downloaded
    facts:
    - Download progress
  contexts:
    mac:
      place: takku::transcription
---

# Report a failed download

## Trigger

The model cannot be downloaded.

## Outcome

The model is not downloaded; nothing else changes.
