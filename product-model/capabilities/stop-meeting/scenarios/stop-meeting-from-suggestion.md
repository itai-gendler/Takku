---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Stop meeting on the "The call seems over" notification
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: The Meeting is still recording
  kind: condition
  entities:
  - entity: recording
    effect: reads
    facts: []
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Stop both Tracks and queue the Meeting for Processing
  kind: product
  actor: user
  entities:
  - entity: recording
    effect: changes
    from: Capturing
    to: Kept
    facts:
    - Tracks
  - entity: meeting
    effect: changes
    from: Recording
    to: Queued
    facts:
    - Ended
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/Notifications.swift#Notifications.userNotificationCenter
---

# Stop from the call-over suggestion

## Trigger

The User chooses *Stop meeting* on the suggestion.

## Outcome

The Meeting is queued as if stopped from the menu.

## Edge cases

- Clicking the notification itself does not stop the Meeting: only its button does.
- A button on an old suggestion does nothing once no Meeting is recording.
