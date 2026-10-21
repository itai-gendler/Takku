---
kind: primary
routes:
  mac: Mac
steps:
- text: Takku launches, or a day has passed since the last cleanup
  kind: condition
  unattended: true
  entities:
  - entity: settings
    effect: reads
    facts:
    - Keep audio for
  contexts:
    mac:
      place: takku::recordings
- text: Delete the audio, the transcription results, the Speaker turns and the Transcript copy of every completed or failed Meeting older than that
  kind: product
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
    facts:
    - Started
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::recordings
---

# Delete audio past its days

## Trigger

A concluded Meeting's audio reaches the end of its kept days.

## Outcome

The space is freed; the Meeting stays in Recent meetings and a Retry regenerates its Summary from the Vault.

## Edge cases

- Meetings recording, queued, processing or regenerating never lose their audio.
