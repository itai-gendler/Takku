---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose None in the menu's Calendar event
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
- text: Give the Meeting note back its provisional name
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
- text: A moment later, remove the note's Participants
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

# Name the note after no event

## Trigger

The Meeting is not one of the calendar's events.

## Outcome

The note is `<date> <time> - Meeting` again and gets a generated title at the end of Processing.
