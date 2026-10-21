---
kind: edge
routes:
  mac: Mac
steps:
- text: A Meeting's Processing completes and the Hook is run
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
- text: The Hook exits with an error, or is still running after 5 minutes and is terminated with what it started
  kind: condition
  entities:
  - entity: hook
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Append the run and how it ended to the Hook's log
  kind: product
  entities:
  - entity: hook
    effect: changes
    facts:
    - Log
  contexts:
    mac:
      place: takku
- text: 'Notify Hook failed · <note>: see ~/.takku/hooks/after-processing.log'
  kind: product
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: hook
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
---

# Report a failed or slow Hook

## Trigger

The User's script fails or hangs.

## Outcome

The Meeting stays completed; the log has the command to rerun the Hook by hand.
