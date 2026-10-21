---
kind: validation
routes:
  mac: Mac
steps:
- text: Untick the only language ticked
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Meeting languages
  contexts:
    mac:
      place: takku::transcription
- text: Leave it ticked
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Meeting languages
  contexts:
    mac:
      place: takku::transcription
---

# Keep the last language ticked

## Trigger

The User tries to untick every language.

## Outcome

At least one language stays ticked.
