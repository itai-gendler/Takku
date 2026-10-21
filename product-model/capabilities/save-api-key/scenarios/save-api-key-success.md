---
kind: primary
routes:
  mac: Mac
steps:
- text: Paste the key and press Return or choose Save key
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
- text: Save the key in the Keychain under the Profile, replacing any earlier one only once it is saved
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
- text: Empty the field and show Saved in the Keychain with the key's last four characters
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - API key
  contexts:
    mac:
      place: takku::summary-profiles
---

# Save a key in the Keychain

## Trigger

The Provider needs a key.

## Outcome

Key saved in the Keychain; the User can tell which key is stored by its last characters.

## Edge cases

- If the Keychain refuses, the error is shown and the earlier key stays.
