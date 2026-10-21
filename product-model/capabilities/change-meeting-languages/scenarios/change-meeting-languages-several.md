---
kind: primary
routes:
  mac: Mac
steps:
- text: Tick or untick languages in the list offered
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
- text: Keep the ticked languages, Italian and English first, and say each Meeting's language is detected among them
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

# Tick the languages Meetings are in

## Trigger

The User has Meetings in more than Italian or English.

## Outcome

New Meetings, and Retry, detect their language among those ticked; the first ticked is used when nothing can be detected.
