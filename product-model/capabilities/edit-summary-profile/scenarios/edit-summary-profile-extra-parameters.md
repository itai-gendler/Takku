---
kind: alternate
routes:
  mac: Mac
steps:
- text: Type a JSON object in Extra parameters
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Extra parameters
  contexts:
    mac:
      place: takku::summary-profiles
- text: Save the Extra parameters once they are a JSON object without model or messages
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: changes
    facts:
    - Extra parameters
  contexts:
    mac:
      place: takku::summary-profiles
---

# Add Extra parameters

## Trigger

A model needs a parameter the Reasoning menu does not send.

## Outcome

Every request of the Profile carries them, each key in place of what Takku would send for it.
