---
kind: primary
routes:
  mac: Mac
steps:
- text: Turn the call suggestions or the update check on or off
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Suggest recording
    - Check for updates
  contexts:
    mac:
      place: takku::general
- text: Keep the choice, read at the next call check or update check
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Suggest recording
    - Check for updates
  contexts:
    mac:
      place: takku::general
---

# Turn general settings on or off

## Trigger

The User wants call suggestions, or no update check.

## Outcome

The setting applies from the next check.
