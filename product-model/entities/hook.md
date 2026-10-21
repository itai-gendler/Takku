---
references:
- kind: code
  role: implementation
  target: Takku/Processing/HookRunner.swift#HookRunner
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Hook.swift#Hook
- kind: adr
  role: intent
  target: docs/adr/0007-hook-after-processing.md
---

# Hook

The executable the user puts at `~/.takku/hooks/after-processing`, in any language, which Takku runs after a Meeting's Processing completes, to take the Meeting elsewhere. Its presence is what turns it on.

## Information kept

- **Executable** — The file, if present, and whether it can be run.
- **Log** — `~/.takku/hooks/after-processing.log`: for each run the date, the note's name, the command to rerun it by hand, its output and how it ended; past 1 MB only the last half is kept.
