---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Delete on a downloaded model that is not in use
  kind: actor
  actor: user
  entities:
  - entity: transcription-model
    effect: reads
    facts:
    - Name
    - In use
  contexts:
    mac:
      place: takku::transcription
- text: Remove the model from this Mac and offer Download again
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    from: Downloaded
    to: Not downloaded
    facts:
    - Download progress
  contexts:
    mac:
      place: takku::transcription
---

# Delete a model not in use

## Trigger

The User wants the disk space back.

## Outcome

The model is no longer on this Mac; the others stay.
