---
entities:
- entity: settings
  shows:
  - Keep audio for
  - Keep a Summary log
  collects:
  - Keep audio for
  - Keep a Summary log
- entity: recording
  shows:
  - Audio size
- entity: summary-log-entry
  shows:
  - Size
references:
- kind: code
  role: implementation
  target: Takku/Settings/RecordingsSection.swift#RecordingsSection
---

# Recordings

What Takku keeps on this Mac outside the Vault: how long the audio is kept, how much there is, and the Summary log.
