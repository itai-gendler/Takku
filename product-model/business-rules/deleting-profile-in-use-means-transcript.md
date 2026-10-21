---
appliesTo:
- type: capability
  id: delete-summary-profile
- type: capability
  id: change-summary-profile
references:
- kind: code
  role: implementation
  target: Takku/Settings/SettingsView.swift#SettingsView.deleteSelectedProfile
---

# Deleting the Summary Profile in use switches new Meetings to Transcript

No other Profile takes its place, and a new Profile is never put in use by itself: until the User chooses one, Meetings get only their Transcript.
