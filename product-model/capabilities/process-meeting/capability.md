---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.process
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.writeToVault
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.writeSummary
- kind: code
  role: implementation
  target: Takku/Transcription/MeetingTranscription.swift#MeetingTranscription.finish
- kind: spec
  role: intent
  target: docs/SPEC.md
- kind: adr
  role: intent
  target: docs/adr/0003-processing-after-the-call.md
---

# Process meeting

After the stop, Takku completes the Transcript on this Mac, writes the Summary with the Meeting's Summary Profile and Template, renames the note with a title, writes everything into the Vault and notifies the outcome, one Meeting at a time.
