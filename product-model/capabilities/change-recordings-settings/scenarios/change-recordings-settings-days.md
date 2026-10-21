---
kind: primary
routes:
  mac: Mac
steps:
- text: Change Keep audio for to a number of days from 1 to 90
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Keep audio for
  contexts:
    mac:
      place: takku::recordings
- text: Keep the new number of days
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Keep audio for
  contexts:
    mac:
      place: takku::recordings
---

# Change how long audio is kept

## Trigger

The User wants Recordings kept for a shorter or longer time.

## Outcome

The next cleanup, at launch or the next day, applies it; nothing is deleted on the spot.
