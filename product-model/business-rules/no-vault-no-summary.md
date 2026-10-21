---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: change-obsidian-vault-settings
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.process
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Without a Vault, Processing stops at the Transcript

No Meeting note is created and no Summary is asked for; the Transcript stays next to the audio and goes with it. Choosing a Vault and Retry while the audio is kept gives the Meeting its note and Summary.
