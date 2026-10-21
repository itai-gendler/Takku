---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Report a problem…
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
  contexts:
    mac:
      place: takku::menu
- text: Write the report file in the temporary folder and show it in the Finder
  kind: product
  actor: user
  entities:
  - entity: transcription-model
    effect: reads
    facts:
    - Name
    - In use
  - entity: summary-profile
    effect: reads
    facts:
    - Model
    - Base URL
  contexts:
    mac:
      place: takku::menu
- text: Open the GitHub bug form with the version, the Mac, how Takku was installed, the transcription model and the Summary model filled in
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Model
  - entity: transcription-model
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Prepare a bug report

## Trigger

Something in Takku does not work.

## Outcome

The User checks the file, then drags it into the issue; the Summary is named only by its model and whether it runs on this Mac or is remote.
