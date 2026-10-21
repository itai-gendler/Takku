---
kind: alternate
routes:
  mac: Mac
steps:
- text: Click the Summary ready, Transcript ready or Processing failed notification
  kind: actor
  actor: user
  entities:
  - entity: meeting-note
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Open the Meeting note in the Editor
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: settings
    effect: reads
    facts:
    - Editor
  contexts:
    mac:
      place: takku
---

# Open the note from a notification

## Trigger

Processing of a Meeting has just ended.

## Outcome

The note opens under its new name, even when the Editor lost track of the rename.
