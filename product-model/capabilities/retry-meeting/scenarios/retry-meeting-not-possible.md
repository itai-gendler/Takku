---
kind: edge
routes:
  mac: Mac
steps:
- text: Choose Retry on a concluded Meeting in Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: The audio is deleted and the Meeting note or its Transcript is not in the Vault
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  - entity: meeting-note
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Start a Regeneration
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Completed
    to: Regenerating
    facts:
    - Template
    - Summary Profile
  contexts:
    mac:
      place: takku::menu
- text: 'Mark the Meeting failed: Retry not possible'
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    from: Regenerating
    to: Failed
    facts:
    - Failure reason
  contexts:
    mac:
      place: takku
---

# Refuse a Regeneration without a note or Transcript

## Trigger

There is nothing left to build a Summary from.

## Outcome

The Meeting is failed and the notification says why.
