---
kind: primary
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
- text: Open the Vocabulary file in that app
  kind: product
  actor: user
  entities:
  - entity: vocabulary
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::vocabulary
- text: When Takku comes back to the front, show the number of terms and the first four, and how many more
  kind: product
  actor: user
  entities:
  - entity: vocabulary
    effect: reads
    facts:
    - Entries
  contexts:
    mac:
      place: takku::vocabulary
---

# Open the Vocabulary in an editor

## Trigger

Recognition keeps getting a name or a term wrong.

## Outcome

The terms count from the next Processing, or from a Retry.
