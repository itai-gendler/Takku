---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Delete audio and confirm
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
- text: Delete the audio and what was recognised from it of every completed or failed Meeting, whatever its age
  kind: product
  actor: user
  entities:
  - entity: recording
    effect: changes
    from: Kept
    to: Audio deleted
    facts:
    - Segment results
    - Speaker turns
    - Transcript copy
    - Audio size
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::recordings
- text: Show the space used again
  kind: product
  actor: user
  entities:
  - entity: recording
    effect: reads
    facts:
    - Audio size
  contexts:
    mac:
      place: takku::recordings
---

# Delete the audio of all concluded Meetings

## Trigger

The User wants the audio gone before it expires.

## Outcome

Only Meetings not yet concluded keep their audio; Meeting notes and Transcripts in the Vault are not touched.

## Edge cases

- *Delete audio* is unavailable while there is no audio.
