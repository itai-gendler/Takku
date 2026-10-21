---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose an app in Edit Vocabulary With
  kind: actor
  actor: user
  entities:
  - entity: vocabulary
    effect: reads
    facts:
    - Entries
  contexts:
    mac:
      place: takku::vocabulary
- text: The Vocabulary file does not exist yet
  kind: condition
  entities:
  - entity: vocabulary
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::vocabulary
- text: Create the Vocabulary file with an explanation and an example that count as no entry, and open it
  kind: product
  actor: user
  entities:
  - entity: vocabulary
    effect: changes
    facts:
    - Entries
  contexts:
    mac:
      place: takku::vocabulary
---

# Create the Vocabulary file

## Trigger

The User opens the Vocabulary for the first time.

## Outcome

The file explains its format; the section still says *No terms yet* until the User adds an entry.
