---
kind: alternate
routes:
  mac: Mac
steps:
- text: Select the Profile marked In use and choose Delete
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Name
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
  contexts:
    mac:
      place: takku::summary-profiles
- text: Remove the Profile and its API key from the Keychain
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: removes
  contexts:
    mac:
      place: takku::summary-profiles
- text: Switch the Summary Profile to Transcript
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Summary Profile
  - entity: summary-profile
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
---

# Delete the Profile in use

## Trigger

The User deletes the Profile new Meetings use.

## Outcome

No other Profile takes its place: new Meetings get only their Transcript until the User chooses a Profile again.
