---
kind: primary
routes:
  mac: Mac
steps:
- text: Takku launches, or a day has passed, and Check for updates is on
  kind: condition
  unattended: true
  entities:
  - entity: settings
    effect: reads
    facts:
    - Check for updates
  contexts:
    mac:
      place: takku::menu
- text: Ask GitHub for the latest release and, when it is newer than the running one, show Takku <version> is available… in the menu
  kind: product
  entities: []
  contexts:
    mac:
      place: takku::menu
---

# Offer a newer version

## Trigger

A new Takku is released.

## Outcome

The menu offers the new version.

## Edge cases

- Offline or rate-limited, nothing is shown and Takku asks again the next day.
