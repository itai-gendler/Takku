---
kind: validation
routes:
  mac: Mac
steps:
- text: Turn on Use the calendar
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Use the calendar
  contexts:
    mac:
      place: takku::general
- text: macOS does not give Takku access to the calendars
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::general
- text: Leave the switch off and show Allow Takku in System Settings → Privacy & Security → Calendars with Open Calendars
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Use the calendar
  contexts:
    mac:
      place: takku::general
---

# Calendar access refused

## Trigger

The User refused, or earlier refused, calendar access.

## Outcome

Meetings keep the provisional name until access is allowed.

## Edge cases

- Without access the switch shows off, but a choice made earlier is kept for when access comes back.
