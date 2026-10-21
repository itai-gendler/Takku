---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Show in Finder next to Summary log
  kind: actor
  actor: user
  entities:
  - entity: summary-log-entry
    effect: reads
    facts:
    - Size
  contexts:
    mac:
      place: takku::recordings
- text: Open the Summary log folder in the Finder
  kind: product
  actor: user
  entities:
  - entity: summary-log-entry
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::recordings
---

# Open the Summary log folder

## Trigger

The User wants to give some Summary log entries to a model to improve a Template.

## Outcome

The Finder shows one JSON file per Summary, named after its date, Template and model.
