---
appliesTo:
- type: entity
  id: summary-log-entry
- type: capability
  id: delete-summary-log
references:
- kind: adr
  role: intent
  target: docs/adr/0010-summary-log.md
- kind: code
  role: implementation
  target: Takku/Processing/SummaryLogStorage.swift#SummaryLogStorage
---

# Takku never reads the Summary log back

The log is the User's working material for Templates. It never holds the Provider's address or the API key, and neither the audio's retention, *Delete audio* nor deleting a note touches it; only *Delete log* and the 5 MB limit remove entries.
