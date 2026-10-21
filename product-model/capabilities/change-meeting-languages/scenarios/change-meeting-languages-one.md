---
kind: alternate
routes:
  mac: Mac
steps:
- text: Leave one language ticked in the list offered
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Meeting languages
  contexts:
    mac:
      place: takku::transcription
- text: Keep that language and say every Meeting is transcribed in it
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Meeting languages
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::transcription
---

# Force one language

## Trigger

All the User's Meetings are in one language.

## Outcome

There is no detection: every Meeting is transcribed in that language.
