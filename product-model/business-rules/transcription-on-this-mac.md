---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: download-transcription-model
- type: entity
  id: recording
  facts:
  - Segment results
  - Speaker turns
references:
- kind: adr
  role: intent
  target: docs/adr/0001-eu-by-preference.md
- kind: adr
  role: intent
  target: docs/adr/0006-speakers-by-local-diarization.md
- kind: code
  role: implementation
  target: Takku/Transcription/MeetingTranscription.swift#MeetingTranscription
---

# Meeting audio is transcribed on this Mac and never sent

Recognition and Speaker diarization run locally; only the models are downloaded, from Hugging Face. What leaves the Mac is the Summary request to the Profile the User chose, and whatever the User's Hook sends.
