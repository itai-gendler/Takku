---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose another Template in the menu's Template
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Give the Meeting in progress that Template
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    facts:
    - Template
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Change the Template of the Meeting in progress

## Trigger

While recording, the User realises the Meeting needs another Template.

## Outcome

The Summary follows the last Template chosen before the stop.
