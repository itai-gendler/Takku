---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Takku <version> is available…
  kind: actor
  actor: user
  entities: []
  contexts:
    mac:
      place: takku::menu
- text: Open the release page in the browser
  kind: product
  actor: user
  entities: []
  contexts:
    mac:
      place: takku::menu
---

# Open the new release

## Trigger

The menu offers a newer Takku.

## Outcome

The User can download it, or update with Homebrew; settings, Profiles, keys and models are kept.
