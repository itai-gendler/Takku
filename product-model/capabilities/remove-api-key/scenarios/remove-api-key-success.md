---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Remove next to the saved key
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - API key
  contexts:
    mac:
      place: takku::summary-profiles
- text: Delete the key from the Keychain and say Key removed
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: changes
    facts:
    - API key
  contexts:
    mac:
      place: takku::summary-profiles
---

# Remove a saved key

## Trigger

The Provider no longer needs a key, or the key was revoked.

## Outcome

Requests of the Profile are sent without a key.
