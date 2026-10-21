---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose a Template in the menu's Template while no Meeting is recording
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  - entity: recording
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Use that Template for the next Meeting started and for any Retry chosen before then
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Choose the Template for the next Meeting or a Retry

## Trigger

The User prepares the next Meeting, or a Retry with another Template.

## Outcome

The next Meeting starts with it, or the Retry uses it.

## Edge cases

- A Template deleted in the meantime still shows in the menu while it is chosen; the Summary then follows Notes.
