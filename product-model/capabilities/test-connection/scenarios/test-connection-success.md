---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Test connection
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
    - Model
  contexts:
    mac:
      place: takku::summary-profiles
- text: Ask the model to reply OK with the Profile's settings and key
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
    - Model
    - Reasoning
    - Extra parameters
    - API key
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
- text: Show It works with the start of the reply
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
---

# Check that a Profile answers

## Trigger

The User has filled in a Profile.

## Outcome

The User knows the Profile can write Summaries.

## Edge cases

- It is unavailable until the base URL and the model are filled in and the Extra parameters are valid.
