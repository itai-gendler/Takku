---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose the option without a Summary in the menu's Summary Profile
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Use no Summary Profile from now on and hide the Template menu
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Summary Profile
  - entity: template
    effect: reads
    facts: []
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Choose Transcript only

## Trigger

The User wants only the Transcript, for example to let a Hook write the Summary.

## Outcome

New Meetings get only their Transcript, with no Summary, Template or title.
