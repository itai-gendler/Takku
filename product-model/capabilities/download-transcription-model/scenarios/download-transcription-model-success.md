---
kind: primary
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
    - Download size
  contexts:
    mac:
      place: takku::transcription
- text: Download the model, showing its percentage
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
- text: Show Preparing… while macOS prepares it, then Use and Delete
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
      place: takku::transcription
---

# Download a model from Settings

## Trigger

The User wants to try another model.

## Outcome

The model is on this Mac and can be put in use.

## Edge cases

- A download of the model in use also shows its percentage in the menu.
- A download interrupted halfway resumes instead of loading a partial model.
