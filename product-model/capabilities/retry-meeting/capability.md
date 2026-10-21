---
availability:
- place: takku
domain: recent-meetings
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.retry
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.runRegeneration
- kind: spec
  role: intent
  target: docs/SPEC.md
- kind: doc
  role: context
  target: CONTEXT.md
---

# Retry meeting

*Retry* on a concluded Meeting in *Recent meetings* processes it again with the Template and Summary Profile chosen in the menu now, which become the Meeting's: the whole Processing while its audio is kept, otherwise a Regeneration of the Summary from the Transcript in the Vault.
