---
kind: primary
result: achieved
routes:
  mac: Mac
steps:
- text: Choose Add Profile
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
  capability: add-summary-profile
- text: Add an empty Profile, not in use, and open its editor
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

# Add and fill in a Profile in Settings

## Trigger

The User chooses *Add Profile* in *Settings → Summary Profiles*.

## Outcome

The Profile is filled in and ready for *Test connection* and *Use for Summaries*.
