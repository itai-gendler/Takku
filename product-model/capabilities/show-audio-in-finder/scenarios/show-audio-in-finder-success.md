---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Show in Finder next to Audio on this Mac
  kind: actor
  actor: user
  entities:
  - entity: recording
    effect: reads
    facts:
    - Audio size
  contexts:
    mac:
      place: takku::recordings
- text: Open the Recordings folder in the Finder
  kind: product
  actor: user
  entities:
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::recordings
---

# Open the Recordings folder

## Trigger

The User wants to see the audio Takku keeps.

## Outcome

The Finder shows one folder per Meeting.
