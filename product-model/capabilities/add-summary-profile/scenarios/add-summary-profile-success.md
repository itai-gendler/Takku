---
kind: primary
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
---

# Add an empty Profile

## Trigger

The User wants Summaries from a new Provider.

## Outcome

An *Untitled* Profile, *To be configured*, is selected with 32,000 tokens of Max context; the menu still uses the Profile it used before.
