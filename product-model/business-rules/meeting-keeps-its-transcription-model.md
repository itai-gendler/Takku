---
appliesTo:
- type: capability
  id: start-meeting
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
- type: capability
  id: use-transcription-model
references:
- kind: code
  role: implementation
  target: Takku/Transcription/MeetingTranscription.swift#MeetingTranscription
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# A Meeting is transcribed with the model and languages in use when it started

Its Segments are transcribed during the call with them. A Retry uses the model and Meeting languages in use at that moment, transcribing again any Segment done with another model or another forced language.
