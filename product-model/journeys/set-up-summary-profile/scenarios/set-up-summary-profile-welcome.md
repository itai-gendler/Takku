---
kind: alternate
result: achieved
routes:
  mac: Mac
steps:
- text: Choose Add a Profile in Settings… in the welcome window
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Summary Profile
  contexts:
    mac:
      place: takku::welcome
  capability: add-summary-profile
- text: There is no Profile yet
  kind: condition
  entities: []
  contexts:
    mac:
      place: takku::summary-profiles
- text: Open Settings at the Summary Profiles with a new empty Profile in its editor
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: creates
    facts:
    - Name
    - Base URL
    - Model
    - Max context
  - entity: settings
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
  capability: add-summary-profile
- text: Type the name, base URL and model
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Name
    - Base URL
    - Model
  contexts:
    mac:
      place: takku::summary-profiles
  capability: edit-summary-profile
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
  contexts:
    mac:
      place: takku::summary-profiles
  capability: edit-summary-profile
---

# Add a Profile from the welcome window

## Trigger

The User chooses *Add a Profile in Settings…* in the welcome window's Summary step.

## Outcome

Settings shows the new Profile filled in; the welcome step is ticked once the Profile is in use.
