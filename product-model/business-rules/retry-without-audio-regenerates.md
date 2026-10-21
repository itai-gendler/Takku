---
appliesTo:
- type: capability
  id: retry-meeting
- type: capability
  id: delete-expired-audio
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.runRegeneration
- kind: doc
  role: context
  target: CONTEXT.md
---

# Without its audio, Retry rewrites only the Summary

A Regeneration reads the Transcript and the Personal notes back from the Vault and writes a new Summary; the Transcript's text, the duration and the language stay as the first Processing left them, and only the Speakers' labels follow the names the note gives now.
