---
kind: primary
routes:
  mac: Mac
steps:
- text: Suggest recording when a call starts is on, no Meeting is recording, and another app has used the microphone for 15 seconds without a break
  kind: condition
  unattended: true
  entities:
  - entity: settings
    effect: reads
    facts:
    - Suggest recording
  - entity: recording
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Send one notification, "Looks like a call in <app>" · "Start recording?", with a Start meeting button
  kind: product
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
---

# Suggest starting when a call starts

## Trigger

A call app keeps the microphone for 15 seconds while Takku is idle.

## Outcome

The User can start the Meeting from the notification; Takku starts nothing by itself.

## Edge cases

- One notification per stretch of use: a dictation app used for a few seconds triggers nothing.
- Takku itself is ignored, and a browser helper is named after its browser.
