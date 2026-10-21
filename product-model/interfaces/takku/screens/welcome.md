---
entities:
- entity: settings
  shows:
  - Vault folder
  - Summary Profile
  - Open at login
  - Use the calendar
  collects:
  - Vault folder
  - Open at login
  - Use the calendar
- entity: transcription-model
  shows:
  - Name
  - Download size
  - Download progress
references:
- kind: code
  role: implementation
  target: Takku/WelcomeView.swift#WelcomeView
---

# Welcome to Takku

The steps to take before the first Meeting, so no prompt or download interrupts the first call: the Vault, the microphone and system audio permissions, the transcription model, a Summary Profile (optional), and Open at login and the calendar. It opens at launch while no Vault is chosen, and from *Set up Takku…* in the menu until then.
