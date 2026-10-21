---
appliesTo:
- type: capability
  id: delete-transcription-model
- type: entity
  id: transcription-model
  facts:
  - In use
references:
- kind: code
  role: implementation
  target: Takku/Settings/TranscriptionSection.swift#TranscriptionSection
---

# The transcription model in use cannot be deleted

The model in use has no *Delete*: the next Meeting would download it again.
