---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Allow microphone and system audio
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
- text: Ask macOS for the microphone, then capture the system audio for a second so macOS asks for it, recording nothing
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts: []
  - entity: recording
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
- text: The User chooses Allow in both prompts
  kind: condition
  entities:
  - entity: user
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
- text: Bring the welcome window back to the front and tick the step
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::welcome
---

# Allow both permissions

## Trigger

The User sets Takku up before the first call.

## Outcome

The first Meeting is not interrupted by macOS prompts.

## Edge cases

- Whether the system audio was allowed cannot be read, so the window always says where to turn it on.
