---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Quit Takku while no Meeting is recording
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Quit; queued Processing resumes at the next launch
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Quit while idle

## Trigger

The User wants Takku out of the menu bar.

## Outcome

Takku is closed; nothing queued is lost.
