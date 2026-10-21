---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose an app in the Template's Edit With
  kind: actor
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::templates
- text: Open the Template file in that app
  kind: product
  actor: user
  entities:
  - entity: template
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku::templates
---

# Open a Template in an editor

## Trigger

The User wants to change a Template's instructions and sections.

## Outcome

The file is open in the chosen editor; the next Summary with it follows the saved text.

## Edge cases

- The apps offered are those that edit Markdown or plain text, the Mac's default for Markdown first.
- Templates added or renamed in the Finder show up when Takku comes back to the front.
