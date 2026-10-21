---
entities:
- entity: settings
  shows:
  - Meeting languages
  collects:
  - Meeting languages
- entity: transcription-model
  shows:
  - Name
  - Download size
  - Download progress
  - In use
references:
- kind: code
  role: implementation
  target: Takku/Settings/TranscriptionSection.swift#TranscriptionSection
---

# Transcription

The Meeting languages and the transcription models: which are downloaded, which one is in use.
