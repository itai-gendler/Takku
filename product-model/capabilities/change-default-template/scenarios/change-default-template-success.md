---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose a Template in Default Template
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::templates
- text: Start every Meeting from now on with that Template
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Default Template
  - entity: template
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::templates
---

# Choose the Default Template

## Trigger

Most of the User's Meetings need the same Template.

## Outcome

The next Meeting starts with it, and the menu's Template returns to it after every stop.
