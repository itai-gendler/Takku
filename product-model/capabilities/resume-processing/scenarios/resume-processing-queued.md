---
kind: primary
routes:
  mac: Mac
steps:
- text: Takku launches with a Meeting left processing
  kind: condition
  unattended: true
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Queue the Meeting again, oldest first, and process it
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Processing
    to: Queued
    facts: []
  contexts:
    mac:
      place: takku
---

# Resume Processing left halfway

## Trigger

Takku quit or crashed during Processing.

## Outcome

The Meeting is processed as if it had just been stopped; Segments already transcribed are not done again.
