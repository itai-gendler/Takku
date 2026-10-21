---
kind: validation
routes:
  mac: Mac
steps:
- text: Type text that is not a JSON object, or one that sets model or messages, in Extra parameters
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Extra parameters
  contexts:
    mac:
      place: takku::summary-profiles
- text: Show what is wrong under the field, keep the last valid Extra parameters and disable Test connection
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Extra parameters
  contexts:
    mac:
      place: takku::summary-profiles
---

# Refuse Extra parameters that are not an object

## Trigger

The User makes a mistake in the JSON.

## Outcome

The Profile is unchanged until the field is valid again.
