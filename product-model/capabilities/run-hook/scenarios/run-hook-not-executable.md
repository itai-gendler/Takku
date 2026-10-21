---
kind: edge
routes:
  mac: Mac
steps:
- text: A Meeting's Processing completes and ~/.takku/hooks/after-processing exists but cannot be run
  kind: condition
  unattended: true
  entities:
  - entity: hook
    effect: reads
    facts:
    - Executable
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: 'Write not executable: run chmod +x in the Hook''s log and notify Hook failed'
  kind: product
  entities:
  - entity: hook
    effect: changes
    facts:
    - Log
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  contexts:
    mac:
      place: takku
---

# Report a Hook that cannot be run

## Trigger

The User forgot to make the Hook executable.

## Outcome

The log says what to run; nothing else changes.
