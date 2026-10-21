---
kind: primary
routes:
  mac: Mac
steps:
- text: A Track of the Meeting in progress has had no sound for 2 minutes
  kind: condition
  unattended: true
  entities:
  - entity: recording
    effect: reads
    facts:
    - Tracks
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Show ⚠️ No sound from the microphone, or from the system audio, for N min under the timer
  kind: product
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Started
  contexts:
    mac:
      place: takku::menu
---

# Show a silent Track in the menu

## Trigger

Nobody speaks in the call, or a Track receives digital silence.

## Outcome

The line disappears as soon as sound comes back; nothing is written in the note and the recording goes on.
