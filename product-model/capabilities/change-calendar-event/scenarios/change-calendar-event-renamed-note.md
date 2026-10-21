---
kind: alternate
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
- text: The User renamed or moved the Meeting note since Takku named it
  kind: condition
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: user
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Leave the note's name as it is
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    facts:
    - Calendar event
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

# Keep a name the User gave the note

## Trigger

The User picks another event after renaming the note by hand.

## Outcome

The note keeps the User's name and lists the new event's Participants.
