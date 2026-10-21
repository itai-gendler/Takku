---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose another app in Editor
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Editor
  contexts:
    mac:
      place: takku::obsidian-vault
- text: Open Meeting notes and Transcripts in that app from now on
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Editor
  - entity: meeting-note
    effect: reads
    facts: []
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::obsidian-vault
- text: Notify Turn on autosave in <app>, since Personal notes not yet saved do not reach the Summary
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::obsidian-vault
---

# Choose another Editor

## Trigger

The User prefers another Markdown editor to Obsidian.

## Outcome

Notes open in the chosen app and stay the same, `[[links]]` included; choosing Obsidian again makes it the default.

## Edge cases

- Obsidian is shown first when installed; the other apps are the Mac's Markdown editors.
- If the chosen app is uninstalled, a line says so and notes open in Obsidian, or in the Mac's default Markdown app without it.
