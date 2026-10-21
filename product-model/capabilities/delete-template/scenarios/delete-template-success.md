---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Delete on a Template and confirm Move to Trash
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::templates
- text: Move the Template file to the Trash and remove its row, with no message
  kind: product
  actor: user
  entities:
  - entity: template
    effect: removes
  contexts:
    mac:
      place: takku::templates
---

# Move a Template to the Trash

## Trigger

The User no longer needs a Template.

## Outcome

The Template is in the Mac's Trash, where it can be recovered.
