---
kind: edge
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
- text: Send the short request
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
  contexts:
    mac:
      place: takku::summary-profiles
- text: The Provider answers with an error
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::summary-profiles
- text: Show the error and the Provider's message and, when it refused the request, what the Profile sets beyond a plain request
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Reasoning
    - Extra parameters
  contexts:
    mac:
      place: takku::summary-profiles
---

# Show what the Provider refused

## Trigger

The model refuses the Reasoning level or an Extra parameter, or the key is wrong.

## Outcome

The User sees the reason before any Meeting depends on the Profile.
