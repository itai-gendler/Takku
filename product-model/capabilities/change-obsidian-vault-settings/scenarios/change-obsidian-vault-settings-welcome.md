---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose… a folder in the welcome window and confirm Use this Vault
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku::welcome
- text: Keep the folder and tick the step
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku::welcome
---

# Choose the Vault in the welcome window

## Trigger

The User follows the welcome window's first step.

## Outcome

The welcome window no longer opens at launch, and *Set up Takku…* leaves the menu.
