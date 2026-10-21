---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Use on a downloaded model
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
- text: Move In use to that model
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: changes
    facts:
    - In use
  contexts:
    mac:
      place: takku::transcription
---

# Put a downloaded model in use

## Trigger

The User prefers another model.

## Outcome

New Meetings use it; a Meeting already recording keeps its own, and a Retry transcribes again the Segments another model did.
