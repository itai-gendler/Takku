---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Delete on the Default Template and confirm Move to Trash
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  - entity: settings
    effect: reads
    facts:
    - Default Template
  contexts:
    mac:
      place: takku::templates
- text: Move the Template file to the Trash
  kind: product
  actor: user
  entities:
  - entity: template
    effect: removes
  contexts:
    mac:
      place: takku::templates
- text: Make Notes the Default Template again
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Default Template
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::templates
---

# Delete the Default Template

## Trigger

The User deletes the Template every Meeting starts with.

## Outcome

Notes is the default again; Meetings that used the deleted Template switch to Notes.
