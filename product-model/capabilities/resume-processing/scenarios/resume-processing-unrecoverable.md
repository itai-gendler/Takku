---
kind: edge
routes:
  mac: Mac
steps:
- text: Takku launches with a Meeting still recording whose Recording folder cannot be read
  kind: condition
  unattended: true
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: 'Mark the Meeting failed: Recording interrupted and not recoverable'
  kind: product
  entities:
  - entity: meeting
    effect: changes
    from: Recording
    to: Failed
    facts:
    - Failure reason
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
---

# Fail a Meeting that cannot be recovered

## Trigger

The crash left nothing Takku can rebuild.

## Outcome

The Meeting shows ⚠️ in Recent meetings with the reason.
