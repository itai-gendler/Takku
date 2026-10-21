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
  target: Takku/Transcription/TranscriptionModels.swift#TranscriptionModels.download
- kind: code
  role: implementation
  target: Takku/WelcomeView.swift#WelcomeView
---

# Download transcription model

*Download* in *Settings → Transcription*, or *Download and prepare* in the welcome window, downloads a model once from Hugging Face; only the model is downloaded, no audio or text is sent.
