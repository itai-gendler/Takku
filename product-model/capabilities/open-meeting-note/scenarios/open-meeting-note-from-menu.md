---
kind: primary
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
- text: Find the note at its last known place or, renamed or moved, by its Takku ID in the Meetings folder, and open it in the Editor
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: meeting
    effect: reads
    facts:
    - Takku ID
  - entity: settings
    effect: reads
    facts:
    - Editor
  contexts:
    mac:
      place: takku::menu
---

# Open a recent Meeting's note

## Trigger

The User wants to read or add to a recent Meeting's note.

## Outcome

The note opens in Obsidian, or in the Editor chosen in Settings.
