---
kind: primary
routes:
  mac: Mac
steps:
- text: Type the name, base URL, model and Max context, and choose a Reasoning level
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Name
    - Base URL
    - Model
    - Max context
    - Reasoning
  contexts:
    mac:
      place: takku::summary-profiles
- text: Save each change as it is typed
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: changes
    facts:
    - Name
    - Base URL
    - Model
    - Max context
    - Reasoning
  contexts:
    mac:
      place: takku::summary-profiles
---

# Fill in a Profile

## Trigger

The User sets up a Provider's address and model.

## Outcome

The Profile is saved and its row shows its name and model.
