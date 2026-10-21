---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Use for Summaries in the Profile's editor
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
- text: Use that Summary Profile for new Meetings and mark it In use
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Summary Profile
  - entity: meeting
    effect: reads
    facts: []
  - entity: summary-profile
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::summary-profiles
---

# Use a Profile from its editor

## Trigger

The User has set up a Profile and wants it to write Summaries.

## Outcome

The Profile shows *Used for Summaries* and the menu shows it as the Summary Profile.
