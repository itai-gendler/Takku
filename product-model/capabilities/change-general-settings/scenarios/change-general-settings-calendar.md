---
kind: alternate
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
- text: macOS gives Takku full access to the calendars
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::general
- text: Turn the setting on
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Use the calendar
  contexts:
    mac:
      place: takku::general
---

# Use the calendar

## Trigger

The User wants notes named after calendar events.

## Outcome

Meetings started during an event are named after it and list its invited people.
