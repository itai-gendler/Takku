---
kind: primary
routes:
  mac: Mac
steps:
- text: Type a name in New Template and choose Create
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::templates
- text: Create the Template file with the built-in Notes text under that name, without opening it
  kind: product
  actor: user
  entities:
  - entity: template
    effect: creates
    facts:
    - Name
    - Summary language
    - Instructions
  contexts:
    mac:
      place: takku::templates
- text: Show the new Template in the list with its Edit With
  kind: product
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::templates
---

# Create a Template from Notes

## Trigger

The User wants a Summary shaped for another kind of Meeting.

## Outcome

The Template is in `~/.takku/templates/` and in the menus, ready to edit.

## Edge cases

- Characters a file name cannot hold are dropped; a name already taken gets ` (2)`.
