---
kind: alternate
routes:
  mac: Mac
steps:
- text: Takku launches with a Meeting left regenerating
  kind: condition
  unattended: true
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Put the Meeting back to completed, with its previous Summary
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Regenerating
    to: Completed
    facts: []
  contexts:
    mac:
      place: takku
---

# Drop a Regeneration interrupted by a restart

## Trigger

Takku quit during a Retry without audio.

## Outcome

The Regeneration is not repeated; the User can Retry again.
