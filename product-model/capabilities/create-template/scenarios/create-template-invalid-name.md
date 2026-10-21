---
kind: validation
routes:
  mac: Mac
steps:
- text: Type a name made only of characters a file name cannot hold and choose Create
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::templates
- text: Create nothing and say the name is not a valid file name
  kind: product
  actor: user
  entities:
  - entity: template
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::templates
---

# Refuse a name with nothing usable

## Trigger

The User types only characters such as `/` or `:`.

## Outcome

No Template is created.
