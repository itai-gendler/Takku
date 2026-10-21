---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose… a folder and confirm Use this Vault
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku::obsidian-vault
- text: Write Meeting notes and Transcripts into that folder from the next Meeting
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Vault folder
  - entity: meeting-note
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::obsidian-vault
---

# Choose the Vault folder

## Trigger

The User sets Takku up, or moves to another vault.

## Outcome

`Meetings/` and `Meetings/Transcripts/` fill up with the next Meeting; any folder works.
