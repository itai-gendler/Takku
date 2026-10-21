---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose a Profile in the menu's Summary Profile
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::menu
- text: Use that Summary Profile for every Meeting started from now on and for Retry
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Summary Profile
  - entity: meeting
    effect: reads
    facts: []
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Choose a Profile in the menu

## Trigger

The User switches Provider, for example from a test Profile to an EU one.

## Outcome

New Meetings and Retry use the chosen Profile.
