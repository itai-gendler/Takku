---
appliesTo:
- type: capability
  id: change-recordings-settings
- type: capability
  id: delete-expired-audio
references:
- kind: code
  role: implementation
  target: Takku/Settings/RecordingsSection.swift#RecordingsSection
- kind: code
  role: implementation
  target: Takku/Settings/AppSettings.swift#AppSettings.retentionDays
---

# A new retention applies at the next cleanup

*Keep audio for* takes 1 to 90 days. Changing it deletes nothing on the spot: the cleanup at launch and once a day applies it.
