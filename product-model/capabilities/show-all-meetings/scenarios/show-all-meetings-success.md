---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose the show-all item at the end of Recent meetings
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Editor
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Show the Vault's Meeting notes in the way the Editor allows
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Vault folder
    - Editor
  - entity: meeting-note
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
---

# Show every Meeting note

## Trigger

The User wants an older Meeting than the last five.

## Outcome

The User sees every Meeting note of the Vault.

## Decision points

### Which Editor is in use?

Where the Meeting notes are shown depends on the Editor.

- Obsidian → Obsidian's search opens on the Vault with the notes that have a `takku_id`, Transcripts excluded.
- another editor that opens folders → the whole Vault opens in it.
- an editor that does not open folders, or the Mac's default app → the Finder shows the Vault folder.

## Edge cases

- Offered only when a Vault is chosen.
