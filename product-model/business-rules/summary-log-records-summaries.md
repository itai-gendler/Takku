---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
- type: entity
  id: summary-log-entry
references:
- kind: adr
  role: intent
  target: docs/adr/0010-summary-log.md
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.writeSummaryLog
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/SummaryLog.swift#SummaryLog.overLimit
---

# Every Summary's requests and replies are copied to the Summary log while it is kept

One entry per Summary, Retry and Regeneration included and failed ones too, written when the Summary ends. A Summary that never reached the model, and *Test connection*, leave none. Past 5 MB the oldest entries are deleted; the newest always stays.
