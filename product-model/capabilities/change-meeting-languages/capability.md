---
availability:
- place: takku
domain: transcription
references:
- kind: code
  role: implementation
  target: Takku/Settings/TranscriptionSection.swift#TranscriptionSection
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingLanguages.swift#MeetingLanguages
---

# Change meeting languages

*Meeting languages* in *Settings → Transcription* ticks the languages Meetings can be in: the 25 languages both engines handle. With one ticked it is forced; with several, each Meeting's language is detected among them.
