---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/HookRunner.swift#HookRunner.run
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.finish
- kind: adr
  role: intent
  target: docs/adr/0007-hook-after-processing.md
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Run hook

When a Meeting's Processing completes, Takku runs the User's Hook with the absolute paths of the Meeting note and of the Transcript, so a script can take the Meeting to another service, a git repository or anywhere else.
