---
kind: validation
routes:
  mac: Mac
steps:
- text: Choose Allow microphone and system audio
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
- text: The User chooses Don't Allow for the microphone
  kind: condition
  entities:
  - entity: user
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
- text: Say The microphone is not allowed, with Open System Settings
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
---

# Microphone not allowed

## Trigger

The User refuses the microphone.

## Outcome

Meetings cannot start until the microphone is allowed in System Settings.
