---
entities:
- entity: summary-profile
  shows:
  - Name
  - Base URL
  - Model
  - Max context
  - Reasoning
  - Extra parameters
  - API key
  collects:
  - Name
  - Base URL
  - Model
  - Max context
  - Reasoning
  - Extra parameters
  - API key
- entity: settings
  shows:
  - Summary Profile
  collects:
  - Summary Profile
references:
- kind: code
  role: implementation
  target: Takku/Settings/SettingsView.swift#SettingsView
- kind: code
  role: implementation
  target: Takku/Settings/ProfileEditor.swift#ProfileEditor
---

# Summary Profiles

The Summary Profiles, which one is in use, and the editor of the selected Profile with its API key and *Test connection*.
