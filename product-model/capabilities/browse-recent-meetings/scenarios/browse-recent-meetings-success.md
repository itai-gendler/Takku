---
kind: primary
routes:
  mac: Mac
steps:
- text: Open the menu's Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Started
  contexts:
    mac:
      place: takku::menu
- text: List the five latest Meetings by the Meeting note's current name, marked ⏺ while recording, ⏳ while queued or processing and ⚠️ when failed
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Started
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# List the last five Meetings

## Trigger

The User looks for a recent Meeting.

## Outcome

Each Meeting offers *Open note*, and *Retry* once concluded.

## Edge cases

- A concluded Meeting whose note was deleted from the Vault is left out, and an older one takes its place; its Recording stays until the audio expires.
- A Meeting recorded without a Vault is listed by its start date and time.
