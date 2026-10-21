---
kind: alternate
routes:
  mac: Mac
steps:
- text: Suggest recording when a call starts is on, a Meeting is recording, an app was using the microphone and none has for 30 seconds
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
- text: Send one notification, "The call seems over" · "Stop recording?", with a Stop meeting button
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

# Suggest stopping when the call seems over

## Trigger

The call app releases the microphone during a Meeting.

## Outcome

The User can stop from the notification; it comes again only after an app takes the microphone back and releases it.
