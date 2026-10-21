---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose another event in the menu's Calendar event
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Calendar event
  contexts:
    mac:
      place: takku::menu
- text: Rename the Meeting note after the new event
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    facts:
    - Calendar event
  - entity: meeting-note
    effect: changes
    facts:
    - Name
  contexts:
    mac:
      place: takku::menu
- text: A moment later, replace the note's Participants with the new event's invited people
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: changes
    facts:
    - Participants
  contexts:
    mac:
      place: takku::menu
---

# Name the note after another event

## Trigger

The User joined a call early and Takku named the note after the previous one.

## Outcome

The note carries the right event's name and Participants; Obsidian is shown the renamed note if it was showing it.

## Edge cases

- Offered only while recording and only when the note was created at the start.
