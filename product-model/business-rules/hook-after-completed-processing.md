---
appliesTo:
- type: capability
  id: run-hook
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
references:
- kind: adr
  role: intent
  target: docs/adr/0007-hook-after-processing.md
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.finish
---

# The Hook runs after every completed Processing, and only then

That includes a successful Retry, with or without the audio, and a Meeting with only its Transcript. It does not run when Processing fails, including when only the Summary failed, nor without a Vault. Runs wait for each other in a queue of their own, so a slow Hook never holds up the next Meeting.
