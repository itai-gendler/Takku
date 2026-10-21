---
kind: alternate
routes:
  mac: Mac
steps:
- text: Turn on Open at login
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Open at login
  contexts:
    mac:
      place: takku::general
- text: Register Takku as a login item with macOS
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Open at login
  contexts:
    mac:
      place: takku::general
- text: macOS asks the User to approve the login item
  kind: condition
  entities:
  - entity: user
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::general
- text: Show Allow Takku in System Settings → Login Items with Open Login Items
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Open at login
  contexts:
    mac:
      place: takku::general
---

# Open Takku at login

## Trigger

The User wants Takku in the menu bar after every login.

## Outcome

Takku starts with the Mac once approved; it can also be turned off in System Settings → General → Login Items.
