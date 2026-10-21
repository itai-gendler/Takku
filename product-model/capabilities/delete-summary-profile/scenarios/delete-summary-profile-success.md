---
kind: primary
routes:
  mac: Mac
steps:
- text: Select a Profile and choose Delete
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::summary-profiles
- text: Remove the Profile and its API key from the Keychain, and select the first Profile left
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: removes
  contexts:
    mac:
      place: takku::summary-profiles
---

# Delete a Profile not in use

## Trigger

The User no longer uses a Provider.

## Outcome

The Profile is gone at once, with no confirmation; a Meeting started with it and not yet summarised fails its Summary, saying it was deleted.
