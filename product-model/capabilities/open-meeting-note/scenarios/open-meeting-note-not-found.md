---
kind: edge
routes:
  mac: Mac
steps:
- text: Choose Open note on a Meeting in Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: No note with the Meeting's Takku ID is in the Vault's Meetings folder
  kind: condition
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Takku ID
  contexts:
    mac:
      place: takku::menu
- text: Show Meeting note not found in the Vault in the menu
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Failure reason
  - entity: meeting-note
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Report a note that is not in the Vault

## Trigger

The note is no longer in the Vault's Meetings folder.

## Outcome

Nothing opens and the menu says why.
