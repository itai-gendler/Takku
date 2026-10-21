---
kind: primary
routes:
  mac: Mac
steps:
- text: A Meeting's Processing completes with a Vault, a note and a Transcript, and ~/.takku/hooks/after-processing exists
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
  - entity: transcript
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku
- text: Queue the Hook behind any run still going, so two runs never overlap
  kind: product
  entities:
  - entity: hook
    effect: reads
    facts:
    - Executable
  contexts:
    mac:
      place: takku
- text: Run it in the Vault folder with the paths of the Meeting note and the Transcript, no input, and Homebrew's folders on its PATH
  kind: product
  entities:
  - entity: meeting-note
    effect: reads
    facts:
    - Name
  - entity: transcript
    effect: reads
    facts:
    - Name
  - entity: settings
    effect: reads
    facts:
    - Vault folder
  contexts:
    mac:
      place: takku
- text: Append the run, with the command to rerun it by hand, to the Hook's log
  kind: product
  entities:
  - entity: hook
    effect: changes
    facts:
    - Log
  contexts:
    mac:
      place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/HookRunner.swift#HookRunner.execute
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Hook.swift#Hook.path
---

# Run the Hook after a completed Meeting

## Trigger

A Meeting completes Processing, Retry included.

## Outcome

The Hook exits with 0 and nothing is shown; the Meeting is wherever the script sent it.
