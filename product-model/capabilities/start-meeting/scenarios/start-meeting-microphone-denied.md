---
kind: validation
routes:
  mac: Mac
steps:
- text: Choose Start meeting
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: macOS does not allow Takku to use the microphone
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::menu
- text: 'Record nothing and offer Microphone not authorized: open System Settings… in the menu'
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.start
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
---

# Refuse to start without the microphone

## Trigger

The User starts a Meeting without having allowed the microphone.

## Outcome

No Meeting is recorded; the menu leads to the Microphone page of System Settings.
